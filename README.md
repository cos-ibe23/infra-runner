---

# ☁️ CI/CD with Docker

This project sets up a CI pipeline using GitHub Actions that:

- Builds a Docker image of a static HTML site
- Pushes the image to Docker Hub automatically when changes are pushed to main.

---

### 🧱 Tech Stack

- Docker
- GitHub Actions
- Docker Hub

### 📁 Directory Structure

```bash
ci-docker-push/
├── .github/
│   └── workflows/
│       └── docker-build.yml
├── Dockerfile
├── index.html
├── README.md
```

### 🛠️ Prerequisites

- Docker Hub account
- GitHub repository
- GitHub secrets:
  - DOCKER_USERNAME
  - DOCKER_PASSWORD or DOCKER_TOKEN

### 🔧 Sample Dockerfile

```Dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
```

### 🌐 Sample index.html

```html
<!DOCTYPE html>
<html>
  <head><title>Hello from Docker</title></head>
  <body>
    <h1>Hello, World! 🚀</h1>
    <p>Deployed via GitHub Actions & Docker Hub.</p>
  </body>
</html>
```

### ⚙️ GitHub Actions Workflow
Located at .github/workflows/docker-publish.yml:

```yaml
# .github/workflows/docker-publish.yml
name: Build and Push Docker Image

on:
  push:
    branches:
      - main

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Log in to Docker Hub
        run: echo "${{ secrets.DOCKER_PASSWORD }}" | docker login -u "${{ secrets.DOCKER_USERNAME }}" --password-stdin

      - name: Build Docker image
        run: docker build -t ${{ secrets.DOCKER_USERNAME }}/hello-world-app:latest .

      - name: Push Docker image
        run: docker push ${{ secrets.DOCKER_USERNAME }}/hello-world-app:latest
```
✅ Output
After pushing to main:

Docker image will be built and pushed to your Docker Hub repo: docker.io/your-username/hello-world-app:latest

📌 Notes
Use public Docker Hub repo for simplicity.

Don’t commit secrets — store them as GitHub Actions secrets.
---
