# Используем официальный образ n8n-mcp
FROM ghcr.io/czlonkowski/n8n-mcp:latest

# Устанавливаем рабочую директорию
WORKDIR /app

# Переменные окружения
ENV MCP_MODE=${MCP_MODE:-http}
ENV USE_FIXED_HTTP=${USE_FIXED_HTTP:-true}
ENV AUTH_TOKEN=${AUTH_TOKEN:?AUTH_TOKEN is required for HTTP mode}
ENV NODE_ENV=${NODE_ENV:-production}
ENV LOG_LEVEL=${LOG_LEVEL:-info}
ENV PORT=${PORT:-3000}
ENV NODE_DB_PATH=${NODE_DB_PATH:-/app/data/nodes.db}
ENV REBUILD_ON_START=${REBUILD_ON_START:-false}

# Дополнительные настройки для n8n API (если нужно, раскомментируй)
# ENV N8N_API_URL=${N8N_API_URL}
# ENV N8N_API_KEY=${N8N_API_KEY}
# ENV N8N_API_TIMEOUT=${N8N_API_TIMEOUT:-30000}
# ENV N8N_API_MAX_RETRIES=${N8N_API_MAX_RETRIES:-3}

# Создание папки для базы данных
RUN mkdir -p /app/data

# Открываем нужный порт
EXPOSE ${PORT:-3000}

# Запускаем приложение
CMD ["node", "dist/mcp/index.js"]
