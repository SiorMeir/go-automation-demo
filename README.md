# Go Automation Demo

This is a simple Go API server that demonstrates the benefits of pre-commit hooks and GitHub Actions automation.

## Features

- Simple HTTP API server with `/` and `/health` endpoints
- Automated testing with Ginkgo
- Pre-commit hooks for code quality
- GitHub Actions for CI/CD automation

## Running the Server

```bash
go run main.go
```

The server will start on port 8080.

## Testing

Run tests with Ginkgo:

```bash
 ginkgo -v ./main
```

## Endpoints

- `GET /` - Returns a hello world message
- `GET /health` - Returns health status
- `GET /goodbye` - Returns a goodbye world message
## Automation Features

This project demonstrates:

1. **Pre-commit hooks** - Automatic linting before commits
2. **GitHub Actions** - Automated testing and releases
3. **Auto-approval** - README-only PRs are automatically approved
4. **Semantic releases** - Automatic versioning based on conventional commits
