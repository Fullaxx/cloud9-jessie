# ------------------------------------------------------------------------------
# Pull base image
FROM debian:jessie-slim
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C
ENV NODEPKGURL https://nodejs.org/dist/v16.14.2/node-v16.14.2-linux-x64.tar.xz

# ------------------------------------------------------------------------------
# Install base and clean up
RUN apt-get update && apt-get install -y --no-install-recommends \
	  build-essential g++ locales curl git ca-certificates python2.7-minimal && \
	sed -e 's/# en_US.UTF-8/en_US.UTF-8/' -i /etc/locale.gen && locale-gen && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install Cloud9 and clean up
RUN curl -s ${NODEPKGURL} -o /tmp/node.tar.xz && \
	tar xf /tmp/node.tar.xz -C /opt/ && \
	rm /tmp/node.tar.xz && \
	mv /opt/node-* /opt/node && \
	ln -s /opt/node/bin/node /usr/bin/node && \
	ln -s /opt/node/bin/node /usr/bin/nodejs && \
	ln -s /opt/node/bin/npm /usr/bin/npm && \
	git clone https://github.com/c9/core.git /c9 && \
	cd /c9 && ./scripts/install-sdk.sh && \
	rm -rf /opt/node /usr/bin/{node,nodejs,npm} && \
	rm -rf /root/.c9/{libevent-*,ncurses-*,tmux-*} && \
	rm -rf /c9/.git /root/.c9/tmp /root/.npm /root/.node-gyp /tmp/* && \
	mkdir /c9ws

# ------------------------------------------------------------------------------
# Add app.sh
COPY app.sh /app/

# ------------------------------------------------------------------------------
# Add volumes
VOLUME /log
VOLUME /c9ws

# ------------------------------------------------------------------------------
# Expose ports
EXPOSE 80

# ------------------------------------------------------------------------------
# Define default command
CMD ["/app/app.sh"]
