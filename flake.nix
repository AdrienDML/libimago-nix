{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        fu.url = "github:numtide/flake-utils";
    };
    
    outputs = { self, fu, nixpkgs }: 
    fu.lib.eachDefaultSystem (system: 
    let
        pkgs = import nixpkgs {inherit system; };
    in
    {
        packages.default = pkgs.stdenv.mkDerivation {
            name = "libimago";
            src = pkgs.fetchgit {
                url = "https://github.com/jtsiomb/libimago";
                sha256 = "Flqp9JYgTJdkUsBCUBvbCuRWYnIOJGGgqcOt9d4rII0=";
            };
            buildInputs = with pkgs; [
                gnumake
                libpng
                libjpeg
            ];
            configurePhase = ''
                ./configure --prefix=$out
                mkdir -p $out/lib
            '';
            buildPhase = ''
                make
            '';

        };
    });
}
