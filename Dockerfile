# Ubuntu based image which includes powershell (pwsh)
FROM mcr.microsoft.com/dotnet/sdk

# Install dependencies
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    curl \
    wget \
    unzip \
    git \
    bash \
    gnupg \
    software-properties-common \
    openjdk-17-jdk \
    libglu1-mesa \
    ca-certificates \
    lsb-release \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install neovim
RUN wget -qO- https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz | tar xzv
ENV PATH="$PATH:/nvim-linux-x86_64/bin"

# Install starship prompt and setup powershell prompt
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes
RUN mkdir -p ~/.config/powershell && echo 'Invoke-Expression (&starship init powershell)' > ~/.config/powershell/profile.ps1

# Install Android SDK Command Line Tools
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"

RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools \
    && curl -o sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip \
    && unzip sdk.zip -d $ANDROID_SDK_ROOT/cmdline-tools \
    && mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && rm sdk.zip

# Install Android SDK packages
RUN yes | sdkmanager --licenses || true && \
    sdkmanager --update && \
    sdkmanager \
        "platform-tools" \
        "platforms;android-34" \
        "build-tools;34.0.0"

# Install Flutter
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="$FLUTTER_HOME/bin:$PATH"


RUN git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME \
    && flutter doctor

# Accept Flutter licenses
RUN yes | flutter doctor --android-licenses || true

# Default shell
CMD pwsh
