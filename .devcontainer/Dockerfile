FROM osrf/ros:rolling-desktop AS rollyrolling

ENV DEBIAN_FRONTEND=noninteractive

RUN set -x && \
  apt update -y -qq && \
  apt install -y -qq \
    sudo \
    apt-utils \
    build-essential g++ \
    pkg-config cmake \
    gdb \
    git \
    wget curl \
    zip unzip tar \
    net-tools iputils-ping \
    nano \
    python3-pip python3-venv \
    # dotnet-runtime-6.0 \
    libeigen3-dev \
    lttng-tools liblttng-ust-dev liblttng-ctl-dev babeltrace2 \
    python3-babeltrace python3-lttng python3-pytest-cov \
    openssh-client \
    terminator tmux \
    htop \
    python3-requests
RUN set -x && \
  apt-get autoremove -y -qq

# non-root user support
ARG USERNAME=ubuntu

RUN set -x && \
  echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
  chmod 0440 /etc/sudoers.d/$USERNAME

WORKDIR /tmp

# Babeltrace
ARG FILENAME=babeltrace2-2.0.6.tar.bz2
RUN wget https://www.efficios.com/files/babeltrace/${FILENAME}
RUN tar -xvjf ${FILENAME}
RUN cd babeltrace2-2.0.6 && \
  BABELTRACE_DEV_MODE=1 BABELTRACE_MINIMAL_LOG_LEVEL=TRACE ./configure --disable-debug-info && \
  make && \
  make install

# nlohmann/json.git
RUN apt update && apt upgrade -y
RUN git clone -b v3.12.0 https://github.com/nlohmann/json.git && \
  mkdir -p json/build && \
  cd json/build && \
  cmake .. && \
  make install

# install process exporter
RUN apt-get update && apt-get install -y wget tar
RUN wget https://github.com/ncabatoff/process-exporter/releases/download/v0.7.7/process-exporter-0.7.7.linux-amd64.tar.gz -O /tmp/process-exporter.tar.gz \
 && tar -xzf /tmp/process-exporter.tar.gz -C /usr/local/bin --strip-components=1 process-exporter-0.7.7.linux-amd64/process-exporter \
 && rm /tmp/process-exporter.tar.gz

# Set the default user. Omit if you want to keep the default as root.
USER $USERNAME
ENV USER=${USERNAME}

# convenience
ENV LD_LIBRARY_PATH="/usr/local/lib"
RUN set -x && \
  echo "alias x='exit'" >> ~/.bash_aliases && \
  echo "alias c='clear'" >> ~/.bash_aliases && \
  touch ~/.sudo_as_admin_successful

WORKDIR /home/${USERNAME}/
CMD ["bash"]
