FROM nixos/nix

ENV USER=root
ENV HOME=/root
ENV SHELL=/run/current-system/sw/bin/pwsh
ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

COPY dev-packages.nix /etc/dev-packages.nix

RUN nix-env -f /etc/dev-packages.nix -i

CMD ["/root/.nix-profile/bin/pwsh"]
