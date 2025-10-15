# 🧪 AL Development Collection - Test Plan

**Version**: 2.0  
**Last Updated**: 2025-10-15 08:38:41 UTC  
**Tester**: javiarmesto

## 📋 Test Overview

This test plan covers all aspects of the AL Development Collection to ensure everything works correctly before publication.

**Total Tests**: 45  
**Estimated Time**: 2-3 hours  
**Required**: AL project in VS Code with GitHub Copilot

---

## ✅ Pre-Test Checklist

Before starting tests, verify:

- [ ] Visual Studio Code installed (latest version)
- [ ] AL Language extension installed
- [ ] GitHub Copilot extension active
- [ ] Node.js 14+ installed (for validation tests)
- [ ] Test AL project available
- [ ] All collection files present in repository

---

## 🎯 Test Categories

1. [File Structure Tests](#1-file-structure-tests) (5 tests)
2. [Installation Tests](#2-installation-tests) (8 tests)
3. [Instruction Files Tests](#3-instruction-files-tests) (7 tests)
4. [Prompt Files Tests](#4-prompt-files-tests) (10 tests)
5. [Chat Mode Tests](#5-chat-mode-tests) (6 tests)
6. [Integration Tests](#6-integration-tests) (5 tests)
7. [Validation Tests](#7-validation-tests) (4 tests)

**Total**: 45 tests

---

## 1. File Structure Tests

### Test 1.1: Verify Directory Structure
**Objective**: Ensure all required directories exist

**Steps**:
```bash
# Run from collection root
ls -la .github/instructions/
ls -la .github/copilot-prompts/
ls -la chatmodes/
ls -la collections/
```

**Expected Result**:
- [ ] `.github/instructions/` exists with 7 files
- [ ] `.github/copilot-prompts/` exists with 10 files
- [ ] `chatmodes/` exists with 6 files
- [ ] `collections/` exists with 1 file

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 1.2: Verify Instruction Files
**Objective**: All instruction files present with correct extensions

**Steps**:
```bash
cd .github/instructions/
ls -1 *.instructions.md
```

**Expected Result**:
```
al-code-style.instructions.md
al-error-handling.instructions.md
al-events.instructions.md
al-guidelines.instructions.md
al-naming-conventions.instructions.md
al-performance.instructions.md
al-testing.instructions.md
```

**Count**: 7 files

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 1.3: Verify Prompt Files
**Objective**: All prompt files present with correct extensions

**Steps**:
```bash
cd .github/copilot-prompts/
ls -1 *.prompt.md
```

**Expected Result**:
```
al-build.prompt.md
al-debug.prompt.md
al-events.prompt.md
al-migrate.prompt.md
al-pages.prompt.md
al-performance.prompt.md
al-permissions.prompt.md
al-troubleshoot.prompt.md
al-workflow.prompt.md
al-workspace.prompt.md
```

**Count**: 10 files

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 1.4: Verify Chat Mode Files
**Objective**: All chat mode files present with correct extensions

**Steps**:
```bash
cd chatmodes/
ls -1 *.chatmode.md
```

**Expected Result**:
```
al-api.chatmode.md
al-architect.chatmode.md
al-copilot.chatmode.md
al-debugger.chatmode.md
al-orchestrator.chatmode.md
al-tester.chatmode.md
```

**Count**: 6 files

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 1.5: Verify Documentation Files
**Objective**: All documentation present

**Steps**:
```bash
ls -1 *.md *.yml
```

**Expected Result**:
- [ ] `al-development.md` exists
- [ ] `COLLECTION-SUMMARY.md` exists
- [ ] `copilot-instructions.md` exists
- [ ] `INSTALLATION.md` exists
- [ ] `INSTALACION.md` exists
- [ ] `README.md` exists
- [ ] `CONTRIBUTING.md` exists
- [ ] `collections/al-development.collection.yml` exists

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

## 2. Installation Tests

### Test 2.1: Automatic Installation Script
**Objective**: Verify install.sh works correctly

**Setup**: Create a test AL project
```bash
mkdir -p ~/test-al-project
cd ~/test-al-project
echo '{"id":"test","name":"Test","version":"1.0.0.0"}' > app.json
```

**Steps**:
```bash
cd /path/to/al-development-collection
chmod +x install.sh
./install.sh ~/test-al-project
```

**Expected Result**:
- [ ] Script runs without errors
- [ ] Creates `.github/instructions/` directory
- [ ] Creates `.github/copilot-prompts/` directory
- [ ] Creates `chatmodes/` directory
- [ ] Creates `collections/` directory
- [ ] Copies all 7 instruction files
- [ ] Copies all 10 prompt files
- [ ] Copies all 6 chat mode files
- [ ] Copies collection manifest
- [ ] Shows success message

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

**Notes**:
```
[Write any issues or observations here]
```

---

### Test 2.2: Installation with Existing Files
**Objective**: Verify installer handles existing files

**Steps**:
```bash
# Create a dummy copilot-instructions.md
echo "# Existing" > ~/test-al-project/copilot-instructions.md

# Run installer again
./install.sh ~/test-al-project
```

**Expected Result**:
- [ ] Installer prompts for overwrite
- [ ] Allows user to choose (y/n)
- [ ] Respects user choice

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 2.3: Installation Directory Validation
**Objective**: Verify installer validates target directory

**Steps**:
```bash
# Test with non-existent directory
./install.sh /non/existent/path
```

**Expected Result**:
- [ ] Shows error message
- [ ] Exits gracefully
- [ ] Suggests correct usage

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 2.4: Manual Installation - Linux/Mac
**Objective**: Verify manual copy commands work

**Steps**:
```bash
# Create new test directory
mkdir -p ~/test-manual-install
cd ~/test-manual-install
mkdir -p .github/instructions .github/copilot-prompts chatmodes collections

# Copy files manually
cp /path/to/collection/.github/instructions/*.instructions.md .github/instructions/
cp /path/to/collection/.github/copilot-prompts/*.prompt.md .github/copilot-prompts/
cp /path/to/collection/chatmodes/*.chatmode.md chatmodes/
cp /path/to/collection/collections/al-development.collection.yml collections/
```

**Expected Result**:
- [ ] All files copied successfully
- [ ] Correct file counts in each directory
- [ ] No permission errors

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 2.5: Manual Installation - Windows PowerShell
**Objective**: Verify Windows installation commands

**Steps** (on Windows):
```powershell
# Create test directory
New-Item -ItemType Directory -Path "C:\test-manual-install"
cd C:\test-manual-install
New-Item -ItemType Directory -Path ".github\instructions"
New-Item -ItemType Directory -Path ".github\copilot-prompts"
New-Item -ItemType Directory -Path "chatmodes"
New-Item -ItemType Directory -Path "collections"

# Copy files
Copy-Item C:\path\to\collection\.github\instructions\*.instructions.md .github\instructions\
Copy-Item C:\path\to\collection\.github\copilot-prompts\*.prompt.md .github\copilot-prompts\
Copy-Item C:\path\to\collection\chatmodes\*.chatmode.md chatmodes\
Copy-Item C:\path\to\collection\collections\al-development.collection.yml collections\
```

**Expected Result**:
- [ ] All files copied successfully
- [ ] Correct file counts
- [ ] No errors

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 2.6: VS Code Reload After Installation
**Objective**: Verify VS Code recognizes installed files

**Steps**:
1. Open test project in VS Code
2. Press `Ctrl+Shift+P`
3. Run: `Developer: Reload Window`
4. Wait for reload

**Expected Result**:
- [ ] VS Code reloads without errors
- [ ] No error messages in console
- [ ] Copilot remains active

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 2.7: Single Project Settings.json Method
**Objective**: Verify remote URL method works

**Steps**:
1. Create `.vscode/settings.json` in test project
2. Add remote instruction URLs
3. Reload VS Code

**Expected Result**:
- [ ] Settings saved successfully
- [ ] No JSON syntax errors
- [ ] Copilot loads instructions from URLs

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 2.8: Uninstallation/Cleanup
**Objective**: Verify files can be removed cleanly

**Steps**:
```bash
cd ~/test-al-project
rm -rf .github/instructions .github/copilot-prompts chatmodes collections
rm copilot-instructions.md
```

**Expected Result**:
- [ ] All collection files removed
- [ ] Project files remain intact
- [ ] app.json still present

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

## 3. Instruction Files Tests

### Test 3.1: al-guidelines.instructions.md
**Objective**: Verify main guidelines file is valid

**Steps**:
1. Open file in VS Code
2. Check frontmatter
3. Verify content structure

**Checklist**:
- [ ] Has valid YAML frontmatter
- [ ] `description` field present
- [ ] `globs` field present with `["*.al"]`
- [ ] `alwaysApply` field present
- [ ] Content has clear headings
- [ ] References other instruction files
- [ ] No broken links

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 3.2: al-code-style.instructions.md
**Objective**: Verify code style instructions

**Steps**:
1. Open file
2. Check frontmatter
3. Verify rules and examples

**Checklist**:
- [ ] Valid frontmatter
- [ ] Has Rule 1, 2, 3, 4
- [ ] Each rule has Intent section
- [ ] Each rule has Examples section
- [ ] Good and bad examples present
- [ ] Code blocks properly formatted

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 3.3: al-naming-conventions.instructions.md
**Objective**: Verify naming rules

**Checklist**:
- [ ] Valid frontmatter
- [ ] Covers object naming
- [ ] Covers file naming
- [ ] Covers variable naming
- [ ] 26-character limit mentioned
- [ ] Examples for each rule

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 3.4: al-performance.instructions.md
**Objective**: Verify performance guidelines

**Checklist**:
- [ ] Valid frontmatter
- [ ] Early filtering rule
- [ ] SetLoadFields usage
- [ ] Temporary tables guidance
- [ ] Loop optimization
- [ ] Code examples present

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 3.5: al-error-handling.instructions.md
**Objective**: Verify error handling patterns

**Checklist**:
- [ ] Valid frontmatter
- [ ] `alwaysApply: false` (contextual)
- [ ] TryFunction pattern
- [ ] Error labels guidance
- [ ] Telemetry instructions
- [ ] Examples of good/bad patterns

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 3.6: al-events.instructions.md
**Objective**: Verify event patterns

**Checklist**:
- [ ] Valid frontmatter
- [ ] `alwaysApply: false` (contextual)
- [ ] Event subscriber patterns
- [ ] Integration event creation
- [ ] Handler suffix naming
- [ ] Parameter best practices

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 3.7: al-testing.instructions.md
**Objective**: Verify testing guidelines

**Checklist**:
- [ ] Valid frontmatter
- [ ] AL-Go structure explained
- [ ] App vs Test separation
- [ ] Test generation rules
- [ ] Library codeunit usage
- [ ] Given/When/Then pattern

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

## 4. Prompt Files Tests

### Test 4.1: al-workspace.prompt.md
**Objective**: Verify workspace setup prompt works

**Steps**:
1. Open test AL project in VS Code
2. Open Copilot Chat (`Ctrl+I`)
3. Type: `@workspace use al-workspace`

**Expected Result**:
- [ ] Prompt is recognized
- [ ] Copilot responds with setup guidance
- [ ] Mentions tools: al_new_project, al_go, al_download_symbols
- [ ] Provides step-by-step workflow

**Actual Result**:
```
[Paste Copilot's response here]
```

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 4.2: al-build.prompt.md
**Objective**: Verify build/deploy prompt

**Steps**:
```
@workspace use al-build
```

**Expected Result**:
- [ ] Prompt recognized
- [ ] Asks about deployment type
- [ ] Mentions: al_build, al_package, al_publish
- [ ] Provides different workflows for dev/test/prod

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 4.3: al-events.prompt.md
**Objective**: Verify event implementation prompt

**Steps**:
```
@workspace use al-events
```

**Expected Result**:
- [ ] Prompt recognized
- [ ] Mentions al_insert_event
- [ ] Mentions al_open_Event_Recorder
- [ ] Provides event patterns
- [ ] Explains subscriber/publisher

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 4.4: al-debug.prompt.md
**Objective**: Verify debugging prompt

**Steps**:
```
@workspace use al-debug
```

**Expected Result**:
- [ ] Prompt recognized
- [ ] Mentions debugging tools
- [ ] Covers snapshot debugging
- [ ] Explains agent debugging
- [ ] Provides workflow

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 4.5: al-performance.prompt.md
**Objective**: Verify performance analysis prompt

**Steps**:
```
@workspace use al-performance
```

**Expected Result**:
- [ ] Prompt recognized
- [ ] Mentions al_generate_cpu_profile_file
- [ ] Covers AL0896 error
- [ ] Optimization suggestions
- [ ] Cleanup steps

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 4.6: al-permissions.prompt.md
**Objective**: Verify permission generation prompt

**Steps**:
```
@workspace use al-permissions
```

**Expected Result**:
- [ ] Prompt recognized
- [ ] Mentions both AL and XML generation
- [ ] Explains permission structure
- [ ] Security best practices
- [ ] Role-based approach

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 4.7: al-troubleshoot.prompt.md
**Objective**: Verify troubleshooting prompt

**Steps**:
```
@workspace use al-troubleshoot
```

**Expected Result**:
- [ ] Prompt recognized
- [ ] Covers authentication issues
- [ ] Symbol problems
- [ ] Build errors
- [ ] Common solutions

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 4.8: al-migrate.prompt.md
**Objective**: Verify migration prompt

**Steps**:
```
@workspace use al-migrate
```

**Expected Result**:
- [ ] Prompt recognized
- [ ] Version upgrade guidance
- [ ] Breaking changes handling
- [ ] Dependency management
- [ ] Testing strategy

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 4.9: al-pages.prompt.md
**Objective**: Verify page designer prompt

**Steps**:
```
@workspace use al-pages
```

**Expected Result**:
- [ ] Prompt recognized
- [ ] Mentions al_open_Page_Designer
- [ ] Page types explained
- [ ] Customization patterns
- [ ] Best practices

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 4.10: al-workflow.prompt.md
**Objective**: Verify complete workflow prompt

**Steps**:
```
@workspace use al-workflow
```

**Expected Result**:
- [ ] Prompt recognized
- [ ] End-to-end guidance
- [ ] Multiple phases
- [ ] References other prompts
- [ ] Complete feature development

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

## 5. Chat Mode Tests

### Test 5.1: al-orchestrator.chatmode.md
**Objective**: Verify orchestrator mode works

**Steps**:
1. Open Copilot Chat
2. Type: `Use al-orchestrator mode`
3. Wait for confirmation
4. Ask: `I need to build a sales approval workflow`

**Expected Result**:
- [ ] Mode switch confirmed
- [ ] Analyzes the request
- [ ] Provides strategic guidance
- [ ] Recommends other modes/prompts
- [ ] Gives phase-by-phase roadmap

**Actual Response**:
```
[Paste response here]
```

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 5.2: al-architect.chatmode.md
**Objective**: Verify architect mode

**Steps**:
```
Use al-architect mode
I need to design a multi-company approval workflow
```

**Expected Result**:
- [ ] Mode recognized
- [ ] Asks strategic questions
- [ ] Focuses on design not implementation
- [ ] Considers architecture patterns
- [ ] Provides data model guidance

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 5.3: al-debugger.chatmode.md
**Objective**: Verify debugger mode

**Steps**:
```
Use al-debugger mode
My event subscriber isn't firing
```

**Expected Result**:
- [ ] Mode recognized
- [ ] Systematic diagnosis approach
- [ ] Asks clarifying questions
- [ ] Suggests debugging steps
- [ ] Root cause focus

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 5.4: al-tester.chatmode.md
**Objective**: Verify tester mode

**Steps**:
```
Use al-tester mode
I need to test sales posting logic
```

**Expected Result**:
- [ ] Mode recognized
- [ ] Test strategy focus
- [ ] TDD approach
- [ ] Test scenarios suggested
- [ ] Library codeunit usage

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 5.5: al-api.chatmode.md
**Objective**: Verify API mode

**Steps**:
```
Use al-api mode
I need to create an API for mobile app
```

**Expected Result**:
- [ ] Mode recognized
- [ ] API design focus
- [ ] RESTful patterns
- [ ] Authentication guidance
- [ ] Versioning strategy

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 5.6: al-copilot.chatmode.md
**Objective**: Verify Copilot development mode

**Steps**:
```
Use al-copilot mode
I want to add AI suggestions to sales orders
```

**Expected Result**:
- [ ] Mode recognized
- [ ] Azure OpenAI focus
- [ ] Prompt engineering guidance
- [ ] Responsible AI principles
- [ ] UX design considerations

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

## 6. Integration Tests

### Test 6.1: Auto-Applied Instructions in Action
**Objective**: Verify instructions apply automatically

**Steps**:
1. Create new `.al` file in test project
2. Start typing:
```al
procedure test
```
3. Observe Copilot suggestions

**Expected Result**:
- [ ] Suggestions use PascalCase: `TestProcedure`
- [ ] 2-space indentation suggested
- [ ] XML documentation suggested for public procedures

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 6.2: Contextual Instructions Activation
**Objective**: Verify contextual instructions activate

**Steps**:
1. Start writing error handling code:
```al
procedure ProcessPayment
var
begin
    // Start error handling
```
2. Observe suggestions

**Expected Result**:
- [ ] TryFunction pattern suggested
- [ ] Error labels recommended
- [ ] No hardcoded error messages

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 6.3: Mode + Prompt Combination
**Objective**: Verify modes can recommend prompts

**Steps**:
1. Use orchestrator mode
2. Ask about deployment
3. Check if it recommends @workspace use al-build

**Expected Result**:
- [ ] Mode recommends appropriate prompt
- [ ] Explains when to use prompt
- [ ] Provides context for recommendation

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 6.4: Multi-Layer Workflow
**Objective**: Test complete workflow using all layers

**Steps**:
1. Start with orchestrator
2. Get recommendation for architect mode
3. Switch to architect mode
4. Use recommended prompt
5. Return to regular coding with auto-instructions

**Expected Result**:
- [ ] Smooth transitions between layers
- [ ] Each layer provides value
- [ ] No conflicts between layers
- [ ] Context maintained

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 6.5: Cross-Reference Verification
**Objective**: Verify internal links work

**Steps**:
1. Open al-development.md
2. Click links to prompts and modes
3. Verify they navigate correctly

**Expected Result**:
- [ ] All internal links work
- [ ] References to files are correct
- [ ] No 404 errors

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

## 7. Validation Tests

### Test 7.1: Collection Manifest Validation
**Objective**: Verify manifest is valid YAML

**Steps**:
```bash
npm install
node validate-al-collection.js
```

**Expected Result**:
```
✅ Collection ID is valid: al-development
✅ Collection has 23 items
✅ Collection has 10 tags
✅ No duplicate paths found
✅ Collection is fully compliant and ready for contribution!
```

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

**Actual Output**:
```
[Paste validation output here]
```

---

### Test 7.2: Frontmatter Validation
**Objective**: All files have valid frontmatter

**Result from validator**:
- [ ] All instruction files have valid frontmatter
- [ ] All prompt files have valid frontmatter
- [ ] All chat mode files have valid frontmatter
- [ ] No warnings about missing fields

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 7.3: File Naming Validation
**Objective**: All files follow naming conventions

**Result from validator**:
- [ ] All files lowercase with hyphens
- [ ] All files have al- prefix
- [ ] Correct extensions (.instructions.md, .prompt.md, .chatmode.md)
- [ ] No naming warnings

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

### Test 7.4: Documentation Completeness
**Objective**: All required documentation exists

**Checklist**:
- [ ] al-development.md exists and complete
- [ ] COLLECTION-SUMMARY.md exists
- [ ] INSTALLATION.md exists (English)
- [ ] INSTALACION.md exists (Spanish)
- [ ] README.md exists
- [ ] CONTRIBUTING.md exists
- [ ] All sections in docs are complete

**Status**: ⬜ Not Started | ✅ Passed | ❌ Failed

---

## 📊 Test Results Summary

### Overall Statistics

**Total Tests**: 45  
**Passed**: ___  
**Failed**: ___  
**Not Started**: ___  

**Pass Rate**: ___%

### Critical Issues Found

```
[List any critical issues that must be fixed]

1. 
2. 
3. 
```

### Minor Issues Found

```
[List minor issues that should be addressed]

1. 
2. 
3. 
```

### Recommendations

```
[List recommendations for improvement]

1. 
2. 
3. 
```

---

## ✅ Sign-Off

**Tester**: javiarmesto  
**Date**: 2025-10-15 08:38:41 UTC  
**Result**: ⬜ Ready for Publication | ⬜ Needs Fixes  

**Notes**:
```
[Final notes and observations]
```

---

## 📋 Quick Test Checklist (For Final Verification)

Before publication, verify:

- [ ] All 45 tests passed
- [ ] Validation script returns success
- [ ] Installation script works on Linux/Mac
- [ ] Installation script works on Windows
- [ ] All prompts respond correctly
- [ ] All chat modes work
- [ ] Auto-instructions apply correctly
- [ ] Documentation is complete
- [ ] No broken links
- [ ] No spelling errors in docs
- [ ] License file present
- [ ] Contributing guide clear
- [ ] Installation guides (EN/ES) accurate

**Ready for Publication**: ⬜ YES | ⬜ NO

---

**End of Test Plan**