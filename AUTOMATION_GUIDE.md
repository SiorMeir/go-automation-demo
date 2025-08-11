# 🚀 Automation Guide

This document explains how the automation system works in the Go Automation Demo project.

## 🎯 Overview

The project demonstrates a complete automation pipeline using:
- **GitHub Actions** for CI/CD
- **Semantic Releases** for automatic versioning
- **Conventional Commits** for standardized commit messages
- **Auto-approval** for non-critical changes
- **Auto-changelog** generation

## 🔄 Workflow Overview

```
Developer → Conventional Commit → Pre-commit Hooks → 
GitHub PR → Auto-approval Check → Merge → 
Changelog Update → Semantic Release → GitHub Release
```

## 📝 Conventional Commits

### Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types and Impact
- `feat:` → **Minor** version bump (new features)
- `fix:` → **Patch** version bump (bug fixes)
- `docs:` → **Patch** version bump (documentation)
- `style:` → **Patch** version bump (formatting)
- `refactor:` → **Patch** version bump (code changes)
- `test:` → **Patch** version bump (test changes)
- `chore:` → **Patch** version bump (maintenance)

### Examples
```bash
git commit -m "feat: add user authentication system"
git commit -m "fix: resolve memory leak in data processor"
git commit -m "docs: update API documentation"
git commit -m "style: format code according to standards"
```

## 🤖 GitHub Actions Workflows

### 1. Semantic Release (`release.yml`)
**Trigger:** Push to main/master branch
**Purpose:** Automatically create releases based on conventional commits

**Process:**
1. Analyzes commit messages
2. Determines version bump (patch/minor/major)
3. Updates CHANGELOG.md
4. Creates GitHub release
5. Builds and tests application
6. Uploads release assets

### 2. Auto-Approval (`auto-approve.yml`)
**Trigger:** PR opened/updated by CODEOWNERS
**Purpose:** Automatically approve non-critical changes

**Non-Critical Files:**
- Extensions: `.md`, `.txt`, `.json`, `.yaml`, `.yml`
- Specific files: `README.md`, `CHANGELOG.md`, `data.json`, `.gitignore`, `LICENSE`

**Logic:**
- Only works for CODEOWNERS
- Checks if only non-critical files changed
- Auto-approves if criteria met
- Comments on PRs with critical changes

### 3. Changelog Update (`changelog.yml`)
**Trigger:** PR merged to main/master
**Purpose:** Update CHANGELOG.md with new changes

**Process:**
1. Extracts conventional commit info from PR title
2. Categorizes change type
3. Adds entry to appropriate section
4. Links to PR number and URL
5. Commits and pushes changes

## 🔧 Pre-commit Hooks

### Installation
```bash
# Install pre-commit
pip install pre-commit  # or brew install pre-commit

# Install hooks
pre-commit install
pre-commit install --hook-type commit-msg
```

### Hooks Configured
- **Conventional Commits**: Enforces commit message format
- **Go Formatting**: `go fmt` and `goimports`
- **Go Linting**: `golangci-lint`
- **Go Building**: Ensures code compiles
- **File Checks**: YAML, JSON validation, trailing whitespace
- **Markdown Linting**: Ensures documentation quality

## 🚀 Getting Started

### 1. Initial Setup
```bash
# Clone repository
git clone <your-repo-url>
cd go-automation-demo

# Run setup script
./setup.sh
```

### 2. Development Workflow
```bash
# Make changes to code
# ...

# Stage changes
git add .

# Commit with conventional format
git commit -m "feat: add new feature"

# Push and create PR
git push origin feature/new-feature
```

### 3. Automation Triggers
- **Pre-commit**: Runs on every commit
- **Auto-approval**: Triggers on PR creation
- **Changelog**: Updates on PR merge
- **Release**: Creates release on main branch push

## 📊 Monitoring and Debugging

### GitHub Actions
- Check `.github/workflows/` for workflow logs
- Monitor Actions tab in GitHub repository
- Review workflow runs for failures

### Pre-commit Hooks
- Run manually: `pre-commit run --all-files`
- Check `.pre-commit-config.yaml` for configuration
- Review hook output for specific failures

### Local Testing
```bash
# Test application
make test

# Build application
make build

# Run locally
make run

# Docker deployment
make docker-run
```

## 🔒 Security and Permissions

### Required Permissions
- **Repository**: Write access for CODEOWNERS
- **Actions**: Read/write permissions for workflows
- **Contents**: Write access for changelog updates

### Token Requirements
- `GITHUB_TOKEN` for basic actions
- Custom token for changelog updates (if needed)

## 🚨 Troubleshooting

### Common Issues

#### 1. Pre-commit Hooks Fail
```bash
# Reinstall hooks
pre-commit uninstall
pre-commit install
pre-commit install --hook-type commit-msg
```

#### 2. GitHub Actions Fail
- Check workflow syntax
- Verify required secrets
- Review permission settings
- Check branch protection rules

#### 3. Semantic Release Issues
- Verify conventional commit format
- Check `.releaserc.json` configuration
- Review GitHub token permissions

#### 4. Auto-approval Not Working
- Verify CODEOWNERS configuration
- Check if files are marked as critical
- Review workflow conditions

### Debug Commands
```bash
# Check pre-commit configuration
pre-commit run --all-files --verbose

# Test specific hook
pre-commit run conventional-commits --all-files

# Check Go code quality
make lint
make format

# Verify build
make build
make test
```

## 📚 Additional Resources

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Release](https://semantic-release.gitbook.io/)
- [Pre-commit](https://pre-commit.com/)
- [GitHub Actions](https://docs.github.com/en/actions)

## 🤝 Contributing

When contributing to this project:

1. **Follow conventional commits** - All commits must use the standard format
2. **Test locally** - Run `make test` before pushing
3. **Use pre-commit hooks** - They're there to help maintain quality
4. **Check automation** - Verify that your changes trigger appropriate automation

## 🎉 Success Indicators

You'll know the automation is working when:

- ✅ Commits are automatically formatted
- ✅ PRs with non-critical changes are auto-approved
- ✅ CHANGELOG.md updates automatically
- ✅ Releases are created with proper versioning
- ✅ All workflows pass successfully

---

**Happy automating! 🚀**
