FROM debian:trixie-slim as install

ARG DEBIAN_FRONTEND=noninteractive

# install dependencies
RUN apt update && apt upgrade -y \
  && apt install -y --no-install-recommends --no-install-suggests ca-certificates git build-essential python3 python3-dev cargo rustc cbindgen nasm yasm libgtk-3-dev libdbus-1-dev libssl-dev libpulse-dev \
  && rm -rf "/var/lib/apt/lists/*" \
  && rm -rf /var/cache/apt/archives

WORKDIR /build

RUN git clone https://gitlab.com/librewolf-community/browser/source.git librewolf

WORKDIR /build/librewolf

RUN chmod +x ./mach && ./mach build

CMD ["/bin/bash"]
