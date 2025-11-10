# VS Code Extension Architecture

This document provides a visual overview of the proposed VS Code extension architecture for AL Development Collection.

---

## System Architecture Overview

```mermaid
graph TB
    subgraph "VS Code Environment"
        User[👤 Developer]
        VSCode[VS Code Instance]
        Copilot[GitHub Copilot Extension]
        ALExt[AL Language Extension]
    end
    
    subgraph "AL Collection Extension"
        Extension[AL Collection Extension]
        Installer[Installer Module]
        Validator[Validator Module]
        StatusBar[Status Bar Component]
        Commands[Command Handlers]
    end
    
    subgraph "Workspace"
        GitHub[.github/copilot/]
        Agents[agents/]
        Instructions[instructions/]
        Prompts[prompts/]
        ALProject[AL Project Files]
    end
    
    subgraph "External"
        Marketplace[VS Code Marketplace]
        Repository[GitHub Repository]
    end
    
    User --> VSCode
    VSCode --> Extension
    Extension --> Installer
    Extension --> Validator
    Extension --> StatusBar
    Extension --> Commands
    
    Installer --> GitHub
    Installer --> Agents
    Installer --> Instructions
    Installer --> Prompts
    
    Copilot --> Agents
    Copilot --> Instructions
    Copilot --> Prompts
    
    Extension -.Detect.-> ALProject
    ALExt -.Works with.-> ALProject
    
    Marketplace -.Install/Update.-> Extension
    Extension -.Bundle.-> Repository
    
    style Extension fill:#4CAF50
    style GitHub fill:#2196F3
    style Copilot fill:#FF9800
    style User fill:#9C27B0
```

---

## Component Interaction Flow

### Installation Flow

```mermaid
sequenceDiagram
    participant User
    participant VSCode
    participant Extension
    participant FileSystem
    participant StatusBar
    
    User->>VSCode: Install Extension from Marketplace
    VSCode->>Extension: Activate Extension
    Extension->>FileSystem: Detect AL Project (app.json)
    
    alt AL Project Found
        Extension->>User: Show "Install Collection?" prompt
        User->>Extension: Confirm Installation
        Extension->>FileSystem: Create .github/copilot/
        Extension->>FileSystem: Copy agents/
        Extension->>FileSystem: Copy instructions/
        Extension->>FileSystem: Copy prompts/
        Extension->>User: Show Success Notification
        Extension->>StatusBar: Update Status "✓ Installed"
    else No AL Project
        Extension->>StatusBar: Update Status "○ Not AL Project"
    end
```

### Update Flow

```mermaid
sequenceDiagram
    participant User
    participant Extension
    participant FileSystem
    participant Validator
    participant StatusBar
    
    Extension->>FileSystem: Check installed version
    Extension->>Extension: Compare with bundled version
    
    alt New Version Available
        Extension->>User: Show "Update Available" notification
        User->>Extension: Click "Update"
        Extension->>Validator: Backup existing files
        Extension->>FileSystem: Update changed files
        Extension->>FileSystem: Preserve local customizations
        Extension->>User: Show "Updated to v2.5.0"
        Extension->>StatusBar: Update Status "✓ v2.5.0"
    else Already Up-to-Date
        Extension->>StatusBar: Update Status "✓ Latest"
    end
```

### Validation Flow

```mermaid
sequenceDiagram
    participant User
    participant Extension
    participant Validator
    participant FileSystem
    participant Output
    
    User->>Extension: Run "Validate Collection"
    Extension->>Validator: Start Validation
    
    Validator->>FileSystem: Check .github/copilot/ exists
    Validator->>FileSystem: Verify agents/ directory
    Validator->>FileSystem: Verify instructions/ directory
    Validator->>FileSystem: Verify prompts/ directory
    
    loop For each file
        Validator->>FileSystem: Read file
        Validator->>Validator: Parse frontmatter
        Validator->>Validator: Validate schema
    end
    
    Validator->>Output: Write validation report
    Validator->>User: Show summary notification
    
    alt All Valid
        Output->>User: "✅ Collection is valid"
    else Has Errors
        Output->>User: "❌ Found X errors, Y warnings"
    end
```

---

## File Structure of Extension

```
al-development-collection-extension/
│
├── src/
│   ├── extension.ts                 # Main entry point
│   │   ├── activate()              # Extension activation
│   │   └── deactivate()            # Extension cleanup
│   │
│   ├── installer.ts                # Installation logic
│   │   ├── installCollection()     # Install files
│   │   ├── updateCollection()      # Update files
│   │   └── detectALProject()       # Detect AL projects
│   │
│   ├── validator.ts                # Validation logic
│   │   ├── validateCollection()    # Run validation
│   │   ├── checkFrontmatter()      # Validate YAML frontmatter
│   │   └── generateReport()        # Create validation report
│   │
│   ├── statusBar.ts                # Status bar integration
│   │   ├── createStatusBarItem()   # Create status indicator
│   │   └── updateStatus()          # Update status text
│   │
│   ├── commands/
│   │   ├── install.ts              # Install command handler
│   │   ├── update.ts               # Update command handler
│   │   ├── validate.ts             # Validate command handler
│   │   └── showDocs.ts             # Show docs command
│   │
│   ├── utils/
│   │   ├── fileSystem.ts           # File operations
│   │   ├── logger.ts               # Logging utilities
│   │   └── config.ts               # Configuration management
│   │
│   └── types/
│       ├── collection.ts           # TypeScript types
│       └── frontmatter.ts          # Frontmatter schema
│
├── resources/
│   ├── agents/                     # Bundled agents (copied from repo)
│   ├── instructions/               # Bundled instructions
│   ├── prompts/                    # Bundled prompts
│   └── icon.png                    # Extension icon
│
├── test/
│   ├── suite/
│   │   ├── extension.test.ts
│   │   ├── installer.test.ts
│   │   └── validator.test.ts
│   └── fixtures/
│       └── sample-project/
│
├── .vscode/
│   ├── launch.json                 # Debug configuration
│   └── tasks.json                  # Build tasks
│
├── .vscodeignore                   # Files to exclude from package
├── package.json                    # Extension manifest
├── tsconfig.json                   # TypeScript config
├── README.md                       # Extension README
├── CHANGELOG.md                    # Extension changelog
└── LICENSE                         # MIT License
```

---

## Data Flow Diagrams

### Configuration Data Flow

```mermaid
graph LR
    Settings[VS Code Settings] --> Config[Configuration Manager]
    Config --> Installer[Installer Module]
    Config --> Validator[Validator Module]
    
    User[User Input] --> Config
    
    Config -.installLocation.-> Installer
    Config -.autoUpdate.-> Installer
    Config -.validateOnSave.-> Validator
    
    style Settings fill:#90CAF9
    style Config fill:#4CAF50
```

### File System Operations

```mermaid
graph TB
    Extension[Extension Core]
    
    subgraph "Read Operations"
        ReadProj[Read app.json]
        ReadExist[Read existing files]
        ReadBundle[Read bundled files]
    end
    
    subgraph "Write Operations"
        CreateDir[Create directories]
        CopyFiles[Copy files]
        BackupFiles[Backup files]
    end
    
    subgraph "Validation Operations"
        CheckExists[Check file exists]
        ParseYAML[Parse frontmatter]
        CompareVersion[Compare versions]
    end
    
    Extension --> ReadProj
    Extension --> ReadExist
    Extension --> ReadBundle
    
    Extension --> CreateDir
    Extension --> CopyFiles
    Extension --> BackupFiles
    
    Extension --> CheckExists
    Extension --> ParseYAML
    Extension --> CompareVersion
    
    style Extension fill:#4CAF50
```

---

## State Management

### Extension States

```mermaid
stateDiagram-v2
    [*] --> Inactive
    Inactive --> Activating: Extension Loaded
    Activating --> DetectingProject: Check Workspace
    
    DetectingProject --> NotALProject: No app.json found
    DetectingProject --> ALProjectFound: app.json found
    
    NotALProject --> Idle: Show "Not AL Project"
    
    ALProjectFound --> CheckingInstallation: Check .github/copilot/
    
    CheckingInstallation --> NotInstalled: No collection found
    CheckingInstallation --> Installed: Collection found
    CheckingInstallation --> OutdatedInstallation: Old version found
    
    NotInstalled --> PromptingInstall: Ask user to install
    PromptingInstall --> Installing: User confirms
    PromptingInstall --> Idle: User cancels
    
    Installing --> Installed: Files copied
    Installing --> Failed: Error occurred
    Failed --> Idle: Show error
    
    Installed --> Idle: Show "✓ Installed"
    
    OutdatedInstallation --> PromptingUpdate: Notify update available
    PromptingUpdate --> Updating: User confirms
    PromptingUpdate --> Idle: User cancels
    
    Updating --> Installed: Files updated
    Updating --> Failed: Error occurred
    
    Idle --> Validating: User runs validate
    Validating --> Idle: Show results
    
    Idle --> [*]: Extension Deactivated
```

### Collection Installation States

```mermaid
stateDiagram-v2
    [*] --> NotInstalled
    
    NotInstalled --> Installing: install command
    Installing --> Installed: success
    Installing --> NotInstalled: error
    
    Installed --> Validating: validate command
    Validating --> Valid: all checks pass
    Validating --> Invalid: errors found
    Valid --> Installed: return
    Invalid --> Installed: return
    
    Installed --> Updating: update command
    Updating --> Installed: success
    Updating --> Installed: error
    
    Installed --> NotInstalled: uninstall
    
    NotInstalled --> [*]
    Installed --> [*]
```

---

## Integration Points

### VS Code API Usage

```typescript
// Example of key VS Code APIs used

// 1. Commands API
vscode.commands.registerCommand('al-collection.install', async () => {
  // Install logic
});

// 2. Status Bar API
const statusBarItem = vscode.window.createStatusBarItem(
  vscode.StatusBarAlignment.Right,
  100
);
statusBarItem.text = "$(check) AL Collection";
statusBarItem.show();

// 3. Notifications API
vscode.window.showInformationMessage('Collection installed successfully!');
vscode.window.showErrorMessage('Installation failed: ' + error.message);

// 4. File System API
const workspaceFolders = vscode.workspace.workspaceFolders;
const fs = vscode.workspace.fs;
await fs.writeFile(targetUri, content);

// 5. Configuration API
const config = vscode.workspace.getConfiguration('al-collection');
const autoUpdate = config.get<boolean>('autoUpdate');

// 6. Output Channel API
const outputChannel = vscode.window.createOutputChannel('AL Collection');
outputChannel.appendLine('Validation started...');
outputChannel.show();
```

### GitHub Copilot Integration

```
┌─────────────────────────────────────────┐
│       GitHub Copilot Extension          │
│  (Reads .github/copilot/ automatically) │
└────────────┬────────────────────────────┘
             │
             │ Reads
             ▼
┌─────────────────────────────────────────┐
│     .github/copilot/ Directory          │
│                                         │
│  ├── agents/          ◄────────────────┼── Installed by
│  │   ├── al-architect.agent.md        │   AL Collection
│  │   └── ...                           │   Extension
│  │                                     │
│  ├── instructions/                     │
│  │   ├── al-code-style.instructions.md│
│  │   └── ...                           │
│  │                                     │
│  └── prompts/                          │
│      ├── al-initialize.prompt.md      │
│      └── ...                           │
└─────────────────────────────────────────┘
```

**Key Point**: The AL Collection Extension doesn't modify GitHub Copilot. It just manages the files that Copilot reads.

---

## Performance Considerations

### Optimization Strategies

1. **Lazy Loading**
   - Only activate when AL project detected
   - Load modules on-demand
   - Bundle only essential resources

2. **Caching**
   ```typescript
   class CollectionCache {
     private installedVersion: string | null = null;
     private lastChecked: Date | null = null;
     
     isStale(): boolean {
       if (!this.lastChecked) return true;
       const hoursSinceCheck = (Date.now() - this.lastChecked.getTime()) / 3600000;
       return hoursSinceCheck > 24; // Check once per day
     }
   }
   ```

3. **Async Operations**
   - All file operations are async
   - Show progress notifications for long operations
   - Cancel tokens for user-initiated cancellation

4. **Minimal Footprint**
   - Extension size: < 5MB
   - Memory usage: < 50MB
   - Startup time: < 100ms

---

## Error Handling Strategy

```mermaid
graph TD
    Operation[File Operation] --> TryCatch{Try}
    
    TryCatch -->|Success| Log[Log Success]
    TryCatch -->|Error| Classify{Classify Error}
    
    Classify -->|User Error| ShowError[Show User Message]
    Classify -->|System Error| LogError[Log to Output Channel]
    Classify -->|Fatal Error| Disable[Disable Feature]
    
    ShowError --> Recover{Can Recover?}
    Recover -->|Yes| Retry[Offer Retry]
    Recover -->|No| Fallback[Use Fallback]
    
    LogError --> Telemetry[Send Telemetry]
    Telemetry --> OutputChannel[Write to Output Channel]
    
    style Operation fill:#90CAF9
    style ShowError fill:#FF5722
    style LogError fill:#FFC107
    style Disable fill:#F44336
```

---

## Security Considerations

### File System Security

1. **Path Validation**
   ```typescript
   function isValidInstallPath(path: string): boolean {
     // Prevent path traversal
     if (path.includes('..')) return false;
     
     // Must be inside workspace
     const workspaceRoot = vscode.workspace.workspaceFolders?.[0]?.uri.fsPath;
     if (!path.startsWith(workspaceRoot)) return false;
     
     return true;
   }
   ```

2. **File Permissions**
   - Only write to workspace directories
   - Never modify system files
   - Respect `.gitignore` patterns

3. **Content Validation**
   - Validate YAML frontmatter schema
   - Sanitize user input
   - Check file sizes before operations

---

## Testing Strategy

### Test Pyramid

```
        /\
       /  \
      / E2E \          ← 10% (Integration tests)
     /______\
    /        \
   /  INTEG   \        ← 20% (Component tests)
  /____________\
 /              \
/      UNIT      \     ← 70% (Unit tests)
/________________\
```

### Test Coverage Goals

| Component | Target Coverage |
|-----------|----------------|
| Installer | 85% |
| Validator | 90% |
| Commands | 80% |
| Utils | 95% |
| **Overall** | **85%** |

---

## Deployment Pipeline

```mermaid
graph LR
    Commit[Git Commit] --> CI{CI Build}
    CI -->|Success| Test[Run Tests]
    Test -->|Pass| Package[Package VSIX]
    Package --> Publish{Tag?}
    
    Publish -->|Yes| Marketplace[Publish to Marketplace]
    Publish -->|No| Artifact[Store Artifact]
    
    Marketplace --> Notify[Notify Users]
    
    CI -->|Failure| Alert[Alert Developer]
    Test -->|Fail| Alert
    
    style CI fill:#2196F3
    style Marketplace fill:#4CAF50
    style Alert fill:#F44336
```

---

## Monitoring & Telemetry (Opt-in)

### Metrics to Track

1. **Installation Metrics**
   - Install success/failure rate
   - Installation time
   - Update success/failure rate

2. **Usage Metrics**
   - Command usage frequency
   - Validation runs
   - Error occurrences

3. **Performance Metrics**
   - Extension activation time
   - File operation duration
   - Memory usage

**Privacy**: All telemetry is opt-in and anonymized.

---

## Summary

This architecture provides:

- ✅ **Clear separation of concerns** (installer, validator, commands)
- ✅ **Scalable structure** (easy to add new features)
- ✅ **Robust error handling** (graceful degradation)
- ✅ **Performance optimization** (lazy loading, caching)
- ✅ **Security by design** (path validation, permissions)
- ✅ **Comprehensive testing** (unit, integration, E2E)
- ✅ **Automated deployment** (CI/CD pipeline)

For implementation details, see the full feasibility analysis in `docs/vscode-extension-feasibility.md`.
