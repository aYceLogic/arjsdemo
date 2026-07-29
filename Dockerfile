FROM nginx:1.27-alpine

COPY . /usr/share/nginx/html/

# Render injects PORT at runtime; default keeps local runs working.
ENV PORT=10000

RUN adduser -D -u 1000 appuser && chown -R 1000:1000 /usr/share/nginx/html

RUN cat > /entrypoint.sh << 'EOF'
#!/bin/sh
set -e

cat > /etc/nginx/conf.d/default.conf << NGINX_CONF
server {
	listen ${PORT};
	listen [::]:${PORT};
	server_name _;

	root /usr/share/nginx/html;
	index index.html;

	location / {
		try_files \$uri \$uri/ /index.html;
	}
}
NGINX_CONF

exec nginx -g 'daemon off;'
EOF

RUN chmod +x /entrypoint.sh

EXPOSE 10000

ENTRYPOINT ["/entrypoint.sh"]
