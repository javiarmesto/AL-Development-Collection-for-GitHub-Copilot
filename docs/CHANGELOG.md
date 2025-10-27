# Changelog

All notable changes to the AL Development Collection will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Frontmatter validation improvements for Windows line endings
- Model field to all prompt files for better AI routing

### Changed
- Updated validator to support both Unix and Windows line endings

## [2.2.0] - 2025-10-19

### Added
- **Framework Implementation** - Full AI Native-Instructions Architecture compliance
- **Layer 1: Markdown Prompt Engineering** - Structured semantic markdown throughout all primitives
- **Layer 2: Agent Primitives** - 28 configurable tools (7 Instructions + 14 Workflows + 6 Chat Modes + 1 Guide)
- **Layer 3: Context Engineering** - `applyTo` patterns for modular context loading
- **AGENTS.md Ready** - Prepared for universal context compilation standard
- **Tool Boundaries** - Chat modes with explicit CAN/CANNOT security lists
- Validation script with 34 framework compliance checks

### Changed
- Reorganized documentation to align with AI Native-Instructions Architecture
- Enhanced README with framework architecture diagrams
- Updated all primitives with proper frontmatter metadata
- Improved contribution guidelines with framework-specific guidance

### Deprecated
- None

### Removed
- None

### Fixed
- Frontmatter parsing for cross-platform compatibility
- Collection manifest validation warnings

## [2.1.0] - 2025-10-15

### Added
- Enhanced documentation with practical examples
- Clear separation of concerns across chat modes

### Changed
- Streamlined chat modes from 11 to 6 core strategic modes
- Updated tool count to 24 primitives (simplified structure)
- Improved mode descriptions and use cases

### Removed
- 5 duplicate/overlapping chat modes (moved to archive)
  - al-build-deploy-workflow.md
  - al-debugging-assistant.chatmode.md
  - al-event-manager.chatmode.md
  - al-performance-optimizer.chatmode.md
  - al-test-automator.chatmode.md
  - al-troubleshooter.chatmode.md

## [2.0.0] - 2025-01-15

### Added
- Collection manifest file (`collections/al-development.collection.yml`)
- Validation script (`validate-al-collection.js`)
- Complete GitHub templates (issues and PR)
- SECURITY.md with security policy
- Archive folder for historical files

### Changed
- **BREAKING**: All files renamed to proper extensions
  - `.instructions.md` for instruction files
  - `.prompt.md` for agentic workflow files
  - `.chatmode.md` for chat mode files
- Reorganized documentation structure
- Updated README with new structure

### Fixed
- File naming convention compliance
- Collection manifest structure

## [1.0.0] - 2025-01-15

### Added
- Initial release of AL Development Collection
- 7 instruction files for core AL development guidelines
  - al-guidelines.instructions.md (master hub)
  - al-code-style.instructions.md
  - al-naming-conventions.instructions.md
  - al-performance.instructions.md
  - al-error-handling.instructions.md
  - al-events.instructions.md
  - al-testing.instructions.md
- 14 agentic workflow prompts
  - al-setup.prompt.md
  - al-workspace.prompt.md
  - al-build.prompt.md
  - al-events.prompt.md
  - al-debug.prompt.md
  - al-performance.prompt.md
  - al-permissions.prompt.md
  - al-troubleshoot.prompt.md
  - al-migrate.prompt.md
  - al-pages.prompt.md
  - al-workflow.prompt.md
  - al-spec.create.prompt.md
  - al-performance.triage.prompt.md
  - al-pr.prepare.prompt.md
- 6 chat mode specialists
  - al-orchestrator.chatmode.md (smart router)
  - al-architect.chatmode.md
  - al-debugger.chatmode.md
  - al-tester.chatmode.md
  - al-api.chatmode.md
  - al-copilot.chatmode.md
- Integration guide (copilot-instructions.md)
- Comprehensive documentation
  - README.md
  - CONTRIBUTING.md
  - al-development.md
  - LICENSE (MIT)
- Reference documentation for AI Native-Instructions Architecture

### Framework Compliance
- Implements AI Native-Instructions Architecture
- 3-layer framework: Markdown Prompt Engineering, Agent Primitives, Context Engineering
- Context optimization via `applyTo` patterns
- AGENTS.md compilation ready

---

## Release Notes

### Version Numbering

This project follows [Semantic Versioning](https://semver.org/):
- **MAJOR** version for incompatible API changes or breaking changes
- **MINOR** version for new features in a backward compatible manner
- **PATCH** version for backward compatible bug fixes

### Types of Changes

- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** for vulnerability fixes

### Links

- [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)
- [Repository](https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot)
- [Issues](https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot/issues)
- [Discussions](https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot/discussions)

[Unreleased]: https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot/compare/v2.2.0...HEAD
[2.2.0]: https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot/releases/tag/v1.0.0
