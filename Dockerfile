# syntax=docker/dockerfile:1
FROM busybox

RUN adduser -D static
USER static
WORKDIR /home/static

ENTRYPOINT [ "busybox" ]

EXPOSE 80

CMD ["httpd", "-f", "-v", "-p", "80"]
