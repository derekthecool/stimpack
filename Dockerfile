FROM nixos/nix

COPY . /workspace
WORKDIR /workspace

# Run flake-based shell
RUN nix develop \
  --extra-experimental-features "nix-command flakes" \
  --accept-flake-config \
  --impure \
  -c echo "Flake env built"
