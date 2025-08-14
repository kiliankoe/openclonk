{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "openclonk-dev";

  buildInputs =
    with pkgs;
    [
      # Build tools
      cmake
      pkg-config

      # Core dependencies
      SDL2
      libvorbis
      libogg
      libjpeg
      libpng
      freetype
      libepoxy
      tinyxml
      freealut
      curl
      readline
      miniupnpc
      zlib

      # Audio
      openal

      # Qt for the editor (optional)
      qt5.full

      # macOS specific
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Cocoa
      darwin.apple_sdk.frameworks.OpenGL
      darwin.apple_sdk.frameworks.AudioToolbox
      darwin.apple_sdk.frameworks.OpenAL
      darwin.apple_sdk.frameworks.Quartz
      darwin.apple_sdk.frameworks.AppKit
      darwin.apple_sdk.frameworks.CoreServices
      darwin.apple_sdk.frameworks.Foundation
    ];

  shellHook = ''
    echo "OpenClonk development environment loaded"
    echo "Dependencies available: cmake, SDL2, Qt5, and all required libraries"
    echo ""
    echo "To build OpenClonk:"
    echo "  mkdir -p build && cd build"
    echo "  cmake .."
    echo "  make -j$(sysctl -n hw.ncpu)"
    echo ""
  '';
}
