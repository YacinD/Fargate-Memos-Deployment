# ============================================================
# Stage 1: Build the Memos frontend
# ============================================================

FROM node:24.21.0 AS frontend

WORKDIR /frontend

# Enable pnpm
RUN corepack enable

# Copy frontend dependency files first for better layer caching
COPY app/memos/web/package.json app/memos/web/pnpm-lock.yaml app/memos/web/pnpm-workspace.yaml ./
COPY app/memos/web/patches ./patches

# Install frontend dependencies
RUN pnpm install --frozen-lockfile

# Copy frontend source
COPY app/memos/web/ ./

# Build frontend
RUN pnpm release


# ============================================================
# Stage 2: Build the Memos backend
# ============================================================

FROM golang:1.26.2-alpine AS backend

WORKDIR /backend-build

# Build dependencies
RUN apk add --no-cache git ca-certificates

# Copy Go dependency files first for better layer caching
COPY app/memos/go.mod app/memos/go.sum ./

# Download Go dependencies
RUN go mod download

# Copy Memos backend source
COPY app/memos/ ./

# Copy the compiled frontend assets from Stage 1
COPY --from=frontend /server/router/frontend/dist ./server/router/frontend/dist

# Verify the frontend was copied correctly
RUN test -f server/router/frontend/dist/index.html

# Build Memos
ARG VERSION=dev
ARG COMMIT=unknown

RUN CGO_ENABLED=0 \
    go build \
    -trimpath \
    -ldflags="-s -w -X github.com/usememos/memos/internal/version.Version=${VERSION} -X github.com/usememos/memos/internal/version.Commit=${COMMIT}" \
    -tags netgo,osusergo \
    -o memos \
    ./cmd/memos


# ============================================================
# Stage 3: Runtime image
# ============================================================

FROM alpine:3.21 AS runtime

# Install runtime dependencies and create non-root user
RUN apk add --no-cache ca-certificates tzdata && \
    addgroup -g 10001 -S nonroot && \
    adduser -u 10001 -S -G nonroot -h /var/opt/memos nonroot && \
    mkdir -p /var/opt/memos && \
    chown -R nonroot:nonroot /var/opt/memos

# Copy the compiled Memos binary
COPY --from=backend /backend-build/memos /usr/local/bin/memos

# Memos data directory
VOLUME /var/opt/memos

# Memos listens on port 5230
ENV MEMOS_PORT=5230

EXPOSE 5230

# Run as non-root
USER nonroot

WORKDIR /var/opt/memos

# Start Memos
ENTRYPOINT ["/usr/local/bin/memos"]