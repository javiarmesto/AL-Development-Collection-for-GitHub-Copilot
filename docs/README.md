# 📚 AL Development Collection - Documentation

This directory contains the complete documentation for the AL Development Collection, built with MkDocs Material.

## 🌐 View Online Documentation

**Live Documentation:** [https://javiarmesto.github.io/AL_Copilot_Collection/](https://javiarmesto.github.io/AL_Copilot_Collection/)

## 📖 Documentation Structure

```
docs/
├── index.md                    # Main documentation page
├── getting-started.md          # Quick start guide
├── al-development.md           # Complete toolkit overview
├── CONTRIBUTING.md             # Contribution guidelines
├── CHANGELOG.md                # Version history
├── agents/                     # Agent documentation
│   ├── index.md
│   ├── al-orchestrator.agent.md
│   ├── al-architect.agent.md
│   └── ...
├── instructions/               # Instruction documentation
│   ├── index.md
│   ├── al-guidelines.instructions.md
│   └── ...
├── prompts/                    # Workflow documentation
│   ├── index.md
│   ├── al-initialize.prompt.md
│   └── ...
└── framework/                  # Architecture documentation
    ├── overview.md
    └── architecture.md
```

## 🚀 Build Documentation Locally

### Prerequisites

- Python 3.7+
- pip

### Installation

```bash
# Install MkDocs and dependencies
pip install -r ../requirements.txt
```

### Serve Documentation

```bash
# From repository root
mkdocs serve

# Or from docs directory
cd ..
mkdocs serve
```

Open your browser to `http://localhost:8000`

### Build Static Site

```bash
# From repository root
mkdocs build

# Output will be in site/ directory
```

## 📝 Contributing to Documentation

### Adding New Pages

1. Create markdown file in appropriate directory
2. Add entry to `mkdocs.yml` navigation
3. Follow existing structure and formatting
4. Test locally with `mkdocs serve`

### Documentation Standards

- Use clear, concise language
- Include code examples where appropriate
- Follow existing formatting conventions
- Add frontmatter metadata where applicable
- Use semantic markdown (headers, lists, tables)

### File Naming Conventions

- **Agents**: `al-[name].agent.md`
- **Instructions**: `al-[name].instructions.md`
- **Prompts**: `al-[name].prompt.md`
- **General docs**: `lowercase-with-hyphens.md`

## 🎨 Theme and Styling

The documentation uses [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) theme with custom configuration in `mkdocs.yml`:

- Custom colors matching AL/BC branding
- Search functionality
- Navigation tabs
- Social links
- Dark/light mode toggle

## 🔗 Quick Links

- **Main Site**: [Documentation Home](https://javiarmesto.github.io/AL_Copilot_Collection/)
- **GitHub**: [Repository](https://github.com/javiarmesto/AL_Copilot_Collection)
- **Issues**: [Report Issues](https://github.com/javiarmesto/AL_Copilot_Collection/issues)
- **Contributing**: [CONTRIBUTING.md](./CONTRIBUTING.md)

## 📄 License

Documentation is licensed under [MIT License](../LICENSE).

---

*For questions or suggestions about documentation, please [open an issue](https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot/issues).*
