# ------------------------------------------------------------------------------
# Pull base image
FROM debian:jessie-slim
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Install base and clean up when done
RUN apt-get update && apt-get install -y --no-install-recommends tmux nodejs \
build-essential g++ curl git ca-certificates python2.7-minimal supervisor && \
apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# symlink /usr/bin/node -> /usr/bin/nodejs
RUN ln -s nodejs /usr/bin/node

# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/c9/core.git /c9 && \
cd /c9 && ./scripts/install-sdk.sh && mkdir /c9ws

# ------------------------------------------------------------------------------
# Add supervisord conf
ADD supervisord.conf /etc/

# ------------------------------------------------------------------------------
# Add volumes
VOLUME /c9ws

# ------------------------------------------------------------------------------
# Expose ports
EXPOSE 80

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]
