#!/bin/bash

# Go Automation Demo - Demo Script
# This script demonstrates the automation features

set -e

echo "🎭 Go Automation Demo - Showcasing Features"
echo "=========================================="
echo ""

# Check if server is running
if pgrep -f "bin/server" > /dev/null; then
    echo "✅ Server is already running"
else
    echo "🚀 Starting server..."
    make build
    ./bin/server &
    SERVER_PID=$!
    sleep 2
    echo "✅ Server started with PID: $SERVER_PID"
fi

echo ""
echo "🌐 Testing API endpoints..."
echo ""

# Test health endpoint
echo "🏥 Health Check:"
curl -s http://localhost:8080/health | jq '.' 2>/dev/null || curl -s http://localhost:8080/health
echo ""

# Test data endpoint
echo "📊 Data Endpoint:"
curl -s http://localhost:8080/data | jq '.' 2>/dev/null || curl -s http://localhost:8080/data
echo ""

# Test version endpoint
echo "🏷️  Version Endpoint:"
curl -s http://localhost:8080/version | jq '.' 2>/dev/null || curl -s http://localhost:8080/version
echo ""

echo ""
echo "🔧 Automation Features:"
echo "======================"
echo ""

echo "1. 📝 Conventional Commits:"
echo "   - Pre-commit hooks enforce commit message format"
echo "   - Try: git commit -m 'invalid message' (will fail)"
echo "   - Valid: git commit -m 'feat: add new feature'"
echo ""

echo "2. 🤖 Auto-Approval:"
echo "   - PRs with only non-critical files are auto-approved"
echo "   - Works when CODEOWNERS make changes"
echo "   - Non-critical: .md, .txt, .json, .yaml files"
echo ""

echo "3. 🚀 Semantic Releases:"
echo "   - Automatic versioning based on commit types"
echo "   - feat: → minor version bump"
echo "   - fix: → patch version bump"
echo "   - chore/docs/style → patch version bump"
echo ""

echo "4. 📋 Auto-Changelog:"
echo "   - CHANGELOG.md updated automatically"
echo "   - Based on merged PR messages"
echo "   - Links to relevant PRs and commits"
echo ""

echo "5. 🐳 Containerization:"
echo "   - Docker support with health checks"
echo "   - docker-compose for easy development"
echo "   - Production-ready nginx reverse proxy"
echo ""

echo ""
echo "🧪 Running Tests:"
echo "================="
make test

echo ""
echo "📚 Documentation:"
echo "================"
echo "- README.md: Complete project documentation"
echo "- CHANGELOG.md: Auto-updated change log"
echo "- CODEOWNERS: File ownership rules"
echo "- .github/workflows/: GitHub Actions workflows"
echo ""

echo "🎯 Next Steps:"
echo "=============="
echo "1. Push to GitHub repository"
echo "2. Create a PR with conventional commit message"
echo "3. Watch automation in action!"
echo "4. Check GitHub Actions for release process"
echo ""

if [ ! -z "$SERVER_PID" ]; then
    echo "🛑 Stopping demo server..."
    kill $SERVER_PID 2>/dev/null || true
    echo "✅ Demo complete!"
fi

echo ""
echo "🚀 Happy automating!"
