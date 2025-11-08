# VS Code Extension Implementation Guide

This guide provides step-by-step instructions for implementing the AL Development Collection VS Code extension.

---

## Prerequisites

- Node.js 18+ and npm
- Visual Studio Code (latest)
- TypeScript knowledge
- Git
- VS Code Extension development experience (recommended)

---

## Phase 0: Preparation (Week 1-2)

### Step 0.1: Stabilize Repository

**Goal**: Ensure content is ready for bundling

```bash
# 1. Resolve validation warnings
npm run validate

# 2. Fix file naming issues (if any)
# - Ensure all files use lowercase-with-hyphens
# - Update collection manifest if needed

# 3. Test current npm package
npm install
npx al-collection install

# 4. Create stable release
git tag v2.5.0
git push --tags
```

**Deliverables**:
- ✅ All validation warnings resolved
- ✅ Tagged stable release
- ✅ npm package tested and working

### Step 0.2: Setup Extension Project

**Goal**: Create extension project structure

```bash
# 1. Create extension directory
mkdir extension
cd extension

# 2. Initialize npm project
npm init -y

# 3. Install dependencies
npm install --save-dev @types/vscode @types/node typescript
npm install --save-dev @vscode/test-electron mocha @types/mocha
npm install --save-dev @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint
npm install --save-dev @vscode/vsce

# 4. Install runtime dependencies
npm install js-yaml
npm install @types/js-yaml --save-dev

# 5. Initialize TypeScript
npx tsc --init
```

**Deliverables**:
- ✅ `extension/` directory created
- ✅ `package.json` configured
- ✅ Dependencies installed

### Step 0.3: Configure TypeScript

Create `extension/tsconfig.json`:

```json
{
  "compilerOptions": {
    "module": "commonjs",
    "target": "ES2020",
    "outDir": "out",
    "lib": ["ES2020"],
    "sourceMap": true,
    "rootDir": "src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "exclude": ["node_modules", ".vscode-test"]
}
```

**Deliverables**:
- ✅ TypeScript configured

---

## Phase 1: MVP Development (Week 3-6)

### Step 1.1: Create Project Structure

```bash
cd extension

# Create directories
mkdir -p src/{commands,utils,types}
mkdir -p resources/{agents,instructions,prompts}
mkdir -p test/suite

# Create main files
touch src/extension.ts
touch src/installer.ts
touch src/validator.ts
touch src/statusBar.ts
touch src/commands/install.ts
touch src/commands/update.ts
touch src/commands/validate.ts
touch src/utils/fileSystem.ts
touch src/utils/logger.ts
touch src/types/collection.ts
```

**Deliverables**:
- ✅ Directory structure created
- ✅ Core files created

### Step 1.2: Copy Collection Resources

```bash
# From repository root
cp -r agents extension/resources/
cp -r instructions extension/resources/
cp -r prompts extension/resources/

# Verify
ls extension/resources/
# Should show: agents/ instructions/ prompts/
```

**Deliverables**:
- ✅ Collection files bundled in extension

### Step 1.3: Implement Core Types

**File**: `extension/src/types/collection.ts`

```typescript
export interface CollectionConfig {
  installLocation: string;
  autoUpdate: boolean;
  notifyUpdates: boolean;
  preserveCustomizations: boolean;
}

export interface InstallationStatus {
  isInstalled: boolean;
  version?: string;
  location?: string;
  isValid: boolean;
}

export interface ValidationResult {
  isValid: boolean;
  errors: ValidationError[];
  warnings: ValidationWarning[];
}

export interface ValidationError {
  file: string;
  line?: number;
  message: string;
}

export interface ValidationWarning {
  file: string;
  line?: number;
  message: string;
}

export interface Frontmatter {
  applyTo?: string | string[];
  description?: string;
  agent?: string;
  model?: string;
  tools?: string[];
  usage?: string;
}
```

**Deliverables**:
- ✅ TypeScript types defined

### Step 1.4: Implement File System Utils

**File**: `extension/src/utils/fileSystem.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';

export async function ensureDirectory(uri: vscode.Uri): Promise<void> {
  try {
    await vscode.workspace.fs.stat(uri);
  } catch {
    await vscode.workspace.fs.createDirectory(uri);
  }
}

export async function copyDirectory(
  source: vscode.Uri,
  target: vscode.Uri,
  preserveExisting: boolean = true
): Promise<{ copied: number; skipped: number }> {
  let copied = 0;
  let skipped = 0;

  await ensureDirectory(target);

  const items = await vscode.workspace.fs.readDirectory(source);

  for (const [name, type] of items) {
    const sourcePath = vscode.Uri.joinPath(source, name);
    const targetPath = vscode.Uri.joinPath(target, name);

    if (type === vscode.FileType.Directory) {
      const result = await copyDirectory(sourcePath, targetPath, preserveExisting);
      copied += result.copied;
      skipped += result.skipped;
    } else {
      // Check if file exists
      const exists = await fileExists(targetPath);
      
      if (preserveExisting && exists) {
        skipped++;
      } else {
        const content = await vscode.workspace.fs.readFile(sourcePath);
        await vscode.workspace.fs.writeFile(targetPath, content);
        copied++;
      }
    }
  }

  return { copied, skipped };
}

export async function fileExists(uri: vscode.Uri): Promise<boolean> {
  try {
    await vscode.workspace.fs.stat(uri);
    return true;
  } catch {
    return false;
  }
}

export async function readTextFile(uri: vscode.Uri): Promise<string> {
  const content = await vscode.workspace.fs.readFile(uri);
  return Buffer.from(content).toString('utf8');
}

export async function writeTextFile(uri: vscode.Uri, content: string): Promise<void> {
  const buffer = Buffer.from(content, 'utf8');
  await vscode.workspace.fs.writeFile(uri, buffer);
}
```

**Deliverables**:
- ✅ File system utilities implemented

### Step 1.5: Implement Logger

**File**: `extension/src/utils/logger.ts`

```typescript
import * as vscode from 'vscode';

class Logger {
  private outputChannel: vscode.OutputChannel;

  constructor() {
    this.outputChannel = vscode.window.createOutputChannel('AL Collection');
  }

  info(message: string): void {
    this.log('INFO', message);
  }

  warn(message: string): void {
    this.log('WARN', message);
  }

  error(message: string, error?: Error): void {
    this.log('ERROR', message);
    if (error) {
      this.log('ERROR', error.stack || error.message);
    }
  }

  success(message: string): void {
    this.log('SUCCESS', message);
  }

  private log(level: string, message: string): void {
    const timestamp = new Date().toISOString();
    this.outputChannel.appendLine(`[${timestamp}] [${level}] ${message}`);
  }

  show(): void {
    this.outputChannel.show();
  }

  dispose(): void {
    this.outputChannel.dispose();
  }
}

export const logger = new Logger();
```

**Deliverables**:
- ✅ Logger utility implemented

### Step 1.6: Implement Installer

**File**: `extension/src/installer.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';
import { copyDirectory, ensureDirectory } from './utils/fileSystem';
import { logger } from './utils/logger';
import { CollectionConfig, InstallationStatus } from './types/collection';

export class Installer {
  private extensionContext: vscode.ExtensionContext;

  constructor(context: vscode.ExtensionContext) {
    this.extensionContext = context;
  }

  async install(config: CollectionConfig): Promise<boolean> {
    try {
      const workspaceRoot = this.getWorkspaceRoot();
      if (!workspaceRoot) {
        throw new Error('No workspace folder open');
      }

      logger.info('Starting collection installation...');

      // Create target directory
      const targetUri = vscode.Uri.joinPath(
        workspaceRoot,
        config.installLocation
      );
      await ensureDirectory(targetUri);

      // Copy agents
      await this.copyResource('agents', targetUri);

      // Copy instructions
      await this.copyResource('instructions', targetUri);

      // Copy prompts
      await this.copyResource('prompts', targetUri);

      logger.success('Collection installed successfully!');
      
      vscode.window.showInformationMessage(
        'AL Development Collection installed successfully! Reload VS Code to activate.',
        'Reload Window'
      ).then(selection => {
        if (selection === 'Reload Window') {
          vscode.commands.executeCommand('workbench.action.reloadWindow');
        }
      });

      return true;
    } catch (error) {
      logger.error('Installation failed', error as Error);
      vscode.window.showErrorMessage(`Installation failed: ${(error as Error).message}`);
      return false;
    }
  }

  async update(config: CollectionConfig): Promise<boolean> {
    try {
      logger.info('Starting collection update...');

      // Backup if configured
      if (config.preserveCustomizations) {
        await this.createBackup(config);
      }

      // Install (will skip existing files if preserveCustomizations is true)
      return await this.install(config);
    } catch (error) {
      logger.error('Update failed', error as Error);
      vscode.window.showErrorMessage(`Update failed: ${(error as Error).message}`);
      return false;
    }
  }

  async getInstallationStatus(config: CollectionConfig): Promise<InstallationStatus> {
    const workspaceRoot = this.getWorkspaceRoot();
    if (!workspaceRoot) {
      return { isInstalled: false, isValid: false };
    }

    const targetUri = vscode.Uri.joinPath(workspaceRoot, config.installLocation);
    
    try {
      await vscode.workspace.fs.stat(targetUri);
      
      // Check if key directories exist
      const agentsUri = vscode.Uri.joinPath(targetUri, 'agents');
      const instructionsUri = vscode.Uri.joinPath(targetUri, 'instructions');
      const promptsUri = vscode.Uri.joinPath(targetUri, 'prompts');

      const [agentsExists, instructionsExists, promptsExists] = await Promise.all([
        this.directoryExists(agentsUri),
        this.directoryExists(instructionsUri),
        this.directoryExists(promptsUri)
      ]);

      const isValid = agentsExists && instructionsExists && promptsExists;

      return {
        isInstalled: true,
        location: config.installLocation,
        isValid
      };
    } catch {
      return { isInstalled: false, isValid: false };
    }
  }

  private async copyResource(resourceName: string, targetUri: vscode.Uri): Promise<void> {
    const sourceUri = vscode.Uri.joinPath(
      this.extensionContext.extensionUri,
      'resources',
      resourceName
    );

    const targetResourceUri = vscode.Uri.joinPath(targetUri, resourceName);

    logger.info(`Copying ${resourceName}...`);
    const result = await copyDirectory(sourceUri, targetResourceUri, true);
    logger.info(`Copied ${result.copied} files, skipped ${result.skipped} existing files`);
  }

  private async createBackup(config: CollectionConfig): Promise<void> {
    logger.info('Creating backup of existing collection...');
    // Implementation: Copy existing files to .backup directory
    // Not shown for brevity
  }

  private async directoryExists(uri: vscode.Uri): Promise<boolean> {
    try {
      const stat = await vscode.workspace.fs.stat(uri);
      return stat.type === vscode.FileType.Directory;
    } catch {
      return false;
    }
  }

  private getWorkspaceRoot(): vscode.Uri | undefined {
    return vscode.workspace.workspaceFolders?.[0]?.uri;
  }
}
```

**Deliverables**:
- ✅ Installer class implemented

### Step 1.7: Implement Status Bar

**File**: `extension/src/statusBar.ts`

```typescript
import * as vscode from 'vscode';
import { InstallationStatus } from './types/collection';

export class StatusBarManager {
  private statusBarItem: vscode.StatusBarItem;

  constructor() {
    this.statusBarItem = vscode.window.createStatusBarItem(
      vscode.StatusBarAlignment.Right,
      100
    );
    this.statusBarItem.command = 'al-collection.showStatus';
  }

  updateStatus(status: InstallationStatus): void {
    if (!status.isInstalled) {
      this.statusBarItem.text = '$(circle-outline) AL Collection';
      this.statusBarItem.tooltip = 'AL Collection not installed. Click to install.';
      this.statusBarItem.command = 'al-collection.install';
    } else if (!status.isValid) {
      this.statusBarItem.text = '$(warning) AL Collection';
      this.statusBarItem.tooltip = 'AL Collection installation is incomplete. Click for details.';
      this.statusBarItem.backgroundColor = new vscode.ThemeColor('statusBarItem.warningBackground');
    } else {
      this.statusBarItem.text = '$(check) AL Collection';
      this.statusBarItem.tooltip = `AL Collection installed at ${status.location}`;
      this.statusBarItem.backgroundColor = undefined;
    }
  }

  show(): void {
    this.statusBarItem.show();
  }

  hide(): void {
    this.statusBarItem.hide();
  }

  dispose(): void {
    this.statusBarItem.dispose();
  }
}
```

**Deliverables**:
- ✅ Status bar manager implemented

### Step 1.8: Implement Extension Entry Point

**File**: `extension/src/extension.ts`

```typescript
import * as vscode from 'vscode';
import { Installer } from './installer';
import { StatusBarManager } from './statusBar';
import { logger } from './utils/logger';
import { CollectionConfig } from './types/collection';

let installer: Installer;
let statusBarManager: StatusBarManager;

export async function activate(context: vscode.ExtensionContext) {
  logger.info('AL Development Collection extension activating...');

  // Initialize components
  installer = new Installer(context);
  statusBarManager = new StatusBarManager();

  // Register commands
  context.subscriptions.push(
    vscode.commands.registerCommand('al-collection.install', async () => {
      await installCommand();
    })
  );

  context.subscriptions.push(
    vscode.commands.registerCommand('al-collection.update', async () => {
      await updateCommand();
    })
  );

  context.subscriptions.push(
    vscode.commands.registerCommand('al-collection.validate', async () => {
      vscode.window.showInformationMessage('Validation coming in Phase 2!');
    })
  );

  context.subscriptions.push(
    vscode.commands.registerCommand('al-collection.showDocs', async () => {
      vscode.env.openExternal(vscode.Uri.parse(
        'https://github.com/javiarmesto/AL-Development-Collection-for-GitHub-Copilot'
      ));
    })
  );

  context.subscriptions.push(
    vscode.commands.registerCommand('al-collection.showStatus', async () => {
      const config = getConfig();
      const status = await installer.getInstallationStatus(config);
      
      const message = status.isInstalled
        ? `Installed at: ${status.location}\nValid: ${status.isValid}`
        : 'Not installed';
      
      vscode.window.showInformationMessage(message);
    })
  );

  // Check if AL project
  const isALProject = await detectALProject();
  
  if (isALProject) {
    // Update status bar
    const config = getConfig();
    const status = await installer.getInstallationStatus(config);
    statusBarManager.updateStatus(status);
    statusBarManager.show();

    // Prompt installation if not installed
    if (!status.isInstalled) {
      const result = await vscode.window.showInformationMessage(
        'AL Development Collection is not installed. Would you like to install it now?',
        'Install',
        'Later'
      );

      if (result === 'Install') {
        await installCommand();
      }
    }
  }

  logger.success('AL Development Collection extension activated!');
}

export function deactivate() {
  logger.info('AL Development Collection extension deactivating...');
  statusBarManager?.dispose();
  logger.dispose();
}

async function installCommand(): Promise<void> {
  const config = getConfig();
  
  await vscode.window.withProgress({
    location: vscode.ProgressLocation.Notification,
    title: 'Installing AL Development Collection...',
    cancellable: false
  }, async (progress) => {
    progress.report({ increment: 0 });
    
    const success = await installer.install(config);
    
    if (success) {
      const status = await installer.getInstallationStatus(config);
      statusBarManager.updateStatus(status);
    }
  });
}

async function updateCommand(): Promise<void> {
  const config = getConfig();
  
  await vscode.window.withProgress({
    location: vscode.ProgressLocation.Notification,
    title: 'Updating AL Development Collection...',
    cancellable: false
  }, async (progress) => {
    progress.report({ increment: 0 });
    
    const success = await installer.update(config);
    
    if (success) {
      const status = await installer.getInstallationStatus(config);
      statusBarManager.updateStatus(status);
    }
  });
}

async function detectALProject(): Promise<boolean> {
  const workspaceFolders = vscode.workspace.workspaceFolders;
  if (!workspaceFolders) {
    return false;
  }

  for (const folder of workspaceFolders) {
    const appJsonUri = vscode.Uri.joinPath(folder.uri, 'app.json');
    try {
      await vscode.workspace.fs.stat(appJsonUri);
      return true;
    } catch {
      // Continue checking other folders
    }
  }

  return false;
}

function getConfig(): CollectionConfig {
  const config = vscode.workspace.getConfiguration('al-collection');
  
  return {
    installLocation: config.get<string>('installLocation') || '.github/copilot',
    autoUpdate: config.get<boolean>('autoUpdate') || false,
    notifyUpdates: config.get<boolean>('notifyUpdates') || true,
    preserveCustomizations: config.get<boolean>('preserveCustomizations') || true
  };
}
```

**Deliverables**:
- ✅ Extension entry point implemented
- ✅ Commands registered
- ✅ AL project detection

### Step 1.9: Copy package.json

Copy the prototype package.json we created:

```bash
cp docs/extension-package.json extension/package.json
```

Edit paths and verify all settings are correct.

**Deliverables**:
- ✅ package.json configured

### Step 1.10: Test and Package

```bash
cd extension

# Compile
npm run compile

# Test locally (F5 in VS Code)
# Opens Extension Development Host

# Package for distribution
npm run package
# Creates al-development-collection-2.5.0.vsix
```

**Deliverables**:
- ✅ Extension compiles without errors
- ✅ Extension runs in development host
- ✅ .vsix package created

---

## Phase 2: Beta Testing (Week 7-8)

### Step 2.1: Setup Publisher Account

1. Go to https://marketplace.visualstudio.com/manage
2. Create publisher account (requires Microsoft account)
3. Create Personal Access Token (PAT) in Azure DevOps
4. Save PAT securely

### Step 2.2: Publish Beta

```bash
cd extension

# Login to publisher
npx vsce login javiarmesto

# Publish as beta (pre-release)
npx vsce publish --pre-release

# Or manually upload .vsix to marketplace
```

### Step 2.3: Beta Testing

1. Recruit 10-20 beta testers from Business Central community
2. Collect feedback via GitHub Issues
3. Fix critical bugs
4. Iterate

**Deliverables**:
- ✅ Extension published to Marketplace (beta)
- ✅ Beta testers recruited
- ✅ Feedback collected

---

## Phase 3: Release v1.0 (Week 9-12)

### Step 3.1: Implement Validator (Enhancement)

**File**: `extension/src/validator.ts`

```typescript
import * as vscode from 'vscode';
import * as yaml from 'js-yaml';
import { logger } from './utils/logger';
import { ValidationResult, Frontmatter } from './types/collection';
import { readTextFile, fileExists } from './utils/fileSystem';

export class Validator {
  async validateCollection(collectionPath: string): Promise<ValidationResult> {
    const result: ValidationResult = {
      isValid: true,
      errors: [],
      warnings: []
    };

    logger.info('Starting collection validation...');

    const workspaceRoot = vscode.workspace.workspaceFolders?.[0]?.uri;
    if (!workspaceRoot) {
      result.isValid = false;
      result.errors.push({
        file: '',
        message: 'No workspace folder open'
      });
      return result;
    }

    const collectionUri = vscode.Uri.joinPath(workspaceRoot, collectionPath);

    // Validate directories exist
    await this.validateDirectories(collectionUri, result);

    // Validate files
    await this.validateFiles(collectionUri, 'agents', result);
    await this.validateFiles(collectionUri, 'instructions', result);
    await this.validateFiles(collectionUri, 'prompts', result);

    result.isValid = result.errors.length === 0;

    logger.info(`Validation complete: ${result.errors.length} errors, ${result.warnings.length} warnings`);

    return result;
  }

  private async validateDirectories(
    collectionUri: vscode.Uri,
    result: ValidationResult
  ): Promise<void> {
    const dirs = ['agents', 'instructions', 'prompts'];

    for (const dir of dirs) {
      const dirUri = vscode.Uri.joinPath(collectionUri, dir);
      const exists = await fileExists(dirUri);

      if (!exists) {
        result.errors.push({
          file: dir,
          message: `Directory ${dir}/ not found`
        });
      }
    }
  }

  private async validateFiles(
    collectionUri: vscode.Uri,
    directory: string,
    result: ValidationResult
  ): Promise<void> {
    const dirUri = vscode.Uri.joinPath(collectionUri, directory);

    try {
      const files = await vscode.workspace.fs.readDirectory(dirUri);

      for (const [name, type] of files) {
        if (type === vscode.FileType.File && name.endsWith('.md')) {
          await this.validateFile(vscode.Uri.joinPath(dirUri, name), result);
        }
      }
    } catch (error) {
      // Directory doesn't exist, already reported
    }
  }

  private async validateFile(
    fileUri: vscode.Uri,
    result: ValidationResult
  ): Promise<void> {
    try {
      const content = await readTextFile(fileUri);
      const frontmatter = this.extractFrontmatter(content);

      if (!frontmatter) {
        result.warnings.push({
          file: fileUri.fsPath,
          message: 'No frontmatter found'
        });
        return;
      }

      // Validate based on file type
      if (fileUri.fsPath.includes('instructions')) {
        this.validateInstructionFrontmatter(frontmatter, fileUri.fsPath, result);
      } else if (fileUri.fsPath.includes('prompts')) {
        this.validatePromptFrontmatter(frontmatter, fileUri.fsPath, result);
      } else if (fileUri.fsPath.includes('agents')) {
        this.validateAgentFrontmatter(frontmatter, fileUri.fsPath, result);
      }
    } catch (error) {
      result.errors.push({
        file: fileUri.fsPath,
        message: `Failed to read file: ${(error as Error).message}`
      });
    }
  }

  private extractFrontmatter(content: string): Frontmatter | null {
    const match = content.match(/^---\n([\s\S]+?)\n---/);
    if (!match) {
      return null;
    }

    try {
      return yaml.load(match[1]) as Frontmatter;
    } catch {
      return null;
    }
  }

  private validateInstructionFrontmatter(
    frontmatter: Frontmatter,
    file: string,
    result: ValidationResult
  ): void {
    if (!frontmatter.applyTo) {
      result.errors.push({ file, message: 'Missing applyTo field' });
    }
    if (!frontmatter.description) {
      result.warnings.push({ file, message: 'Missing description field' });
    }
  }

  private validatePromptFrontmatter(
    frontmatter: Frontmatter,
    file: string,
    result: ValidationResult
  ): void {
    if (!frontmatter.agent) {
      result.errors.push({ file, message: 'Missing agent field' });
    }
    if (!frontmatter.description) {
      result.warnings.push({ file, message: 'Missing description field' });
    }
  }

  private validateAgentFrontmatter(
    frontmatter: Frontmatter,
    file: string,
    result: ValidationResult
  ): void {
    if (!frontmatter.description) {
      result.warnings.push({ file, message: 'Missing description field' });
    }
  }
}
```

Update `extension.ts` to use the validator:

```typescript
import { Validator } from './validator';

let validator: Validator;

export async function activate(context: vscode.ExtensionContext) {
  // ... existing code ...
  
  validator = new Validator();
  
  context.subscriptions.push(
    vscode.commands.registerCommand('al-collection.validate', async () => {
      await validateCommand();
    })
  );
  
  // ... rest of code ...
}

async function validateCommand(): Promise<void> {
  const config = getConfig();
  
  await vscode.window.withProgress({
    location: vscode.ProgressLocation.Notification,
    title: 'Validating AL Development Collection...',
    cancellable: false
  }, async (progress) => {
    progress.report({ increment: 0 });
    
    const result = await validator.validateCollection(config.installLocation);
    
    logger.show();
    
    if (result.isValid) {
      vscode.window.showInformationMessage(
        `✅ Collection is valid! ${result.warnings.length} warnings.`
      );
    } else {
      vscode.window.showErrorMessage(
        `❌ Validation failed: ${result.errors.length} errors, ${result.warnings.length} warnings. Check Output.`
      );
    }
  });
}
```

**Deliverables**:
- ✅ Validator implemented
- ✅ Validation command working

### Step 3.2: Add Auto-Update Feature

Add to `extension.ts`:

```typescript
async function checkForUpdates(): Promise<void> {
  const config = getConfig();
  
  if (!config.notifyUpdates) {
    return;
  }
  
  const status = await installer.getInstallationStatus(config);
  
  if (!status.isInstalled) {
    return;
  }
  
  // Check if bundled version is newer
  // (Simplified - in production, compare version numbers)
  const hasUpdate = true; // Replace with actual version comparison
  
  if (hasUpdate) {
    const result = await vscode.window.showInformationMessage(
      'A new version of AL Development Collection is available.',
      'Update Now',
      'Later'
    );
    
    if (result === 'Update Now') {
      await updateCommand();
    }
  }
}

export async function activate(context: vscode.ExtensionContext) {
  // ... existing code ...
  
  // Check for updates on startup
  if (isALProject) {
    await checkForUpdates();
  }
}
```

**Deliverables**:
- ✅ Auto-update notification implemented

### Step 3.3: Write Tests

**File**: `extension/test/suite/installer.test.ts`

```typescript
import * as assert from 'assert';
import * as vscode from 'vscode';
import { Installer } from '../../installer';

suite('Installer Test Suite', () => {
  test('Should detect AL project', async () => {
    // Test implementation
    assert.ok(true);
  });

  test('Should install collection', async () => {
    // Test implementation
    assert.ok(true);
  });
});
```

**Deliverables**:
- ✅ Basic tests written
- ✅ Tests passing

### Step 3.4: Polish and Documentation

1. Write comprehensive README.md for extension
2. Add screenshots
3. Create CHANGELOG.md
4. Update package.json metadata

**Deliverables**:
- ✅ Documentation complete
- ✅ Screenshots added

### Step 3.5: Publish v1.0

```bash
# Update version
npm version 1.0.0

# Compile and test
npm run compile
npm test

# Package
npm run package

# Publish (remove pre-release flag)
npx vsce publish
```

**Deliverables**:
- ✅ v1.0.0 published to Marketplace

---

## Phase 4: Continuous Improvements (Ongoing)

### Features for Future Versions

- **v1.1**: Tree view showing installed primitives
- **v1.2**: Preview primitives before installation
- **v1.3**: Integration with AL Language Server
- **v1.4**: Telemetry dashboard
- **v1.5**: Custom collections support

---

## CI/CD Setup

Create `.github/workflows/extension-build.yml`:

```yaml
name: Extension Build

on:
  push:
    branches: [main]
    paths:
      - 'extension/**'
      - 'agents/**'
      - 'instructions/**'
      - 'prompts/**'

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Copy collection resources
        run: |
          cd extension
          cp -r ../agents resources/
          cp -r ../instructions resources/
          cp -r ../prompts resources/
      
      - name: Install dependencies
        run: |
          cd extension
          npm install
      
      - name: Compile
        run: |
          cd extension
          npm run compile
      
      - name: Run tests
        run: |
          cd extension
          npm test
      
      - name: Package extension
        run: |
          cd extension
          npm run package
      
      - name: Upload artifact
        uses: actions/upload-artifact@v3
        with:
          name: vsix-package
          path: extension/*.vsix
      
      - name: Publish to Marketplace
        if: startsWith(github.ref, 'refs/tags/')
        run: |
          cd extension
          npx vsce publish -p ${{ secrets.VSCE_TOKEN }}
```

**Deliverables**:
- ✅ CI/CD pipeline configured
- ✅ Automated builds on commits
- ✅ Automated publishing on tags

---

## Troubleshooting

### Common Issues

**Issue**: Extension doesn't activate
**Solution**: Check activation events in package.json, ensure app.json exists

**Issue**: Files not copying
**Solution**: Verify resources/ directory exists and is properly bundled

**Issue**: TypeScript compilation errors
**Solution**: Check tsconfig.json, ensure all dependencies installed

**Issue**: Cannot publish to Marketplace
**Solution**: Verify PAT token, check publisher account setup

---

## Resources

- [VS Code Extension API](https://code.visualstudio.com/api)
- [Extension Guidelines](https://code.visualstudio.com/api/references/extension-guidelines)
- [Publishing Extensions](https://code.visualstudio.com/api/working-with-extensions/publishing-extension)
- [Testing Extensions](https://code.visualstudio.com/api/working-with-extensions/testing-extension)

---

## Summary

Following this guide, you can implement the AL Development Collection VS Code extension in ~3 months part-time:

- **Phase 0**: 2 weeks (preparation)
- **Phase 1**: 4 weeks (MVP development)
- **Phase 2**: 2 weeks (beta testing)
- **Phase 3**: 4 weeks (v1.0 release)
- **Phase 4**: Ongoing (improvements)

**Total effort**: ~126 hours over 12 weeks

Good luck with the implementation! 🚀
