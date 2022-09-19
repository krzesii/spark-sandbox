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
