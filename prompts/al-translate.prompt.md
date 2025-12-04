---
agent: agent
model: Claude Opus 4.5 (Preview) (copilot)
description: 'Translate AL extensions using XLF translation files for Business Central multilingual support.'
tools: ['vscode', 'execute', 'read', 'al-symbols-mcp/*', 'edit', 'search', 'web', 'microsoft-docs/*', 'agent', 'memory', 'nabsolutions.nab-al-tools/refreshXlf', 'nabsolutions.nab-al-tools/getTextsToTranslate', 'nabsolutions.nab-al-tools/getTranslatedTextsMap', 'nabsolutions.nab-al-tools/getTextsByKeyword', 'nabsolutions.nab-al-tools/getTranslatedTextsByState', 'nabsolutions.nab-al-tools/saveTranslatedTexts', 'nabsolutions.nab-al-tools/createLanguageXlf', 'nabsolutions.nab-al-tools/getGlossaryTerms', 'todo']
---

# AL Translation Workflow

Your goal is to translate AL extension texts for `${input:TargetLanguage}`.

## Translation Workflow

### 1. Identify Translation Files

Locate XLF files in the Translations folder:
- `.g.xlf` - Generated translation file (source)
- Language-specific files (e.g., `MyApp.es-ES.xlf`)

### 2. Create or Refresh Language File

#### Creating a New Language File
```
createLanguageXlf
```
Parameters:
- `generatedXlfFilePath`: Path to the .g.xlf file
- `targetLanguageCode`: Language code (e.g., 'es-ES', 'fr-FR', 'de-DE')
- `matchBaseAppTranslation`: true (to pre-populate with Microsoft's base translations)

#### Refreshing an Existing Language File
```
refreshXlf
```
Parameters:
- `generatedXlfFilePath`: Path to the .g.xlf file
- `filePath`: Path to the language-specific XLF file to refresh

### 3. Retrieve Texts to Translate

#### Get Untranslated Texts
```
getTextsToTranslate
```
Parameters:
- `filePath`: Path to the XLF file
- `limit`: Number of texts to retrieve (0 for all)
- `offset`: Starting position (for pagination)

Returns:
- `id`: Unique identifier
- `source`: Text to translate
- `sourceLanguage`: Source language code
- `type`: Context (e.g., 'Table Customer - Field Name - Property Caption')
- `maxLength`: Character limit (if applicable)
- `comments`: Contextual information about placeholders (%1, %2, etc.)

#### Search Specific Texts
```
getTextsByKeyword
```
Parameters:
- `filePath`: Path to the XLF file
- `keyword`: Search term or regex pattern
- `limit`: Number of results
- `isRegex`: true/false
- `caseSensitive`: true/false
- `searchInTarget`: true (search in translations) / false (search in source)

### 4. Translation Strategy

#### Using Translation Memory
```
getTranslatedTextsMap
```
Parameters:
- `filePath`: Path to a reference XLF file
- `limit`: Number of translations (0 for all)

Use this to:
- Maintain consistency with previous translations
- Reference similar language translations (e.g., es-ES vs es-MX)
- Build a translation glossary

#### Review Translations by State
```
getTranslatedTextsByState
```
Parameters:
- `filePath`: Path to the XLF file
- `translationStateFilter`: 'needs-review', 'translated', 'final', 'signed-off'
- `limit`: Number of texts
- `sourceText`: Optional filter for specific source text

### 5. Translate and Save

#### Translation Best Practices

1. **Preserve Placeholders**
   - Source: `"Processing %1 records"`
   - Translation: `"Procesando %1 registros"`
   - Keep %1, %2, %3 in the same order

2. **Respect Character Limits**
   - Check `maxLength` property
   - Adjust translation to fit constraints
   - Use abbreviations if necessary

3. **Maintain Context**
   - Review `type` field for object context
   - Field captions may differ from action captions
   - Consider UI space constraints

4. **Use Consistent Terminology**
   - Reference `getTranslatedTextsMap` for existing translations
   - Maintain glossary of technical terms
   - Follow Microsoft's base app translations

#### Save Translations
```
saveTranslatedTexts
```
Parameters:
- `filePath`: Path to the XLF file
- `translations`: Array of translation objects

Translation object structure:
```json
{
  "id": "unique-identifier",
  "targetText": "Translated text",
  "targetState": "translated" // or "needs-review-translation", "final", "signed-off"
}
```

**Batch Translation Example:**
```json
{
  "filePath": "c:/path/to/MyApp.es-ES.xlf",
  "translations": [
    {
      "id": "Table_Customer_Field_Name_Caption",
      "targetText": "Nombre",
      "targetState": "translated"
    },
    {
      "id": "Page_CustomerCard_Action_NewSalesOrder_Caption",
      "targetText": "Nuevo pedido de venta",
      "targetState": "translated"
    }
  ]
}
```

### 6. Quality Assurance

#### Translation Review Workflow

1. **First Pass** - Initial translation
   - State: `translated`
   - Review context and placeholders

2. **Review Pass** - Quality check
   - State: `needs-review-translation`
   - Verify terminology consistency
   - Check character limits
   - Test in UI if possible

3. **Final Pass** - Approval
   - State: `final`
   - Native speaker review
   - UI/UX validation

4. **Sign-off** - Production ready
   - State: `signed-off`
   - Ready for deployment

#### Common Translation Issues

**Issue 1: Placeholder Mismatch**
```
❌ Source: "Posted %1 of %2"
❌ Translation: "Registrado %2"  // Missing %1
✅ Translation: "Registrado %1 de %2"
```

**Issue 2: Character Limit Exceeded**
```
❌ Source: "Post" (maxLength: 10)
❌ Translation: "Registrar y contabilizar"  // Too long
✅ Translation: "Registrar"
```

**Issue 3: Context Ignored**
```
Source: "Post"
Context 1: "Page SalesOrder - Action Post - Caption"
Translation: "Registrar" ✅

Context 2: "Table Post - Field Name - Caption"
Translation: "Poste" ✅  // Different meaning!
```

### 7. Translation Workflow Example

#### Scenario: Translate Customer Module to Spanish

**Step 1: Create language file**
```
createLanguageXlf(
  generatedXlfFilePath: "c:/MyApp/Translations/MyApp.g.xlf",
  targetLanguageCode: "es-ES",
  matchBaseAppTranslation: true
)
```

**Step 2: Get untranslated texts**
```
getTextsToTranslate(
  filePath: "c:/MyApp/Translations/MyApp.es-ES.xlf",
  limit: 50,
  offset: 0
)
```

**Step 3: Check existing translations**
```
getTranslatedTextsMap(
  filePath: "c:/ReferenceApp/Translations/Reference.es-ES.xlf",
  limit: 0
)
```

**Step 4: Translate batch**
```
saveTranslatedTexts(
  filePath: "c:/MyApp/Translations/MyApp.es-ES.xlf",
  translations: [
    { id: "...", targetText: "...", targetState: "translated" },
    { id: "...", targetText: "...", targetState: "translated" }
  ]
)
```

**Step 5: Review translations**
```
getTranslatedTextsByState(
  filePath: "c:/MyApp/Translations/MyApp.es-ES.xlf",
  translationStateFilter: "translated",
  limit: 0
)
```

**Step 6: Mark for review**
```
saveTranslatedTexts(
  filePath: "c:/MyApp/Translations/MyApp.es-ES.xlf",
  translations: [
    { id: "...", targetText: "...", targetState: "needs-review-translation" }
  ]
)
```

**Step 7: Final approval**
```
saveTranslatedTexts(
  filePath: "c:/MyApp/Translations/MyApp.es-ES.xlf",
  translations: [
    { id: "...", targetText: "...", targetState: "final" }
  ]
)
```

## Language Codes Reference

### Common Language Codes
- `es-ES` - Spanish (Spain)
- `es-MX` - Spanish (Mexico)
- `fr-FR` - French (France)
- `fr-CA` - French (Canada)
- `de-DE` - German (Germany)
- `de-AT` - German (Austria)
- `it-IT` - Italian
- `pt-PT` - Portuguese (Portugal)
- `pt-BR` - Portuguese (Brazil)
- `nl-NL` - Dutch (Netherlands)
- `nl-BE` - Dutch (Belgium)
- `da-DK` - Danish
- `sv-SE` - Swedish
- `nb-NO` - Norwegian (Bokmål)
- `fi-FI` - Finnish
- `pl-PL` - Polish
- `cs-CZ` - Czech
- `ru-RU` - Russian
- `zh-CN` - Chinese (Simplified)
- `zh-TW` - Chinese (Traditional)
- `ja-JP` - Japanese
- `ko-KR` - Korean

## Advanced Scenarios

### Scenario 1: Regional Variations
When translating for multiple regions (e.g., es-ES vs es-MX):

1. Create base translation (es-ES)
2. Use `getTranslatedTextsMap` to copy to regional variant
3. Adjust regional-specific terms
4. Save with appropriate language code

### Scenario 2: Translation Glossary
Build consistent terminology:

```
getTextsByKeyword(
  filePath: "MyApp.es-ES.xlf",
  keyword: "Customer|Sales|Invoice|Post",
  isRegex: true,
  searchInTarget: true
)
```

### Scenario 3: Incremental Updates
After code changes:

1. Refresh XLF: `refreshXlf`
2. Get new texts: `getTextsToTranslate`
3. Preserve existing translations (auto-maintained)
4. Translate only new items

### Scenario 4: Quality Review
Review translations that need attention:

```
getTranslatedTextsByState(
  filePath: "MyApp.es-ES.xlf",
  translationStateFilter: "needs-review",
  limit: 0
)
```

## Best Practices

### 1. Translation Memory
- Maintain a reference translation file
- Use `getTranslatedTextsMap` for consistency
- Build glossaries for technical terms

### 2. Batch Operations
- Translate in batches (20-50 items)
- Use consistent terminology within batch
- Save progress frequently

### 3. Context Awareness
- Always review the `type` field
- Consider UI placement and space
- Test translations in actual pages when possible

### 4. Quality Control
- Use translation states effectively
- Implement review workflows
- Native speaker validation

### 5. Automation
- Use `matchBaseAppTranslation` for base app terms
- Reference similar language variants
- Maintain translation glossaries

## Workflow Summary

1. **Setup**: Create or refresh language file
2. **Retrieve**: Get texts to translate with context
3. **Research**: Check translation memory and glossaries
4. **Translate**: Translate batch respecting context and limits
5. **Save**: Save translations with appropriate state
6. **Review**: Quality check and state progression
7. **Deploy**: Final approval and sign-off

## Success Criteria

- ✅ All required texts translated
- ✅ Placeholders preserved correctly
- ✅ Character limits respected
- ✅ Terminology consistent
- ✅ Context-appropriate translations
- ✅ Quality review completed
- ✅ Translations marked with correct state
