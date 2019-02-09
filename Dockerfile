# ------------------------------------------------------------------------------
# Thanks to https://github.com/kdelfour/cloud9-docker
# Thanks to https://github.com/tghastings/cloud9-docker
# ------------------------------------------------------------------------------
# Pull base image
FROM debian:jessie-slim
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C
ENV NODEPKGURL https://nodejs.org/dist/latest-v0.12.x/node-v0.12.18-linux-x64.tar.xz

# ------------------------------------------------------------------------------
# Install base and clean up
RUN apt-get update && apt-get install -y --no-install-recommends \
build-essential g++ locales curl git ca-certificates supervisor && \
sed -e 's/# en_US.UTF-8/en_US.UTF-8/' -i /etc/locale.gen && locale-gen && \
apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install Cloud9 and clean up
RUN curl -s $NODEPKGURL -o /tmp/node.tar.xz && \
tar xf /tmp/node.tar.xz -C /opt/ && \
rm /tmp/node.tar.xz && \
mv /opt/node-* /opt/node && \
ln -s /opt/node/bin/node /usr/bin/node && \
ln -s /opt/node/bin/node /usr/bin/nodejs && \
ln -s /opt/node/bin/npm /usr/bin/npm && \
git clone https://github.com/c9/core.git /c9 && cd /c9 && \
./scripts/install-sdk.sh && \
rm -rf /opt/node /usr/bin/{node,nodejs,npm} && \
rm -rf /root/.c9/{libevent-*,ncurses-*,tmux-*} && \
rm -rf /c9/.git /root/.c9/tmp /root/.npm /root/.node-gyp && \
rm -rf /tmp/* && mkdir /c9ws

# ------------------------------------------------------------------------------
# Add supervisord conf
ADD supervisord.conf /etc/

# ------------------------------------------------------------------------------
# Add volumes
VOLUME /c9ws

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]
