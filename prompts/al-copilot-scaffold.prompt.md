---
mode: 'agent'
description: 'Scaffold a complete Copilot experience including PromptDialog page, Azure OpenAI integration codeunit, capability registration, and test structure for Business Central.'
tools: ['edit', 'new', 'search', 'runCommands', 'runTasks', 'usages', 'vscodeAPI', 'problems', 'ms-dynamics-smb.al/al_build', 'ms-dynamics-smb.al/al_download_symbols', 'extensions', 'todos']
model: claude-sonnet-4.5
---

# Scaffold Copilot Experience

Your goal is to create a complete Copilot feature called `${input:FeatureName}` for Business Central.

This workflow generates all necessary components for a working Copilot extensibility experience based on Microsoft's PromptDialog pattern and Azure OpenAI integration.

## Prerequisites

**Required**:
- [ ] AL development environment configured
- [ ] Business Central platform 26.0 or later
- [ ] Azure OpenAI subscription or plan to use Microsoft managed resources
- [ ] Clear understanding of what the Copilot feature should do

**Helpful to have**:
- [ ] Feature specification or description
- [ ] Source data model (tables to analyze)
- [ ] Example of desired output format

## Process

### Phase 1: Analyze Requirements

#### Gather Feature Information

Ask the user:
1. **What problem does this Copilot solve?**
   - What manual task is being automated?
   - What decisions does it help with?

2. **What data will it analyze?**
   - Which BC tables/records?
   - External data sources?

3. **What output format?**
   - List of suggestions?
   - Single recommendation?
   - Generated text?
   - Structured data?

4. **User interaction model?**
   - Simple prompt → results?
   - Multiple options to configure?
   - Iterative refinement?

#### Determine Object Structure

Based on requirements, plan:
- **PromptDialog page**: Main UI
- **Generation codeunit**: Azure OpenAI logic
- **Result table**: Temporary table for results
- **Subpart page** (if needed): Results display
- **Capability enum**: Registration
- **Setup codeunit**: Installation
- **Test codeunit**: AI Test Toolkit tests

### Phase 2: Create Object ID Range

#### Check Available IDs

```
Use search tool to find:
- Existing object IDs in app.json idRanges
- Highest used ID in current extension
```

#### Assign Object IDs

For feature `${input:FeatureName}`, assign:
- PromptDialog Page: `[BaseID]`
- Results Subpart Page: `[BaseID+1]`
- Result Table: `[BaseID+2]`
- Generation Codeunit: `[BaseID+3]`
- Setup Codeunit: `[BaseID+4]`
- Test Codeunit: `[BaseID+5]`
- Capability Enum Value: `[BaseID]`

### Phase 3: Generate PromptDialog Page

#### Create Main PromptDialog

Generate file: `src/Copilot/[FeatureName]Copilot.Page.al`

**Template Structure**:
```al
namespace [YourNamespace].[FeatureName];

page [BaseID] "[Feature Name] Copilot"
{
    PageType = PromptDialog;
    Extensible = false;
    IsPreview = true;
    Caption = '[User-friendly feature description]';
    PromptMode = Prompt;

    layout
    {
        // PromptOptions: Settings (if needed)
        area(PromptOptions)
        {
            // Add Option/Enum fields for generation settings
            // Example: filter options, output preferences
        }

        // Prompt: User input
        area(Prompt)
        {
            field(UserInput; UserInput)
            {
                ShowCaption = false;
                MultiLine = true;
                ApplicationArea = All;
                InstructionalText = '[Describe what user should enter]';
            }
        }

        // Content: Results display
        area(Content)
        {
            part(Results; "[Feature Name] Results Part")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // PromptGuide: Example prompts
        area(PromptGuide)
        {
            action(Example1)
            {
                Caption = '[Example 1 description]';
                trigger OnAction()
                begin
                    UserInput := '[Example prompt text]';
                    CurrPage.Update(false);
                end;
            }
        }

        // SystemActions: Required AI actions
        area(SystemActions)
        {
            systemaction(Generate)
            {
                Caption = 'Generate';
                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }

            systemaction(Regenerate)
            {
                Caption = 'Regenerate';
                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }

            systemaction(OK)
            {
                Caption = 'Keep it';
            }

            systemaction(Cancel)
            {
                Caption = 'Discard';
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = CloseAction::OK then begin
            CurrPage.Results.Page.ApplyResults();
        end;
    end;

    local procedure RunGeneration()
    var
        Generator: Codeunit "[Feature Name] Generator";
        TempResults: Record "[Feature Name] Results" temporary;
        Attempts: Integer;
    begin
        Generator.SetUserPrompt(UserInput);

        TempResults.Reset();
        TempResults.DeleteAll();

        // Retry logic for AI reliability
        Attempts := 0;
        while TempResults.IsEmpty() and (Attempts < 3) do begin
            if Generator.Run() then
                Generator.GetResults(TempResults);
            Attempts += 1;
        end;

        if not TempResults.IsEmpty() then
            LoadResults(TempResults)
        else
            Error('Unable to generate results. Please try again.');
    end;

    procedure LoadResults(var TempResults: Record "[Feature Name] Results" temporary)
    begin
        CurrPage.Results.Page.Load(TempResults);
        CurrPage.Update(false);
    end;

    var
        UserInput: Text;
}
```

**Customization based on requirements**:
- Add PromptOptions fields if user needs configuration
- Adjust InstructionalText to guide users
- Create example prompts in PromptGuide
- Add context parameters (e.g., SetSourceRecord procedure)

### Phase 4: Generate Result Table

Create file: `src/Copilot/[FeatureName]Results.Table.al`

```al
namespace [YourNamespace].[FeatureName];

table [BaseID+2] "[Feature Name] Results"
{
    TableType = Temporary;  // Always temporary for Copilot results

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        // Add fields based on output structure
        // Example fields:
        field(10; "Code"; Code[20])
        {
            Caption = 'Code';
        }

        field(20; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(30; "AI Explanation"; Text[2048])
        {
            Caption = 'Explanation';
        }

        field(40; "Full Explanation"; Blob)
        {
            Caption = 'Full Explanation';
        }

        field(50; Selected; Boolean)
        {
            Caption = 'Select';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}
```

### Phase 5: Generate Azure OpenAI Integration Codeunit

Create file: `src/Copilot/[FeatureName]Generator.Codeunit.al`

```al
namespace [YourNamespace].[FeatureName];

using System.AI;

codeunit [BaseID+3] "[Feature Name] Generator"
{
    trigger OnRun()
    begin
        GenerateResults();
    end;

    procedure SetUserPrompt(InputPrompt: Text)
    begin
        UserPrompt := InputPrompt;
    end;

    procedure GetResults(var TempResults: Record "[Feature Name] Results" temporary)
    begin
        TempResults.Copy(Results, true);
    end;

    internal procedure GetCompletionResult(): Text
    begin
        exit(CompletionResult);
    end;

    local procedure GenerateResults()
    var
        JsonResponse: Text;
    begin
        CompletionResult := '';
        JsonResponse := CallAzureOpenAI(GetSystemPrompt(), GetUserPrompt());
        ParseJsonResponse(JsonResponse);
    end;

    local procedure CallAzureOpenAI(SystemPrompt: Text; UserPrompt: Text): Text
    var
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
        AOAIDeployments: Codeunit "AOAI Deployments";
        IsolatedStorageWrapper: Codeunit "Isolated Storage Wrapper";
        Result: Text;
    begin
        // Use managed resources (recommended)
        AzureOpenAI.SetManagedResourceAuthorization(
            Enum::"AOAI Model Type"::"Chat Completions",
            IsolatedStorageWrapper.GetEndpoint(),
            IsolatedStorageWrapper.GetDeployment(),
            IsolatedStorageWrapper.GetSecretKey(),
            AOAIDeployments.GetGPT4oLatest()
        );

        // Register capability
        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"[Feature Name]");

        // Configure parameters
        AOAIChatCompletionParams.SetMaxTokens(2500);
        AOAIChatCompletionParams.SetTemperature(0);
        AOAIChatCompletionParams.SetJsonMode(true);

        // Build messages
        AOAIChatMessages.AddSystemMessage(SystemPrompt);
        AOAIChatMessages.AddUserMessage(UserPrompt);

        // Generate completion
        AzureOpenAI.GenerateChatCompletion(
            AOAIChatMessages,
            AOAIChatCompletionParams,
            AOAIOperationResponse
        );

        if AOAIOperationResponse.IsSuccess() then
            Result := AOAIChatMessages.GetLastMessage()
        else
            Error('Azure OpenAI error: %1', AOAIOperationResponse.GetError());

        CompletionResult := Result;
        exit(Result);
    end;

    local procedure GetSystemPrompt(): Text
    var
        PromptBuilder: TextBuilder;
    begin
        // Build system prompt based on feature requirements
        PromptBuilder.AppendLine('You are a [role] assistant for Business Central.');
        PromptBuilder.AppendLine('');
        PromptBuilder.AppendLine('Task: [Describe the AI task]');
        PromptBuilder.AppendLine('');
        PromptBuilder.AppendLine('Output format: JSON with this structure:');
        PromptBuilder.AppendLine('{');
        PromptBuilder.AppendLine('  "results": [');
        PromptBuilder.AppendLine('    {');
        PromptBuilder.AppendLine('      "field1": "value",');
        PromptBuilder.AppendLine('      "field2": "value"');
        PromptBuilder.AppendLine('    }');
        PromptBuilder.AppendLine('  ]');
        PromptBuilder.AppendLine('}');
        PromptBuilder.AppendLine('');
        PromptBuilder.AppendLine('Constraints:');
        PromptBuilder.AppendLine('- [Add relevant constraints]');

        exit(PromptBuilder.ToText());
    end;

    local procedure GetUserPrompt(): Text
    var
        PromptBuilder: TextBuilder;
    begin
        // Build user prompt with context data
        PromptBuilder.AppendLine('Context data:');
        // Add relevant BC data here
        PromptBuilder.AppendLine('');
        PromptBuilder.Append(StrSubstNo('User request: %1', UserPrompt));

        exit(PromptBuilder.ToText());
    end;

    local procedure ParseJsonResponse(JsonText: Text)
    var
        JsonToken: JsonToken;
        JsonArray: JsonArray;
        JsonItem: JsonToken;
        i: Integer;
    begin
        JsonToken.ReadFrom(JsonText);
        JsonToken.AsObject().Get('results', JsonToken);
        JsonArray := JsonToken.AsArray();

        if JsonArray.Count() > 0 then begin
            for i := 0 to JsonArray.Count() - 1 do begin
                JsonArray.Get(i, JsonItem);
                ParseAndInsertResult(JsonItem);
            end;
        end;
    end;

    local procedure ParseAndInsertResult(JsonItem: JsonToken)
    var
        Token: JsonToken;
    begin
        Results.Init();

        // Parse JSON fields and populate result record
        if JsonItem.AsObject().Get('field1', Token) then
            Results.Description := CopyStr(Token.AsValue().AsText(), 1, MaxStrLen(Results.Description));

        // Add more fields...

        Results.Insert();
    end;

    var
        Results: Record "[Feature Name] Results" temporary;
        UserPrompt: Text;
        CompletionResult: Text;
}
```

### Phase 6: Generate Capability Registration

#### Extend Copilot Capability Enum

Create file: `src/Copilot/[FeatureName]Capability.EnumExt.al`

```al
namespace [YourNamespace].[FeatureName];

using System.AI;

enumextension [BaseID] "[Feature Name] Capability" extends "Copilot Capability"
{
    value([BaseID]; "[Feature Name]")
    {
        Caption = '[Feature Name]';
    }
}
```

#### Create Setup Codeunit

Create file: `src/Copilot/[FeatureName]Setup.Codeunit.al`

```al
namespace [YourNamespace].[FeatureName];

using System.AI;

codeunit [BaseID+4] "[Feature Name] Setup"
{
    Subtype = Install;
    InherentEntitlements = X;
    InherentPermissions = X;
    Access = Internal;

    trigger OnInstallAppPerDatabase()
    begin
        RegisterCapability();
    end;

    local procedure RegisterCapability()
    var
        CopilotCapability: Codeunit "Copilot Capability";
        LearnMoreUrl: Label 'https://example.com/copilot-help', Locked = true;
    begin
        if not CopilotCapability.IsCapabilityRegistered(
            Enum::"Copilot Capability"::"[Feature Name]") then
            CopilotCapability.RegisterCapability(
                Enum::"Copilot Capability"::"[Feature Name]",
                Enum::"Copilot Availability"::Preview,
                LearnMoreUrl
            );
    end;
}
```

### Phase 7: Generate Test Codeunit

Create file: `test/[FeatureName]Tests.Codeunit.al`

```al
namespace [YourNamespace].[FeatureName];

using System.TestTools.AITestToolkit;

codeunit [BaseID+5] "[Feature Name] Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure TestGeneration()
    var
        AITestContext: Codeunit "AIT Test Context";
        Generator: Codeunit "[Feature Name] Generator";
        TempResults: Record "[Feature Name] Results" temporary;
        Attempts: Integer;
    begin
        // Get test data from AI Test Toolkit
        Generator.SetUserPrompt(
            AITestContext.GetQuestion().ValueAsText()
        );

        TempResults.Reset();
        TempResults.DeleteAll();

        // Generation with retry
        Attempts := 0;
        while TempResults.IsEmpty() and (Attempts < 2) do begin
            if Generator.Run() then
                Generator.GetResults(TempResults);
            Attempts += 1;
        end;

        // Record output for analysis
        AITestContext.SetTestOutput(
            Generator.GetCompletionResult()
        );

        // Validate
        if Attempts < 2 then begin
            if TempResults.IsEmpty() then
                Error('No results generated');
        end else
            Error('Generation failed: %1', GetLastErrorText());
    end;
}
```

### Phase 8: Update app.json Dependencies

Ensure app.json includes:

```json
{
  "dependencies": [
    {
      "id": "2156302a-872f-4568-be0b-60968696f0d5",
      "publisher": "Microsoft",
      "name": "AI Test Toolkit",
      "version": "26.0.0.0"
    }
  ]
}
```

### Phase 9: Create Entry Point

Generate action/extension to launch the Copilot, for example:

```al
pageextension [BaseID+6] "[Feature Name] Entry" extends "Item Card"
{
    actions
    {
        addlast(Processing)
        {
            action(LaunchCopilot)
            {
                Caption = '[Feature Name]';
                Image = Sparkle;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CopilotPage: Page "[Feature Name] Copilot";
                begin
                    CopilotPage.SetSourceItem(Rec);
                    CopilotPage.Run();
                end;
            }
        }
    }
}
```

## Validation

After generation, verify:
- [ ] All files created in correct directories
- [ ] Object IDs are unique and in range
- [ ] Compilation succeeds (`al_build`)
- [ ] No errors in Problems panel
- [ ] PromptDialog page opens correctly
- [ ] Azure OpenAI integration placeholder is ready

## Next Steps

**Customize the generated code**:
1. Update system prompt in Generator codeunit
2. Add actual business context data to GetUserPrompt()
3. Customize PromptOptions based on requirements
4. Add PromptGuide examples
5. Implement result parsing logic
6. Configure Azure OpenAI credentials

**Test the feature**:
```
@workspace use al-copilot-test
```

**Get strategic guidance**:
```
Switch to al-copilot mode
```

## Success Criteria

- ✅ All AL objects generated without errors
- ✅ PromptDialog page structure complete
- ✅ Azure OpenAI integration code in place
- ✅ Capability registered correctly
- ✅ Test structure created
- ✅ Build succeeds
- ✅ Ready for customization

## Common Customizations

### Add Filter Options

```al
area(PromptOptions)
{
    field(FilterType; FilterType)
    {
        Caption = 'Filter by';
        OptionCaption = 'All,Active Only,Available';
    }
}
```

### Add Context from Current Record

```al
procedure SetContext(Item: Record Item)
begin
    ContextItem := Item;
end;
```

### Customize Result Display

Create custom subpart page with specific field layout for your results.

---

**Scaffolding complete! All components generated and ready for customization.**

Your Copilot feature structure is in place. Customize the prompts, business logic, and test it with real data.
