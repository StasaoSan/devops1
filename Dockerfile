FROM alpine


RUN apk add --no-cache nginx
RUN addgroup -S app && adduser -S -G app app

RUN mkdir -p /var/cache/nginx /var/run/nginx /usr/share/nginx/html \
    /var/cache/nginx/client_temp \
    /var/cache/nginx/proxy_temp \
    /var/cache/nginx/fastcgi_temp \
    /var/cache/nginx/uwsgi_temp \
    /var/cache/nginx/scgi_temp \
 && chown -R app:app /var/cache/nginx /var/run/nginx /usr/share/nginx/html

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/http.d/default.conf

USER app

EXPOSE 8080
CMD ["nginx", "-e", "/dev/stderr", "-g", "daemon off;"]