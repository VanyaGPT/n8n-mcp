# Используем официальный Node.js образ
FROM node:18-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json если есть (опционально)
# COPY package*.json ./

# Устанавливаем n8n-mcp
RUN npm install -g n8n-mcp

# Устанавливаем дополнительные зависимости для HTTP режима
RUN npm install -g @modelcontextprotocol/server-sse

# Создаем пользователя
RUN addgroup -g 1000 n8n && \
    adduser -u 1000 -G n8n -s /bin/sh -D n8n

USER n8n

# Выставляем порт
EXPOSE $PORT

# Переменные окружения
ENV MCP_MODE=http
ENV PORT=8080
ENV LOG_LEVEL=error

# Запускаем в HTTP режиме
CMD ["sh", "-c", "npx n8n-mcp --mode http --port ${PORT:-8080}"]
