FROM nginx:1.27-alpine

COPY . /usr/share/nginx/html/

EXPOSE 80

RUN adduser -D -u 1000 appuser && chown -R 1000:1000 /usr/share/nginx/html
USER 1000

CMD ["nginx", "-g", "daemon off;"]
