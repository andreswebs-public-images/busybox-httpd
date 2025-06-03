# busybox-httpd

A busybox httpd server for static content.

## Usage

Example:

Add an `index.html`:

```sh
cat > index.html << EOF
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Example Site</title>
  </head>
  <body>
    <p>Example static content.</p>
  </body>
</html>
EOF
```

Run:

```sh
docker run \
    --detach \
    --init \
    --rm \
    --name web \
    --publish 7777:80 \
    --volume $(pwd)/index.html:/home/static/index.html \
    andreswebs/busybox-httpd
```

**Note:** SIGHUP (CTRL+C) doesn't work on busybox sh, so start the container with the `--init` flag to set PID 1 correctly for handling signals.

## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)

## License

This project is licensed under the [Unlicense](UNLICENSE).

## References

"How to use the Busybox Web Server (httpd)" <https://oldforum.puppylinux.com/viewtopic.php?t=117681>

Nischal Subedi, "Building an Ultra-lightweight Web Server with Busybox" (August 2024) <https://blog.yarsalabs.com/hosting-static-content-with-a-small-resource-footprint/>

Florin Lipan, "The smallest Docker image to serve static websites" <https://lipanski.com/posts/smallest-docker-image-static-website>

<https://stackoverflow.com/questions/60533390/why-does-sighup-not-work-on-busybox-sh-in-an-alpine-docker-container>
