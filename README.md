# Go Automation Demo

A demonstration project showcasing GitHub Actions, semantic releases, and conventional commits for automated deployment processes.

## 🚀 Features

- **Go Web Server**: Simple HTTP server that serves data from `data.json`
- **Automated Releases**: Semantic versioning based on conventional commits
- **Auto-Approval**: Automatic PR approval for non-critical changes by CODEOWNERS
- **Changelog Generation**: Auto-updated CHANGELOG.md based on PR messages
- **Pre-commit Hooks**: Enforces conventional commit standards

## 🏗️ Architecture

```
├── main.go              # Go web server
├── data.json            # Data source for the API
├── go.mod               # Go module definition
├── .github/workflows/   # GitHub Actions workflows
├── .pre-commit-config.yaml # Pre-commit hooks
├── CODEOWNERS           # File ownership rules
├── CHANGELOG.md         # Auto-generated changelog
└── Makefile            # Build and development commands
```

## 🚀 Quick Start

### Prerequisites
- Go 1.24.4+
- Docker (optional, for containerized deployment)

### Local Development
```bash
# Install dependencies
go mod tidy

# Run the server
make run

# Or directly
go run main.go
```

The server will start on `http://localhost:8080`

### Available Endpoints
- `GET /health` - Health check endpoint
- `GET /data` - Returns data from `data.json`
- `GET /version` - Returns version information

## 🔄 Automation Features

### 1. Semantic Releases
- Automatically creates releases based on conventional commit messages
- Supports: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`
- Updates version tags and release notes

### 2. Auto-Approval System
- Automatically approves PRs containing only non-critical files
- Works when CODEOWNERS are making changes
- Configurable file extensions and specific files

### 3. Changelog Generation
- Auto-updates `CHANGELOG.md` based on merged PR messages
- Maintains chronological order of changes
- Links to relevant PRs and commits

### 4. Pre-commit Hooks
- Enforces conventional commit message format
- Runs before each commit to ensure standards
- Configurable rules and exceptions

## 📝 Conventional Commits

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types
- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples
```bash
git commit -m "feat: add new health check endpoint"
git commit -m "fix: resolve data loading issue"
git commit -m "docs: update API documentation"
git commit -m "chore: update dependencies"
```

## 🔧 Configuration

### GitHub Actions
- **Semantic Release**: `.github/workflows/release.yml`
- **Auto-Approval**: `.github/workflows/auto-approve.yml`
- **Changelog Update**: `.github/workflows/changelog.yml`

### Pre-commit Hooks
- **Conventional Commits**: Enforces commit message format
- **Go Formatting**: Ensures consistent code style
- **Linting**: Basic Go linting rules

## 🚀 Deployment

### Local
```bash
make run
```

### Docker
```bash
make docker-build
make docker-run
```

### Production
The project automatically deploys when:
1. A PR is merged with a conventional commit
2. Semantic release determines a new version
3. GitHub Actions create a new release

## 📊 Monitoring

- Health check endpoint: `GET /health`
- Version information: `GET /version`
- Data status: `GET /data`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes following conventional commits
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

### Commit Message Requirements
- Must follow conventional commit format
- Will be validated by pre-commit hooks
- Affects automatic versioning and changelog generation

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For questions or issues:
1. Check the [CHANGELOG.md](CHANGELOG.md) for recent changes
2. Review GitHub Actions logs for automation issues
3. Open an issue with conventional commit format

---

**Built with ❤️ and automation**
