# Contributing to AL Development Collection

Thank you for your interest in contributing to the AL Development Collection! This document provides guidelines for contributing **Agent Primitives** following the **[AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)** framework.

## 🏗️ Framework Overview

This collection implements the AI Native-Instructions Architecture with 3 layers:

- **Layer 1: Markdown Prompt Engineering** - Structured instructions using semantic markdown
- **Layer 2: Agent Primitives** - Configurable tools (Instructions, Agentic Workflows, Agents)
- **Layer 3: Context Engineering** - Strategic context management via `applyTo` patterns

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [File Naming Conventions](#file-naming-conventions)
- [Frontmatter Requirements](#frontmatter-requirements)
- [Validation](#validation)
- [Pull Request Process](#pull-request-process)

## 🤝 Code of Conduct

This project follows the [GitHub Community Guidelines](https://docs.github.com/en/site-policy/github-terms/github-community-guidelines). Please be respectful and constructive in all interactions.

## 🎯 How to Contribute

You can contribute three types of **Agent Primitives** (Layer 2):

1. **Instructions** - Auto-applied coding guidelines (`.instructions.md`)
2. **Agentic Workflows** - Task-specific execution processes (`.prompt.md`)
3. **Agents** - Role-based strategic consultants (`.agent.md`)

### Adding Instructions

Instructions are **Markdown Prompt Engineering** (Layer 1) files that customize GitHub Copilot's behavior using `applyTo` patterns (Layer 3).

📖 **See [instructions/index.md](./instructions/index.md) for complete guide to existing instructions.**

1. **Create your file** in `instructions/`
2. **Use naming convention**: `al-[feature].instructions.md`
3. **Include frontmatter** (Context Engineering):
   ```yaml
   ---
   description: 'Brief description of what this instruction provides'
   applyTo: ['**/*.al']  # Context Engineering pattern
   ---
   ```
4. **Structure your content**:
   ```markdown
   # Feature Name

   ## Rule 1: Clear Rule Title

   ### Intent
   Explain what this rule accomplishes and why it matters.

   ### Examples
   Provide good and bad examples.
   ```

### Adding Agentic Workflows

**Agentic Workflows** (formerly called "prompts") are complete execution processes for specific AL development tasks.

📖 **See [prompts/index.md](./prompts/index.md) for complete guide to existing workflows.**

1. **Create your file** in `prompts/`
2. **Use naming convention**: `al-[task].prompt.md`
3. **Include frontmatter**:
   ```markdown
   ---
   mode: 'agent'
   description: 'Brief description of what this prompt does'
   tools: ['al_build', 'al_publish', 'codebase']
   ---
   ```
4. **Structure your prompt**:
   ```markdown
   # Task Title

   Your goal is to accomplish `${input:VariableName}`.

   ## Step 1: First Action
   Clear instructions...

   ## Step 2: Second Action
   Clear instructions...
   ```

### Adding Agents

**Agents** are role-based strategic consultants with defined **Tool Boundaries** (MCP constraints) for specialized AL guidance.

📖 **See [agents/index.md](./agents/index.md) for complete guide to existing modes.**

1. **Create your file** in `agents/`
2. **Use naming convention**: `al-[role].agent.md`
3. **Include frontmatter**:
   ```markdown
   ---
   description: 'Brief description of the agent role'
   tools: ['codebase', 'search', 'usages']
   ---
   ```
4. **Define the persona**:
   ```markdown
   # Role Title - Specialist Name

   You are an expert in [domain] for Business Central.

   ## Core Principles
   - Principle 1
   - Principle 2

   ## Your Capabilities
   - Capability 1
   - Capability 2

   ## Response Style
   - How you communicate
   - What you prioritize
   ```

## 📝 File Naming Conventions

### Instructions
- Format: `al-[feature].instructions.md`
- Examples:
  - ✅ `al-security.instructions.md`
  - ✅ `al-workflows.instructions.md`
  - ❌ `security.md` (missing prefix and suffix)
  - ❌ `AL-Security.instructions.md` (uppercase)

### Prompts
- Format: `al-[task].prompt.md`
- Examples:
  - ✅ `al-deploy.prompt.md`
  - ✅ `al-upgrade.prompt.md`
  - ❌ `deploy.md` (missing prefix and suffix)
  - ❌ `al-deploy.md` (missing .prompt)

### Agents
- Format: `al-[role].agent.md`
- Examples:
  - ✅ `al-security-expert.agent.md`
  - ✅ `al-integration-specialist.agent.md`
  - ❌ `security.md` (missing prefix and suffix)
  - ❌ `al-security.md` (missing .agent)

## 🎨 Frontmatter Requirements

### Instructions
```yaml
---
description: 'Clear description of what this instruction provides'
globs: ["*.al", "*.json"]  # File patterns this applies to
alwaysApply: true          # or false for contextual activation
---
```

### Prompts
```yaml
---
mode: 'agent'
description: 'Clear description of what this prompt accomplishes'
tools: ['tool1', 'tool2', 'tool3']  # AL tools or VS Code tools used
---
```

### Agents
```yaml
---
description: 'Clear description of the agent expertise and role'
tools: ['codebase', 'search', 'usages']  # Tools this mode uses
---
```

## ✅ Validation

Before submitting a pull request:

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Run validation**:
   ```bash
   npm run validate
   ```

3. **Fix any errors or warnings**:
   - Errors must be fixed
   - Warnings should be addressed

4. **Update the collection manifest**:
   - Add your file to `collections/al-development.collection.yml`
   - Use correct `kind`: `instruction`, `prompt`, or `chat-mode`
   - For agents, add `usage` guidance

Example manifest entry:
```yaml
- path: instructions/al-security.instructions.md
  kind: instruction

- path: prompts/al-deploy.prompt.md
  kind: prompt

- path: agents/al-security-expert.agent.md
  kind: agent
  usage: optional
  description: |
    Specializes in AL security patterns and best practices.
    Works best with al-permissions.prompt.md.
```

## 🔄 Pull Request Process

1. **Fork the repository**

2. **Create a feature branch**:
   ```bash
   git checkout -b feature/al-security-instructions
   ```

3. **Make your changes**:
   - Add your file(s)
   - Update `collections/al-development.collection.yml`
   - Update `al-development.md` if adding major features
   - Run validation

4. **Commit with clear messages**:
   ```bash
   git commit -m "Add AL security instructions for authentication patterns"
   ```

5. **Push to your fork**:
   ```bash
   git push origin feature/al-security-instructions
   ```

6. **Open a Pull Request**:
   - Describe what your contribution adds
   - Explain why it's useful
   - Include examples if applicable
   - Reference any related issues

7. **Respond to feedback**:
   - Address review comments
   - Update as needed
   - Re-run validation

## 📖 Content Guidelines

### Writing Style
- **Clear and concise** - Developers should understand quickly
- **Specific to AL** - Focus on Business Central patterns
- **Actionable** - Provide concrete guidance
- **Example-driven** - Show good and bad examples

### Code Examples
- Use realistic AL code
- Show both ✅ good and ❌ bad patterns
- Include comments explaining why
- Follow AL naming conventions

### Testing Your Contribution
1. Copy your file(s) to a test AL project
2. Open relevant AL files
3. Verify Copilot suggestions follow your instructions
4. Test prompts or agents work as expected
5. Ensure no conflicts with existing files

## 🎯 What Makes a Good Contribution

### Good Instruction Files
- ✅ Address a specific AL development practice
- ✅ Provide clear rules with examples
- ✅ Include both good and bad patterns
- ✅ Don't overlap with existing instructions

### Good Prompt Files
- ✅ Solve a common AL development task
- ✅ Use available AL tools effectively
- ✅ Provide step-by-step workflow
- ✅ Include error handling guidance

### Good Agents
- ✅ Fill a gap in existing modes
- ✅ Have clear, focused expertise
- ✅ Provide strategic (not tactical) guidance
- ✅ Complement existing tools

## ❌ What to Avoid

- ❌ Duplicating existing functionality
- ❌ Overly broad or vague instructions
- ❌ Hardcoded values specific to your project
- ❌ Non-AL-specific general programming advice
- ❌ Missing or incomplete frontmatter
- ❌ Incorrect file naming

## 🐛 Reporting Issues

Found a bug or problem?

1. **Check existing issues** first
2. **Create a new issue** with:
   - Clear description of the problem
   - Steps to reproduce
   - Expected vs actual behavior
   - AL version and environment details
   - Screenshots if applicable

## 💡 Suggesting Enhancements

Have an idea for improvement?

1. **Check discussions** first
2. **Create a discussion** or issue:
   - Describe the enhancement
   - Explain the use case
   - Provide examples if possible
   - Consider implementation approach

## 📞 Questions?

- **Documentation**: See [al-development.md](./al-development.md)
- **Discussions**: Use GitHub Discussions
- **Issues**: For bugs or specific problems

## 🙏 Thank You!

Your contributions help make AL development easier for everyone. We appreciate:
- Clear, well-documented contributions
- Thoughtful code reviews
- Constructive feedback
- Sharing knowledge

---

**Happy Contributing!** 🚀

Last Updated: 2025-01-15 08:19:35 UTC