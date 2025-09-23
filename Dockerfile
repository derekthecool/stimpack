FROM ubuntu:22.04

# Install dependencies
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
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
    neovim \
    nodejs \
    npm \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

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

# Optional: Install .NET SDK 9
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-9.0 && \
    rm -rf /var/lib/apt/lists/*

# Default shell
CMD [ "bash" ]
