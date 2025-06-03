# syntax=docker/dockerfile:1
FROM alpine:3.22.0 AS base
RUN apk add --no-cache gcc musl-dev perl git linux-headers make

FROM base AS build
RUN git clone https://github.com/mirror/busybox.git
WORKDIR /busybox
COPY busybox-httpd-config .config
RUN make -j && make -j install && adduser -D static

FROM scratch AS runtime
WORKDIR /home/static
COPY --from=build /busybox/_install/bin/busybox /busybox
COPY --from=build /etc/passwd /etc/passwd
COPY httpd.conf /httpd.conf
CMD ["/busybox", "httpd", "-p", "80", "-v", "-f", "httpd.conf"]
EXPOSE 80
USER static
