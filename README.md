# Spark sandbox docker image

Docker image to demonstrate basic Spark operations
# Build docker image

```
docker build --pull --rm -f "Dockerfile" -t sparksandbox:latest "."
```

# Run docker container

```
docker run -p 8888:8888 sparksandbox:latest
```