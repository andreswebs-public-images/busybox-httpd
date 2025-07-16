# syntax=docker/dockerfile:1
FROM busybox

RUN adduser -D static
USER static
WORKDIR /home/static

EXPOSE 80

ENTRYPOINT [ "busybox" ]

CMD ["httpd", "-f", "-v", "-p", "80"]
