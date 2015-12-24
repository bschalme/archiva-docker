# Archiva Docker image

Forked from [olamy/archiva-docker](https://github.com/olamy/archiva-docker) to use the latest version of Archiva.

# Usage

In order to get the logs with `docker logs` the `-t` option needs to be used.

    docker run -t -p 8080:8080 bschalme/archiva

# Building

    docker build -t bschalme/archiva .
