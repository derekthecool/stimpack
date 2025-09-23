{
  description = "Flutter + Android SDK Dev Shell with Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [];
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };

        pkgs = import nixpkgs {
          inherit system overlays config;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "flutter-android-dev";

          packages = with pkgs; [
            flutter
            androidsdk
            android-tools
            openjdk
            git
            curl
            unzip
            neovim
            bash
            nodejs
            python3
            powershell
            ncurses
          ];

          shellHook = ''
            export ANDROID_HOME=${pkgs.androidsdk}/libexec/android-sdk
            export ANDROID_SDK_ROOT=$ANDROID_HOME
            export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

            echo "[✔] Flutter + Android SDK environment ready"
            flutter doctor || true
          '';
        };
      });
}
