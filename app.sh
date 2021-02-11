#!/bin/sh

NODE_ENV="production"

unset C9AUTH
if [ -n ${C9USER} ] && [ -n ${C9PASS} ]; then
  C9AUTH="-a ${C9USER}:${C9PASS}"
else
  C9AUTH="-a :"
fi

cd /c9
exec /root/.c9/node/bin/node /c9/server.js --listen 0.0.0.0 --port 80 -w /c9ws ${C9AUTH}

# >>/log/c9.log 2>>/log/c9.err
