# @author Derek Lomax

FROM archlinux:base-devel

# Initial system update
run pacman -Syu --noconfirm

# Create new user
RUN useradd -m -G wheel -s /bin/bash nvim \
    && echo 'nvim ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/nvim \
    && chmod 0440 /etc/sudoers.d/nvim

# Activate user
USER nvim

# Set working directory to users home
WORKDIR /home/nvim

# AUR setup
run sudo pacman -S --needed --noconfirm git
run git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm

# # Essential programming languages (python is already included)
# # This list should change less often then the basics list
# # so it should go above.
# run pacman -S --needed --noconfirm \
#     dotnet-sdk \
#     go \
#     lua \
#     nodejs \
#     rust
#
# run pacman -S --needed \
#     fzf \
#     github-cli \
#     neovim \
#     starship \
#     wezterm

# Avoid container exit.
CMD ["tail", "-f", "/dev/null"]
