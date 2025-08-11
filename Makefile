.PHONY: help build run test clean docker-build docker-run install-deps lint format

# Default target
help:
	@echo "Available commands:"
	@echo "  build        - Build the Go application"
	@echo "  run          - Run the application locally"
	@echo "  test         - Run tests"
	@echo "  clean        - Clean build artifacts"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-run   - Run Docker container"
	@echo "  install-deps - Install Go dependencies"
	@echo "  lint         - Run linters"
	@echo "  format       - Format Go code"

# Build the application
build:
	@echo "Building Go application..."
	@mkdir -p bin
	go build -o bin/server main.go
	@echo "Build complete: bin/server"

# Run the application locally
run: build
	@echo "Starting server on http://localhost:8080"
	@./bin/server

# Run tests
test:
	@echo "Running tests..."
	go test -v ./...

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf bin/
	@go clean

# Build Docker image
docker-build:
	@echo "Building Docker image..."
	docker build -t go-automation-demo:latest .

# Run Docker container
docker-run: docker-build
	@echo "Running Docker container..."
	docker run -p 8080:8080 --rm go-automation-demo:latest

# Install Go dependencies
install-deps:
	@echo "Installing Go dependencies..."
	go mod tidy
	go mod download

# Run linters
lint:
	@echo "Running linters..."
	golangci-lint run

# Format Go code
format:
	@echo "Formatting Go code..."
	go fmt ./...
	goimports -w .

# Install pre-commit hooks
install-hooks:
	@echo "Installing pre-commit hooks..."
	pre-commit install
	pre-commit install --hook-type commit-msg

# Run pre-commit on all files
pre-commit:
	@echo "Running pre-commit hooks..."
	pre-commit run --all-files

# Development mode (auto-reload with air)
dev:
	@echo "Starting development mode with auto-reload..."
	@if command -v air > /dev/null; then \
		air; \
	else \
		echo "Air not found. Install with: go install github.com/cosmtrek/air@latest"; \
		echo "Falling back to regular run..."; \
		make run; \
	fi

# Check if all tools are installed
check-tools:
	@echo "Checking required tools..."
	@command -v go > /dev/null || (echo "Go is not installed" && exit 1)
	@command -v git > /dev/null || (echo "Git is not installed" && exit 1)
	@command -v pre-commit > /dev/null || (echo "Pre-commit is not installed" && exit 1)
	@echo "All required tools are installed!"

# Setup development environment
setup: check-tools install-deps install-hooks
	@echo "Development environment setup complete!"
	@echo "Run 'make run' to start the server"
	@echo "Run 'make dev' for auto-reload development mode"
