FROM nixos/nix

ENV USER=root
ENV HOME=/root
ENV SHELL=/run/current-system/sw/bin/pwsh
ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

COPY dev-packages.nix /etc/dev-packages.nix

# RUN nix-env -f /etc/dev-packages.nix -i
# Set env variable for allowing unfree software like android sdk
# RUN NIXPKGS_ALLOW_UNFREE=1 nix-env -f /etc/dev-packages.nix -i

ENV NIXPKGS_ALLOW_UNFREE=1
ENV NIXPKGS_ACCEPT_ANDROID_SDK_LICENSE=1
RUN nix-env -f /etc/dev-packages.nix -i

# Install Android SDK command-line tools manually
ENV ANDROID_HOME=/opt/android-sdk
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin
# Accept licenses and install minimal SDK tools for Flutter
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --licenses && \
    sdkmanager --sdk_root=$ANDROID_HOME \
      "platform-tools" \
      "platforms;android-33" \
      "build-tools;33.0.2"

# CMD ["/root/.nix-profile/bin/pwsh"]
CMD /root/.nix-profile/bin/bash
