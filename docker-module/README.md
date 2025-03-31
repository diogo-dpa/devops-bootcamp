# Docker Learning Guide

## What is Docker?

Docker is a platform for developing, shipping, and running applications in containers. Containers are lightweight, portable, and self-sufficient units that can run anywhere Docker is installed.

## Key Concepts

### Container

- Lightweight, standalone executable package
- Contains everything needed to run an application
- Isolated from other containers and the host system

### Image

- Read-only template used to create containers
- Based on a Dockerfile
- Can be stored in and pulled from registries

### Docker Registry

A registry stores Docker images. Types include:

- Docker Hub (public registry)
- Azure Container Registry
- Amazon Elastic Container Registry (ECR)
- Google Container Registry (GCR)
- Self-hosted registries

## Important Commands

### Image Management

```bash
# Build an image
docker build -t my-app:1.0 .

# List images
docker images

# Remove image
docker rmi my-app:1.0

# Pull image from registry
docker pull node:18-slim
```

### Container Management

```bash
# Run a container
docker run -d -p 3000:3000 my-app:1.0

# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop container
docker stop container_id

# Remove container
docker rm container_id
```

### Registry Operations

```bash
# Login to Docker Hub
docker login

# Push image to registry
docker push username/my-app:1.0

# Pull image from registry
docker pull username/my-app:1.0
```

### System Commands

```bash
# Show Docker system info
docker info

# Clean up unused resources
docker system prune

# Show container logs
docker logs container_id
```

## Docker Command Flags

### Build Flags (`docker build`)

```bash
-t, --tag          # Tag the image (name:tag)
-f, --file         # Specify Dockerfile path
--no-cache         # Build without using cache
--build-arg        # Set build-time variables
--target           # Set target build stage
```

Example:

```bash
docker build -t myapp:1.0 --no-cache --build-arg ENV=prod .
```

### Run Flags (`docker run`)

```bash
-d, --detach       # Run container in background
-p, --publish      # Publish container's port to host
-e, --env          # Set environment variables
-v, --volume       # Bind mount a volume
--name             # Assign name to container
--rm               # Remove container when it exits
--network          # Connect to a network
-it                # Interactive terminal
```

Examples:

```bash
# Run with port mapping and environment variable
docker run -d -p 3000:3000 -e NODE_ENV=production myapp:1.0

# Run with volume mount and interactive terminal
docker run -it -v $(pwd):/app myapp:1.0 bash
```

### Common Flag Combinations

```bash
# Development with hot-reload
docker run -it -p 3000:3000 -v $(pwd):/app --rm myapp:1.0

# Production deployment
docker run -d -p 3000:3000 -e NODE_ENV=production --restart always myapp:1.0
```

## Best Practices

1. Use specific image tags instead of `latest`
2. Minimize image layers
3. Use multi-stage builds for smaller images
4. Include `.dockerignore` file
5. Run containers with limited privileges
6. Use environment variables for configuration

## References

- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Docker Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Docker Security](https://docs.docker.com/engine/security/)
