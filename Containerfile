FROM debian:trixie-slim as install

ARG DEBIAN_FRONTEND=noninteractive

# install dependencies
RUN apt update && apt upgrade -y \
  && apt install -y --no-install-recommends --no-install-suggests ca-certificates git wget \
  && apt install -y --no-install-recommends --no-install-suggests build-essential python3 python3-dev cargo rustc cbindgen nasm yasm libgtk-3-dev libdbus-1-dev libssl-dev libpulse-dev \
  && rm -rf "/var/lib/apt/lists/*" \
  && rm -rf /var/cache/apt/archives

# add user and set home directory
ARG USER=librewolf
RUN useradd --create-home --shell /bin/bash $USER
USER $USER

WORKDIR /build

RUN git clone --recursive https://codeberg.org/librewolf/source.git librewolf

WORKDIR /build/librewolf

RUN make dir \
  && make bootstrap \
  && make build \
  && make package
  # make run

CMD ["/bin/bash"]
