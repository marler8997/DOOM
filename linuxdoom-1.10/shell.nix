let
    pkgs = platform: [
        platform.glibc
        platform.libgcc
        platform.xorg.libX11
        platform.xorg.libXext

        # dependencies for meson build
        platform.meson
        platform.ninja
        platform.pkgconfig
    ];
    nixpkgs = import <nixpkgs> {};
in
{
    native = nixpkgs.mkShell {
        buildInputs = pkgs nixpkgs;
    };
    i686 = nixpkgs.pkgsi686Linux.mkShell {
        buildInputs = pkgs nixpkgs.pkgsi686Linux;
    };
}
