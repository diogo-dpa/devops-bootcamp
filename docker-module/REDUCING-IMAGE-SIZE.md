# Reducing Docker Image Size

This guide demonstrates techniques to reduce Docker image size using our NestJS application as an example.

## Original Dockerfile

```dockerfile
FROM node:23-alpine3.20 AS build

WORKDIR /usr/src/app

COPY package.json yarn.lock ./
RUN yarn

COPY . .
RUN yarn run build
```

## Optimization Techniques

### 1. Use Multi-Stage Builds

Multi-stage builds allow you to use one stage for building and another for running the application, keeping only necessary files.

### 2. Choose Smaller Base Images

- Use Alpine-based images
- Compare image sizes:
  ```bash
  node:23           # ~1GB
  node:23-slim      # ~200MB
  node:23-alpine    # ~100MB
  ```

### 3. Clean Up in Build Stage

- Remove development dependencies
- Clear package manager cache
- Remove temporary files

### 4. Optimize Dependencies

- Install only production dependencies
- Use `--frozen-lockfile` for deterministic builds
- Clean yarn cache

### 5. Use .dockerignore

```plaintext
node_modules
npm-debug.log
yarn-debug.log
yarn-error.log
.git
.env
.dockerignore
Dockerfile
```

## Optimized Dockerfile

```dockerfile
# Build stage
FROM node:23-alpine3.20 AS build

WORKDIR /usr/src/app

# Copy only package files
COPY package.json yarn.lock ./

# Install dependencies with frozen lockfile
RUN yarn install --frozen-lockfile

# Copy source code
COPY . .

# Build application
RUN yarn run build

# Install production dependencies and clean up
RUN yarn install --production --frozen-lockfile && \
    yarn cache clean

# Production stage
FROM node:23-alpine3.20 AS production

WORKDIR /usr/src/app

# Copy only necessary files from build stage
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules

EXPOSE 3000

CMD ["yarn", "run", "start"]
```

## Size Comparison

Check image sizes:

```bash
# Build original image
docker build -t myapp:original .

# Build optimized image
docker build -t myapp:optimized -f Dockerfile.optimized .

# Compare sizes
docker images | grep myapp
```

## Best Practices Checklist

1. ✅ Use multi-stage builds
2. ✅ Choose Alpine-based images
3. ✅ Install only production dependencies
4. ✅ Clean package manager cache
5. ✅ Include proper .dockerignore
6. ✅ Copy only necessary files
7. ✅ Use --frozen-lockfile for deterministic builds

## References

- [Docker Multi-stage Builds](https://docs.docker.com/build/building/multi-stage/)
- [Docker Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Node.js Docker Best Practices](https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md)
