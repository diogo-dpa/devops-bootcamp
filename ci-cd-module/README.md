# GitHub Actions for CI/CD

This guide covers key concepts, workflow syntax, and practical examples for implementing CI/CD with GitHub Actions.

## Core Concepts

### Workflows

Configuration files (YAML) that define automated processes. They reside in `.github/workflows/` directory.

```yaml
name: CI Pipeline
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: npm test
```

### Events

Triggers that start a workflow:

- `push`: When code is pushed
- `pull_request`: When a PR is opened, updated, etc.
- `schedule`: Using cron syntax
- `workflow_dispatch`: Manual trigger

### Jobs

Groups of steps executed on the same runner.

### Steps

Individual tasks that run commands or use actions.

### Actions

Reusable units of code that perform common tasks.

### Runners

Servers that execute workflows (GitHub-hosted or self-hosted).

## Workflow Syntax

### Basic Structure

```yaml
name: My Workflow
on: [push]
jobs:
  job-name:
    runs-on: ubuntu-latest
    steps:
      - name: Step name
        run: echo "Hello World"
```

### Specifying Event Filters

```yaml
on:
  push:
    branches: [main, development]
    paths:
      - "src/**"
  pull_request:
    branches: [main]
```

### Job Dependencies

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - run: npm test

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - run: npm deploy
```

## Practical Examples

### Node.js CI Pipeline

```yaml
name: Node.js CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [16.x, 18.x, 20.x]

    steps:
      - uses: actions/checkout@v4
      - name: Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm ci
      - run: npm test
```

### Docker Build and Push

```yaml
name: Docker CI/CD

on:
  push:
    branches: [main]

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Login to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: user/app:latest
```

### Deploy to AWS

```yaml
name: Deploy to AWS

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Deploy to Elastic Beanstalk
        run: |
          aws elasticbeanstalk create-application-version \
            --application-name my-app \
            --version-label ${{ github.sha }} \
            --source-bundle S3Bucket="my-bucket",S3Key="app-${{ github.sha }}.zip"
```

## Best Practices

1. **Use Secrets for Sensitive Data**

   ```yaml
   - name: Deploy
     env:
       API_TOKEN: ${{ secrets.API_TOKEN }}
   ```

2. **Cache Dependencies**

   ```yaml
   - uses: actions/cache@v3
     with:
       path: ~/.npm
       key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
   ```

3. **Use Matrix Builds for Testing Multiple Configurations**

   ```yaml
   strategy:
     matrix:
       os: [ubuntu-latest, windows-latest, macos-latest]
       node: [16, 18, 20]
   ```

4. **Reuse Common Steps with Composite Actions**
   Create custom actions for repeated steps.

5. **Implement Environment-Specific Deployments**
   ```yaml
   jobs:
     deploy-staging:
       environment: staging
     deploy-production:
       environment: production
       needs: [deploy-staging]
   ```

## References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Marketplace for Actions](https://github.com/marketplace?type=actions)
- [GitHub Actions Workflow Syntax](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
