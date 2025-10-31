FROM caddy:builder AS builder

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/caddyserver/jsonc-adapter \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddy-dns/tencentcloud \
    --with github.com/caddy-dns/alidns \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/xcaddyplugins/caddy-trusted-cloudfront \
    --with github.com/mholt/caddy-l4 \
    --with github.com/mholt/caddy-ratelimit \
    --with github.com/fabriziosalmi/caddy-waf

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy