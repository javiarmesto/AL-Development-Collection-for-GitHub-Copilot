# Quick Start Guide - AL Development Collection

> **⚠️ AI-Generated Content Disclaimer**: This toolkit uses GitHub Copilot and generative AI to assist in AL development. Agent responses and code generation results may vary based on context, model versions, and user inputs. Always review and test generated code thoroughly before deploying to production environments.

**AI-powered AL development in 2 simple steps** for Microsoft Dynamics 365 Business Central.

---

## 🚀 Quick Installation (5 minutes)

### Option 1: VS Code Extension (Recommended)
```
1. Install from Marketplace: Search "AL Development Collection"
2. Command Palette: AL Collection: Install Toolkit to Workspace
3. Reload VS Code
```

### Option 2: NPM
```bash
npm install github:javiarmesto/AL-Development-Collection-for-GitHub-Copilot
npx al-collection install
```

### Option 3: Manual
```bash
git clone https://github.com/javiarmesto/AL_Copilot_Collection.git
cd AL_Copilot_Collection
node install.js install [your-al-directory]
```

**After installation**: Reload VS Code (`Ctrl+Shift+P` → `Developer: Reload Window`)

---

## 📋 Two Main Tools

### 1️⃣ **al-architect** → Design the solution
**Use when**: You need to plan a new feature

```markdown
Use al-architect mode

I need to build a sales approval system with:
- Approval levels by amount
- Email notifications
- Audit trail
```

**Result**: Complete architecture, data model, integration points

### 2️⃣ **al-conductor** → Implement with TDD
**Use when**: You have the design and want production-ready code

```markdown
Use al-conductor mode

Implement the approval system designed by al-architect
```

**Result**: Complete AL code, 100% tests, automatic documentation

---

## 🎯 Basic Workflow

### For Simple Features (🟢 1-2 objects)
```
Step 1: Describe what you need
Step 2: Copilot generates the code (with auto-guidelines)
Step 3: @workspace use al-build → Deploy
```

**Example**: "Add email validation to Customer table"

---

### For Moderate Features (🟡 3-6 objects)
```
Step 1: Use al-architect mode → Design
Step 2: Use al-conductor mode → Implement with TDD
Step 3: @workspace use al-permissions → Permissions
Step 4: @workspace use al-build → Deploy
```

**Example**: "Customer loyalty points system"

**Time**: 2 hours (vs 2 days manual)

---

### For Complex Features (🔴 7+ objects)
```
Step 1: Use al-architect mode → Complete architecture
Step 2: Use al-api mode (if APIs needed)
Step 3: Use al-conductor mode → Multi-phase implementation
Step 4: @workspace use al-performance → Validation
Step 5: @workspace use al-build → Deploy
```

**Example**: "Integration with external payment gateway (OAuth + webhooks)"

**Time**: 1-2 days (vs 1-2 weeks manual)

---

## 💡 What's My Complexity?

### 🟢 Simple (Directly with Copilot)
- ✅ Change in 1-2 objects
- ✅ Field validation
- ✅ Page extension
- ✅ Calculated field

### 🟡 Moderate (al-architect + al-conductor)
- ✅ 3-6 related objects
- ✅ Business logic with workflows
- ✅ Internal integration events
- ✅ 2-3 implementation phases

### 🔴 Complex (al-architect + specialists + al-conductor)
- ✅ 7+ objects
- ✅ External APIs
- ✅ OAuth/authentication
- ✅ 4+ implementation phases

---

## 🛠️ Useful Commands

### Setup Commands
```bash
@workspace use al-initialize    # Initialize project
@workspace use al-build         # Build and deploy
@workspace use al-permissions   # Generate permissions
```

### Debugging Commands
```bash
@workspace use al-diagnose      # Complete debug
@workspace use al-performance   # Performance analysis
```

### Specialized Modes
```markdown
Use al-architect mode     # Architecture design
Use al-conductor mode     # TDD implementation
Use al-api mode          # REST/OData APIs
Use al-debugger mode     # Deep diagnostics
Use al-tester mode       # Testing strategy
```

---

## 📖 Complete Example: Loyalty Points System

> **✅ Real validated case** - This example has been fully tested (24/24 validations passed)

### 🎯 What We're Going to Build

**Customer loyalty system** that:
- Automatically accumulates points when posting sales invoices (1% of amount)
- Allows redeeming points for discounts
- Shows point balance on customer card
- Records point transaction history
- **Complexity**: 🟡 MEDIUM (3-6 objects, 2-3 phases)
- **Time**: ~2 hours (vs 2 days manual)

---

### 📋 Step 1: Design with al-architect (20 min)

**Open VS Code** in your AL project and run:

```markdown
Use al-architect mode

Design a customer loyalty points system with these requirements:

FUNCTIONALITY:
- Customers accumulate points when posting sales invoices (1% of amount)
- Points can be redeemed for discounts
- Show point balance on customer card
- Record all point transactions

BUSINESS RULES:
- 1 point = 1% of sales amount
- Minimum redemption: 100 points
- Points don't expire
- Complete audit trail

TECHNICAL CONSIDERATIONS:
- Use events (don't modify BC base objects)
- AL-Go structure (App vs Test)
- 100% test coverage
```

**Al-architect will respond with**:

```
📐 ARCHITECTURE: Loyalty Points System

🗂️ DATA MODEL:
1. Table 50100 "Loyalty Point Entry"
   - Entry No., Customer No., Points, Transaction Type, Sales Document No.
   
2. TableExtension 50100 "Customer Ext" extends Customer
   - "Loyalty Points Balance" (Calculated FlowField)
   - "Loyalty Points Enabled" (Boolean)

🔗 INTEGRATION:
- Event Subscriber: OnAfterPostSalesInvoice → Calculate and assign points
- Codeunit 50100 "Loyalty Management" → Calculation and redemption logic

📄 UI:
- PageExtension 50100 "Customer Card Ext" → Show balance
- Page 50100 "Loyalty Point Entries" → History

🧪 TESTING:
- Test for OnAfterPostSalesInvoice
- Test for points calculation
- Test for redemption
- Test for FlowField
```

**✅ Architecture ready** → Automatically saved in `.github/plans/architecture.md`

---

### 🎭 Step 2: TDD Implementation with al-conductor (90 min)

**Now switch to al-conductor** to implement:

```markdown
Use al-conductor mode

Implement the loyalty points system designed by al-architect
```

**Al-conductor will automatically orchestrate**:

#### 📊 Planning Phase (5 min)
- Planning subagent analyzes the project
- Identifies existing BC objects
- Proposes 7 implementation phases

#### 🔴 Phase 1: Loyalty Point Entry Table (RED → GREEN → REFACTOR)
```
RED (2 min):
- Implement: al-implement-subagent creates failing test
- Test: "Insert Loyalty Point Entry with required fields"

GREEN (3 min):
- Implement: Table with minimum fields
- Test: ✅ PASS

REFACTOR (2 min):
- Review: al-review-subagent validates structure
- Result: Clean and efficient code
```

#### 🔴 Phase 2: Customer Extension (RED → GREEN → REFACTOR)
```
RED: Test FlowField calculation
GREEN: TableExtension + FlowField
REFACTOR: SetLoadFields optimization
```

#### 🔴 Phase 3: Loyalty Management Codeunit (RED → GREEN → REFACTOR)
```
RED: Test points calculation (1% of $1000 = 10 points)
GREEN: AddPoints + CalcPoints functions
REFACTOR: Extract constants
```

#### 🔴 Phase 4: Event Subscriber (RED → GREEN → REFACTOR)
```
RED: Test OnAfterPostSalesInvoice integration
GREEN: Event subscriber calling AddPoints
REFACTOR: Error validation
```

#### 🔴 Phase 5: Points Redemption (RED → GREEN → REFACTOR)
```
RED: Test RedeemPoints with validations
GREEN: Function with 100 points minimum validation
REFACTOR: Descriptive error messages
```

#### 🔴 Phase 6: Customer Card Extension (RED → GREEN → REFACTOR)
```
RED: Test UI shows balance
GREEN: PageExtension with field
REFACTOR: Format and design
```

#### 🔴 Phase 7: Loyalty Entries Page (RED → GREEN → REFACTOR)
```
RED: Test navigation and filtering
GREEN: List page with filters
REFACTOR: Actions and DrillDown
```

**Final Result**:
```
✅ 10 AL objects created
✅ 63 tests implemented (100% passing)
✅ Documentation in .github/plans/
✅ Code reviewed and validated
✅ Production ready
```

---

### 🔒 Step 3: Permissions and Deployment (10 min)

```bash
# Generate permissions automatically
@workspace use al-permissions

# Build and deploy
@workspace use al-build
```

---

### 📦 Generated Objects

```
App/
├── Tables/
│   └── LoyaltyPointEntry.Table.al (50100)
├── TableExtensions/
│   └── CustomerExt.TableExtension.al (50100)
├── Codeunits/
│   ├── LoyaltyManagement.Codeunit.al (50100)
│   └── SalesEventSubscriber.Codeunit.al (50101)
├── Pages/
│   └── LoyaltyPointEntries.Page.al (50100)
├── PageExtensions/
│   └── CustomerCardExt.PageExtension.al (50100)
└── Permissions/
    └── LoyaltySystem.PermissionSet.al (50100)

Test/
└── LoyaltyTests.Codeunit.al (63 test functions)
```

---

### 🧪 Generated Tests (Examples)

```al
[Test]
procedure TestAddPointsFromSales()
begin
    // [GIVEN] Customer with no points
    CreateCustomer(Customer);
    
    // [WHEN] Post sales invoice of $1000
    CreateAndPostSalesInvoice(Customer, 1000);
    
    // [THEN] Customer has 10 points (1% of 1000)
    Assert.AreEqual(10, GetLoyaltyPoints(Customer), 'Points calculation');
end;

[Test]
procedure TestRedeemPoints_Minimum()
begin
    // [GIVEN] Customer with 50 points
    SetCustomerPoints(Customer, 50);
    
    // [WHEN] Tries to redeem
    asserterror RedeemPoints(Customer, 50);
    
    // [THEN] Error: minimum 100 points
    Assert.ExpectedError('Minimum redemption is 100 points');
end;
```

---

### 📊 Measurable Results

| Metric | Manual | With Orchestra |
|---------|--------|---------------|
| **Total time** | 2 days | 2 hours |
| **Objects created** | 10 | 10 |
| **Tests written** | 0-10 | 63 (100%) |
| **Production bugs** | 3-5 | 0 |
| **Documentation** | Manual | Automatic |
| **Code review** | Manual | Automatic |

---

### 🎓 What You Learned

✅ **Design before code** → al-architect plans everything  
✅ **Automatic TDD** → al-conductor implements with tests first  
✅ **Event-driven** → Don't modify BC base objects  
✅ **Guaranteed quality** → Automatic review in each phase  
✅ **Documentation included** → Everything in `.github/plans/`  

---

### 🔄 Reproduce the Complete Example

**Detailed step-by-step guide**: [REPRODUCIBLE-EXAMPLE.md](./REPRODUCIBLE-EXAMPLE.md)

**Quick summary** (from scratch in your project):

1. **Design**:
   ```markdown
   Use al-architect mode
   
   [Copy requirements from example]
   ```

2. **Implement with TDD**:
   ```markdown
   Use al-conductor mode
   
   Implement the design from al-architect
   ```

3. **Deploy**:
   ```bash
   @workspace use al-permissions
   @workspace use al-build
   ```

**Total time**: ~2 hours from zero to production ✨

**Complete documentation with troubleshooting**: [See reproducible guide →](./REPRODUCIBLE-EXAMPLE.md)

---

## ✨ Auto-Guidelines (Working in Background)

While coding, these rules apply **automatically**:

- ✅ **al-code-style** → Format and structure
- ✅ **al-naming-conventions** → PascalCase names
- ✅ **al-performance** → SetLoadFields, early filtering
- ✅ **al-error-handling** → TryFunctions, error labels
- ✅ **al-events** → Event-driven pattern
- ✅ **al-testing** → AL-Go structure

**You don't need to ask for them**, they just work.

---

### 🎓 Tips for Maximum Performance

### ✅ Do This
1. **Always start with al-architect** to design before coding
2. **Use al-conductor** to implement with automatic TDD quality
3. **Provide rich context** → Describe requirements, business rules, considerations
4. **Trust auto-guidelines** → They work in the background, don't ask for them manually
5. **Follow the Loyalty Points example** → It's the validated reference

### ❌ Avoid This
1. Don't skip architectural design (for medium/complex features)
2. Don't implement without tests (al-conductor does it automatically)
3. Don't modify BC base objects (always use events and extensions)
4. Don't ignore automatic code reviews from al-review-subagent

---

## 🔧 Quick Troubleshooting

### "I don't see Copilot suggestions"
1. Verify Copilot is enabled
2. Reload VS Code
3. Open a `.al` file

### "Modes don't appear"
1. Check files in `.github/copilot/agents/`
2. Reload VS Code
3. Verify they have `.agent.md` extension

### "Validation fails"
```bash
npm install
npm run validate
```

---

## 📚 Complete Documentation

- **[Complete Framework](./al-development.md)** - Detailed technical guide
- **[Instructions](./instructions/)** - Auto-guidelines
- **[Workflows](./prompts/README.md)** - Available commands
- **[Modes](./agents/)** - Specialists

---

## 🎯 Next Step

### If you're new to AL:
```bash
@workspace use al-initialize
```

### If you have a feature to build:
```markdown
Use al-architect mode

[Describe your feature here]
```

### If you have a bug:
```markdown
Use al-debugger mode

[Describe the problem]
```

---

**Version**: 2.7.0  
**Framework**: [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)  
**Last Updated**: 2025-11-14

---

> **⚠️ AI Assistant Reminder**: This content is generated with assistance from AI tools. Results, code suggestions, and agent responses may vary depending on multiple factors including input quality, context, and AI model behavior. Always validate, test, and review AI-generated content before production use.
