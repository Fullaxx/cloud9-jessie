# ------------------------------------------------------------------------------
# Pull base image.
FROM debian:jessie-slim
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Install base
RUN apt-get update && apt-get install -y --no-install-recommends tmux nodejs \
build-essential g++ curl git ca-certificates python2.7-minimal supervisor

# ------------------------------------------------------------------------------
# symlink node -> nodejs
RUN ln -s nodejs /usr/bin/node

# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/c9/core.git /c9
WORKDIR /c9
RUN scripts/install-sdk.sh

# ------------------------------------------------------------------------------
# Add supervisord conf
ADD supervisord.conf /etc/

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /c9ws
VOLUME /c9ws

# ------------------------------------------------------------------------------
# Clean up APT when done.
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]
