# ─── builder ───────────────────────────────────────────────────────────────────
FROM node:22-bookworm-slim AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY tsconfig.json ./
COPY src/ ./src/

RUN npm run build

# ─── runtime ───────────────────────────────────────────────────────────────────
FROM node:22-bookworm-slim AS runtime

ENV NODE_ENV=production

WORKDIR /app

# Non-root user for security
RUN addgroup --system --gid 1001 mcp && \
    adduser --system --uid 1001 --ingroup mcp mcp

COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY --from=builder /app/dist ./dist

USER mcp

# MCP uses stdio transport — no port is exposed.
# This container is intended to be run by MCP clients (e.g., Claude Desktop, Cursor).
# Do NOT add EXPOSE or an HTTP health check here.
CMD ["node", "dist/index.js"]
