let
    pkgs = platform: [
        # adds autoPatchelf in case I need to patch the final exe
        platform.autoPatchelfHook

        #not sure this is needed for the zig version
        #platform.glibc
        #platform.libgcc
        platform.xorg.libX11
        platform.xorg.libXext

        # dependnecies for zig build
        platform.pkgconfig
        # using musl because of a bug with glibc: https://github.com/ziglang/zig/issues/4926
        # however, my x11 libs don't seem to work with musl linker, can't find certain symbols
        platform.musl

        # dependencies for meson build
        #platform.meson
        #platform.ninja
        #platform.pkgconfig
    ];
    nixpkgs = import <nixpkgs> {};
    pkgsArm64 = nixpkgs.pkgsCross.aarch64-multiplatform;
in
{
    native = nixpkgs.mkShell {
        buildInputs = pkgs nixpkgs;
    };
    i686 = nixpkgs.pkgsi686Linux.mkShell {
        buildInputs = pkgs nixpkgs.pkgsi686Linux;
    };
    arm64 = pkgsArm64.mkShell {
        buildInputs = pkgs pkgsArm64;
    };
}
