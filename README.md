# Install instructions

## Clone repository

```
git clone https://github.com/krzesii/spark-sandbox.git
```

## Build docker image

```
docker build --pull --rm -f "Dockerfile" -t sparksandbox:latest "."
```

## Run docker container

```
docker run -p 8888:8888 sparksandbox:latest
```

# References

This repository contains collection of examples sourced from multiple sources with some modifications, for details please see [references.md](notebooks/references.md)
