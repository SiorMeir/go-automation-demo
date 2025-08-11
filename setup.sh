#!/bin/bash

# Go Automation Demo - Setup Script
# This script sets up the development environment

set -e

echo "🚀 Setting up Go Automation Demo..."

# Check if Go is installed
if ! command -v go &> /dev/null; then
    echo "❌ Go is not installed. Please install Go 1.24.4+ first."
    echo "   Visit: https://golang.org/dl/"
    exit 1
fi

# Check Go version
GO_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
echo "✅ Go version: $GO_VERSION"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

# Check if pre-commit is installed
if ! command -v pre-commit &> /dev/null; then
    echo "📦 Installing pre-commit..."
    if command -v pip &> /dev/null; then
        pip install pre-commit
    elif command -v pip3 &> /dev/null; then
        pip3 install pre-commit
    elif command -v brew &> /dev/null; then
        brew install pre-commit
    else
        echo "❌ Could not install pre-commit automatically."
        echo "   Please install it manually: https://pre-commit.com/#install"
        exit 1
    fi
fi

echo "✅ Pre-commit installed"

# Install Go dependencies
echo "📦 Installing Go dependencies..."
go mod tidy
go mod download

# Install pre-commit hooks
echo "🔧 Installing pre-commit hooks..."
pre-commit install
pre-commit install --hook-type commit-msg

# Install Node.js dependencies (for semantic-release)
if command -v npm &> /dev/null; then
    echo "📦 Installing Node.js dependencies..."
    npm install
else
    echo "⚠️  npm not found. Node.js dependencies will be installed by GitHub Actions."
fi

# Build the application
echo "🔨 Building the application..."
go build -o bin/server main.go

# Run tests
echo "🧪 Running tests..."
go test -v

echo ""
echo "🎉 Setup complete! Your Go Automation Demo is ready."
echo ""
echo "📋 Available commands:"
echo "   make run          - Start the server"
echo "   make test         - Run tests"
echo "   make build        - Build the application"
echo "   make docker-run   - Run with Docker"
echo "   make help         - Show all available commands"
echo ""
echo "🌐 Server will be available at: http://localhost:8080"
echo "📚 Check README.md for more information"
echo ""
echo "🚀 Happy coding!"
