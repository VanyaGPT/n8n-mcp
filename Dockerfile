# railway-optimized dockerfile for n8n-mcp
# pulls the already‑built lightweight runtime image, so railway only has to download, not compile
from ghcr.io/czlonkowski/n8n-mcp:latest

# railway injects $PORT at runtime; forward it to the app (mcp uses 3000 by default)
env PORT=${PORT:-3000}

# switch the mcp server to http mode so it can listen for requests from the internet
# you **must** set an AUTH_TOKEN or AUTH_TOKEN_FILE in railway variables to pass the entrypoint check
env MCP_MODE=http

# optional noise reduction
env LOG_LEVEL=info

# mark that we’re running inside a container for internal heuristics
env IS_DOCKER=true

# expose the port for clarity (railway ignores this, but devs appreciate the hint)
expose 3000

# reuse the upstream entrypoint which sets up the database and validation
entrypoint ["/usr/local/bin/docker-entrypoint.sh"]

# explicit cmd in case you override the entrypoint somewhere else
cmd ["node","dist/mcp/index.js"]
