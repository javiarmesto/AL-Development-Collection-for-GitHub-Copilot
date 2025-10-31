# 📦 Publishing to NPM - Quick Guide

This guide explains how to publish the AL Development Collection to npm.

## Prerequisites

1. **npm Account**
   - Create account at [npmjs.com](https://www.npmjs.com/signup)
   - Verify email address

2. **npm CLI Logged In**
   ```bash
   npm login
   # Enter username, password, and email
   ```

3. **Package Name Available**
   - Check: https://www.npmjs.com/package/al-development-collection
   - If taken, update `name` in package.json

## Pre-Publication Checklist

- [ ] Update version in `package.json` (follow [Semantic Versioning](https://semver.org/))
- [ ] Update `CHANGELOG.md` with new version and date
- [ ] Run validation: `npm run validate`
- [ ] Test installer locally: `node install.js install ./test-install`
- [ ] Review `.npmignore` - ensure only necessary files included
- [ ] Update README.md if needed
- [ ] Commit all changes

## Publishing Steps

### 1. Version Bump

```bash
# Patch release (2.3.0 -> 2.3.1) - bug fixes
npm version patch

# Minor release (2.3.0 -> 2.4.0) - new features, backward compatible
npm version minor

# Major release (2.3.0 -> 3.0.0) - breaking changes
npm version major
```

This automatically:
- Updates `package.json` version
- Creates git tag
- Commits changes

### 2. Publish to npm

```bash
# Dry run first (see what would be published)
npm publish --dry-run

# Review the output, then publish
npm publish

# For scoped packages (if using @username/package-name)
npm publish --access public
```

### 3. Post-Publication

```bash
# Push to GitHub
git push
git push --tags

# Verify publication
npm view al-development-collection

# Test installation
npm install -g al-development-collection
npx al-collection --help
```

## Package Contents

The following are included in the npm package (via `files` in package.json):

```
al-development-collection/
├── agents/              # All agent files
├── instructions/        # All instruction files
├── prompts/            # All prompt files
├── install.js          # Installation script
├── validate-al-collection.js  # Validation script
├── README.md           # Main documentation
├── LICENSE             # MIT license
├── CHANGELOG.md        # Version history
└── package.json        # Package metadata
```

## What Gets Excluded

Via `.npmignore`:
- `docs/` - Documentation site (users access online)
- `references/` - Development references
- `archive/` - Archived files
- `.github/` - GitHub-specific files
- `collections/` - GitHub Copilot collection metadata
- `node_modules/` - Dependencies
- Development configuration files

## Version Numbering Strategy

Following [Semantic Versioning](https://semver.org/):

- **MAJOR** (X.0.0) - Breaking changes
  - Changing file structure users depend on
  - Removing agents, instructions, or prompts
  - Changing installation process incompatibly

- **MINOR** (0.X.0) - New features, backward compatible
  - Adding new agents, instructions, or prompts
  - Enhancing existing features
  - Improving documentation

- **PATCH** (0.0.X) - Bug fixes
  - Fixing errors in existing files
  - Documentation corrections
  - Security patches

## Unpublishing (Emergency Only)

```bash
# Unpublish specific version (within 72 hours)
npm unpublish al-development-collection@2.3.0

# Unpublish all versions (discouraged)
npm unpublish al-development-collection --force
```

⚠️ **Warning**: Unpublishing is discouraged. Use `npm deprecate` instead:

```bash
npm deprecate al-development-collection@2.3.0 "Use version 2.3.1 instead"
```

## Testing Before Publication

### Local Installation Test

```bash
# Create test directory
mkdir test-install
cd test-install

# Install from local package
npm install ../AL-Development-Collection-for-GitHub-Copilot

# Test installer
npx al-collection install

# Verify files copied
ls .github/copilot/
```

### Package Contents Test

```bash
# See what will be included
npm pack --dry-run

# Create actual tarball for review
npm pack
tar -tzf al-development-collection-2.3.0.tgz
```

## Automation (Optional)

Consider using GitHub Actions for automated publishing:

```yaml
# .github/workflows/publish.yml
name: Publish to npm

on:
  release:
    types: [created]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          registry-url: 'https://registry.npmjs.org'
      - run: npm install
      - run: npm run validate
      - run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

## Troubleshooting

### "Package name already exists"
- Choose different name in package.json
- Or use scoped package: `@username/al-development-collection`

### "You must verify your email"
- Check npm account email
- Verify through link sent by npm

### "You need to authorize this machine"
- Run `npm login` again
- Enable 2FA if required by npm

### "Forbidden - must change version"
- Cannot republish same version
- Bump version: `npm version patch`

## Resources

- [npm Publishing Guide](https://docs.npmjs.com/packages-and-modules/contributing-packages-to-the-registry)
- [Semantic Versioning](https://semver.org/)
- [npm CLI Documentation](https://docs.npmjs.com/cli/v9)
- [Package.json Documentation](https://docs.npmjs.com/cli/v9/configuring-npm/package-json)

---

**Ready to publish?** Follow the checklist above and run `npm publish`! 🚀
