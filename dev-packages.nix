let
  # Use a nixpkgs revision that has dotnet-sdk_9
  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/641d909c4a7538f1539da9240dedb1755c907e40.tar.gz";
    # optionally provide a hash to validate; omit for now or compute locally
  }) {};
in
with pkgs;

[
  # .NET 9 SDK
  dotnetCorePackages.sdk_9_0

  # Flutter and Android development
  flutter
  android-tools
  androidsdk

  # Other needed tools
  rustup
  python3
  neovim
  git
  nodejs
  pkg-config
  curl
  unzip
  which
  powershell
  ncurses
]
