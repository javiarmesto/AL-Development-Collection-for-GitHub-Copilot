---
agent: agent
model: Claude Sonnet 4.5
description: 'Create a complete PromptDialog page for Copilot features in Business Central. Includes all areas (PromptOptions, Prompt, Content, PromptGuide), system actions, and Azure OpenAI integration.'
tools: ['microsoft-docs/*', 'edit', 'search', 'new', 'Azure MCP/search', 'usages', 'vscodeAPI', 'problems', 'changes', 'ms-dynamics-smb.al/al_build', 'ms-dynamics-smb.al/al_incremental_publish']

---

# Copilot PromptDialog Page Creation Workflow

Complete workflow to create a PromptDialog page with all areas, system actions, and Azure OpenAI integration for Copilot features in Business Central.

## Objective

Create a fully functional PromptDialog page that allows users to interact with AI-powered Copilot features, with proper UX, error handling, and responsible AI practices.

## Context Loading Phase

Before starting, review:
- [Existing PromptDialog pages in codebase]
- [Microsoft Docs: Build Copilot Experience](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/ai-build-experience)
- [Real Example: Item Substitution](https://github.com/javiarmesto/Lab1_3_Ejemplo_Explicativo/blob/main/PromptDialog/ItemSubstAIProposal.Page.al)
- [Registered Copilot capabilities]
- [app.json for object ID ranges]

## Prerequisites

- Copilot capability already registered (use `al-copilot-capability` if not)
- Available object ID range
- Understanding of desired user experience
- Optional: Temporary table for result storage (for history control)

## Step-by-Step Process

### Phase 1: Gather Information

Ask the user for:

1. **Page Purpose**: What will this Copilot dialog do?
   - Example: "Generate sales insights", "Suggest item substitutions", "Analyze customer patterns"

2. **Interaction Model**:
   - User provides text input → AI generates response
   - User selects options → AI generates structured suggestions
   - Auto-generate on open → AI provides immediate insights

3. **PromptMode**: How should the dialog behave?
   - `Prompt` (default): Ask user for input first
   - `Generate`: Auto-run generation when opened
   - `Content`: Show content only (no generation)

4. **Input Requirements**:
   - Free text input?
   - Dropdown options (PromptOptions)?
   - Pre-filled context from calling page?

5. **Output Format**:
   - Simple text response?
   - Structured list/table (needs subpage)?
   - JSON data for processing?

6. **Object IDs**: Available IDs for page and subpage (if needed)?

7. **PromptGuide Examples**: What examples should help users?
   - 2-3 example prompts to guide users

### Phase 2: Design Data Structure

#### If Structured Output Needed:

Create temporary table for results:

**File**: `<FeatureName>Proposal.Table.al`

**Template**:
```al
namespace <Namespace>;

table <ObjectID> "<Feature Name> Proposal"
{
    TableType = Temporary;
    Caption = '<Feature Name> Proposal';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(10; "No."; Code[20])
        {
            Caption = 'No.';
        }

        field(20; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(30; Explanation; Text[250])
        {
            Caption = 'Explanation';
        }

        field(40; "Confidence Score"; Decimal)
        {
            Caption = 'Confidence Score';
            MinValue = 0;
            MaxValue = 1;
        }

        field(50; "Full Explanation"; Blob)
        {
            Caption = 'Full Explanation';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
```

#### If Subpage Needed:

Create subpage for displaying results:

**File**: `<FeatureName>ProposalSub.Page.al`

**Template**:
```al
namespace <Namespace>;

page <ObjectID> "<Feature Name> Proposal Sub"
{
    PageType = ListPart;
    SourceTable = "<Feature Name> Proposal";
    SourceTableTemporary = true;
    Caption = 'Suggestions';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number.';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }

                field(Explanation; Rec.Explanation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies why this was suggested.';
                    MultiLine = true;
                }

                field("Confidence Score"; Rec."Confidence Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'AI confidence level for this suggestion.';
                }
            }
        }
    }

    procedure Load(var TmpSource: Record "<Feature Name> Proposal" temporary)
    begin
        Rec.Copy(TmpSource, true);
        CurrPage.Update(false);
    end;
}
```

### Phase 3: Create Main PromptDialog Page

**File**: `<FeatureName>Copilot.Page.al`

**Template Structure**:
```al
namespace <Namespace>;

using System.AI;

page <ObjectID> "<Feature Name> Copilot"
{
    PageType = PromptDialog;
    Extensible = false;
    IsPreview = true;
    Caption = '<User-Friendly Caption>';

    // Choose PromptMode based on user requirements
    PromptMode = Prompt; // or Generate, or Content

    // Optional: For history control
    // SourceTable = "<Feature Name> Proposal";
    // SourceTableTemporary = true;

    layout
    {
        // AREA 1: PromptOptions (Optional settings)
        // Only use for Option or Enum fields
        area(PromptOptions)
        {
            field(OptionField; OptionVariable)
            {
                ApplicationArea = All;
                Caption = '<Option Caption>';
                ToolTip = '<What this option controls>';
                ShowCaption = true;
            }
        }

        // AREA 2: Prompt (User Input)
        area(Prompt)
        {
            field(UserInput; UserPromptText)
            {
                ShowCaption = false;
                MultiLine = true;
                ApplicationArea = All;
                InstructionalText = '<Helpful instruction for user>';

                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
        }

        // AREA 3: Content (AI Output)
        area(Content)
        {
            // Option A: Simple text response
            field(AIResponse; AIResponseText)
            {
                ApplicationArea = All;
                Caption = 'AI Suggestion';
                MultiLine = true;
                Editable = false;
            }

            // Option B: Structured response with subpage
            // part(Proposals; "<Feature Name> Proposal Sub")
            // {
            //     ApplicationArea = All;
            // }
        }
    }

    actions
    {
        // AREA 4: PromptGuide (Help users with examples)
        area(PromptGuide)
        {
            action(Example1)
            {
                ApplicationArea = All;
                Caption = '<Example 1 Caption>';
                ToolTip = '<What this example does>';

                trigger OnAction()
                begin
                    UserPromptText := '<Example 1 text>';
                    CurrPage.Update(false);
                end;
            }

            action(Example2)
            {
                ApplicationArea = All;
                Caption = '<Example 2 Caption>';
                ToolTip = '<What this example does>';

                trigger OnAction()
                begin
                    UserPromptText := '<Example 2 text>';
                    CurrPage.Update(false);
                end;
            }
        }

        // AREA 5: SystemActions (Main Copilot actions)
        area(SystemActions)
        {
            systemaction(Generate)
            {
                Caption = 'Generate';
                ToolTip = 'Generate AI suggestions';

                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }

            systemaction(Regenerate)
            {
                Caption = 'Regenerate';
                ToolTip = 'Generate different suggestions';

                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }

            systemaction(OK)
            {
                Caption = 'Keep it';
                ToolTip = 'Accept and apply suggestions';
            }

            systemaction(Cancel)
            {
                Caption = 'Discard';
                ToolTip = 'Discard suggestions without applying';
            }
        }
    }

    // Page triggers
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = CloseAction::OK then begin
            // User confirmed - apply suggestions
            ApplySuggestions();
        end;
    end;

    // Main generation logic
    local procedure RunGeneration()
    var
        GenerationCodeunit: Codeunit "<Feature Name> Generation";
        TmpResult: Record "<Feature Name> Proposal" temporary;
        Attempts: Integer;
    begin
        // Clear previous results
        ClearResults();

        // Configure generation
        GenerationCodeunit.SetUserPrompt(UserPromptText);
        // Apply any options
        // if OptionVariable = OptionVariable::"Special Filter" then
        //     GenerationCodeunit.SetSpecialFilter();

        // Retry logic for transient failures
        TmpResult.DeleteAll();
        Attempts := 0;

        while TmpResult.IsEmpty and (Attempts < 5) do begin
            if GenerationCodeunit.Run() then
                GenerationCodeunit.GetResult(TmpResult);
            Attempts += 1;
        end;

        if Attempts < 5 then
            LoadResults(TmpResult)
        else
            Error('Failed to generate suggestions after %1 attempts. Please try again. %2', Attempts, GetLastErrorText());
    end;

    local procedure LoadResults(var TmpResult: Record "<Feature Name> Proposal" temporary)
    begin
        // Option A: Simple text
        // AIResponseText := Format(TmpResult);

        // Option B: Subpage
        // CurrPage.Proposals.Page.Load(TmpResult);

        CurrPage.Update(false);
    end;

    local procedure ClearResults()
    begin
        // Clear previous results
        AIResponseText := '';
    end;

    local procedure ApplySuggestions()
    begin
        // Implement logic to apply user-approved suggestions
        Message('Applying suggestions...');
    end;

    // Public procedures for calling page
    procedure SetContext(ContextRecord: Variant)
    begin
        // Set context from calling page
        // Example: SourceItem := ContextRecord;
    end;

    // Variables
    var
        UserPromptText: Text;
        AIResponseText: Text;
        OptionVariable: Option "All","Filtered";
}
```

### Phase 4: Create Generation Codeunit

**File**: `<FeatureName>Generation.Codeunit.al`

**Template**:
```al
namespace <Namespace>;

using System.AI;

codeunit <ObjectID> "<Feature Name> Generation"
{
    trigger OnRun()
    begin
        GenerateSuggestions();
    end;

    procedure SetUserPrompt(InputPrompt: Text)
    begin
        UserPrompt := InputPrompt;
    end;

    procedure GetResult(var TmpResult: Record "<Feature Name> Proposal" temporary)
    begin
        TmpResult.Copy(TmpProposal, true);
    end;

    internal procedure GetCompletionResult(): Text
    begin
        exit(RawCompletionResult);
    end;

    local procedure GenerateSuggestions()
    var
        ResponseText: Text;
        JResponse: JsonToken;
        JItems: JsonToken;
        JsonArray: JsonArray;
    begin
        RawCompletionResult := '';

        // Call Azure OpenAI
        ResponseText := Chat(GetSystemPrompt(), GetUserPromptWithContext(UserPrompt));

        // Parse JSON response
        JResponse.ReadFrom(ResponseText);
        JResponse.AsObject().Get('items', JItems);
        JsonArray := JItems.AsArray();

        // Process results
        ProcessResults(JsonArray);
    end;

    procedure Chat(SystemPrompt: Text; UserPrompt: Text): Text
    var
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
        AOAIDeployments: Codeunit "AOAI Deployments";
        IsolatedStorageWrapper: Codeunit "Isolated Storage Wrapper";
        Result: Text;
    begin
        // Use Microsoft's managed Azure OpenAI (recommended for production)
        AzureOpenAI.SetManagedResourceAuthorization(
            Enum::"AOAI Model Type"::"Chat Completions",
            IsolatedStorageWrapper.GetEndpoint(),
            IsolatedStorageWrapper.GetDeployment(),
            IsolatedStorageWrapper.GetSecretKey(),
            AOAIDeployments.GetGPT4oLatest());

        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"<Your Capability>");

        // Configure completion parameters
        AOAIChatCompletionParams.SetMaxTokens(2500);
        AOAIChatCompletionParams.SetTemperature(0); // 0=deterministic, 1=creative
        AOAIChatCompletionParams.SetJsonMode(true); // Ensure JSON response

        // Build chat messages
        AOAIChatMessages.AddSystemMessage(SystemPrompt);
        AOAIChatMessages.AddUserMessage(UserPrompt);

        // Generate completion
        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);

        if AOAIOperationResponse.IsSuccess() then
            Result := AOAIChatMessages.GetLastMessage()
        else
            Error(AOAIOperationResponse.GetError());

        RawCompletionResult := Result;
        exit(Result);
    end;

    local procedure GetSystemPrompt(): Text
    var
        PromptBuilder: TextBuilder;
    begin
        PromptBuilder.AppendLine('# Role');
        PromptBuilder.AppendLine('You are an expert assistant for <describe feature> in Business Central.');
        PromptBuilder.AppendLine('');
        PromptBuilder.AppendLine('# Task');
        PromptBuilder.AppendLine('<Describe what AI should do>');
        PromptBuilder.AppendLine('');
        PromptBuilder.AppendLine('# Guidelines');
        PromptBuilder.AppendLine('- Base suggestions only on provided data');
        PromptBuilder.AppendLine('- Provide clear explanations for each suggestion');
        PromptBuilder.AppendLine('- Do not make assumptions');
        PromptBuilder.AppendLine('');
        PromptBuilder.AppendLine('# Output Format (JSON)');
        PromptBuilder.AppendLine('{"items": [{"no": "...", "description": "...", "explanation": "..."}]}');

        exit(PromptBuilder.ToText());
    end;

    local procedure GetUserPromptWithContext(InputPrompt: Text): Text
    var
        PromptBuilder: TextBuilder;
    begin
        PromptBuilder.AppendLine('# Context');
        PromptBuilder.AppendLine(GetBusinessCentralContext());
        PromptBuilder.AppendLine('');
        PromptBuilder.AppendLine('# User Request');
        PromptBuilder.AppendLine(InputPrompt);

        exit(PromptBuilder.ToText());
    end;

    local procedure GetBusinessCentralContext(): Text
    begin
        // Build context from BC data
        // Example: Query items, customers, sales orders, etc.
        exit('Current company: ' + CompanyName + ', Date: ' + Format(Today));
    end;

    local procedure ProcessResults(JsonArray: JsonArray)
    var
        JItem: JsonToken;
        i: Integer;
    begin
        TmpProposal.DeleteAll();

        for i := 0 to JsonArray.Count() - 1 do begin
            JsonArray.Get(i, JItem);
            ProcessSingleResult(JItem);
        end;
    end;

    local procedure ProcessSingleResult(JItem: JsonToken)
    var
        NumberToken: JsonToken;
        DescToken: JsonToken;
        ExplToken: JsonToken;
    begin
        TmpProposal.Init();

        if JItem.AsObject().Get('no', NumberToken) then
            TmpProposal."No." := CopyStr(NumberToken.AsValue().AsText(), 1, MaxStrLen(TmpProposal."No."));

        if JItem.AsObject().Get('description', DescToken) then
            TmpProposal.Description := CopyStr(DescToken.AsValue().AsText(), 1, MaxStrLen(TmpProposal.Description));

        if JItem.AsObject().Get('explanation', ExplToken) then
            TmpProposal.Explanation := CopyStr(ExplToken.AsValue().AsText(), 1, MaxStrLen(TmpProposal.Explanation));

        TmpProposal.Insert();
    end;

    var
        TmpProposal: Record "<Feature Name> Proposal" temporary;
        UserPrompt: Text;
        RawCompletionResult: Text;
}
```

### Phase 5: Update Permissions

Add to permission set:
```al
page "<Feature Name> Copilot" = X,
page "<Feature Name> Proposal Sub" = X,
table "<Feature Name> Proposal" = RIMD,
codeunit "<Feature Name> Generation" = X;
```

### Phase 6: Build, Test, and Iterate

1. **Compile**: Use `al_build`
2. **Fix errors**: Review `problems`
3. **Publish**: Use `al_incremental_publish`
4. **Test**:
   - Open PromptDialog from calling page
   - Try all PromptGuide examples
   - Test Generate/Regenerate
   - Test OK/Cancel actions
   - Verify error handling

## Structured Output Requirements

Deliver the following files:
- [ ] Main PromptDialog page
- [ ] Optional: Temporary table for results
- [ ] Optional: Subpage for displaying results
- [ ] Generation codeunit with Azure OpenAI integration
- [ ] Permission set updates
- [ ] Documentation comments

## Human Validation Gate 🚨

**STOP**: Before completing, verify with user:
- [ ] All PromptDialog areas implemented (PromptOptions, Prompt, Content, PromptGuide, SystemActions)
- [ ] PromptMode matches requirements
- [ ] Generate/Regenerate work correctly
- [ ] OK/Cancel actions behave as expected
- [ ] Error handling is graceful
- [ ] Prompts follow responsible AI guidelines
- [ ] Code compiles without errors
- [ ] Page works in Business Central

## Common Issues & Solutions

### Issue: "SystemAction not found"
**Solution**: Ensure PageType = PromptDialog (not Card or Document)

### Issue: "Area not supported"
**Solution**: Verify PromptOptions, Prompt, Content, PromptGuide are spelled correctly

### Issue: AI returns empty results
**Solution**:
- Check system prompt clarity
- Verify JsonMode is true
- Ensure context is being passed
- Test with simpler prompt first

### Issue: "Cannot set PromptMode"
**Solution**: PromptMode must be set at page level, not in trigger

## Success Criteria

- [ ] Page opens correctly
- [ ] InstructionalText guides user
- [ ] PromptGuide examples work
- [ ] Generate produces results
- [ ] Regenerate produces different results
- [ ] OK applies suggestions
- [ ] Cancel discards suggestions
- [ ] Error handling is graceful
- [ ] Responsible AI principles followed

---

**Framework Compliance**: This workflow implements AI-Native Instructions Architecture with Context Loading, Human Validation Gates, and complete Copilot UX patterns.
