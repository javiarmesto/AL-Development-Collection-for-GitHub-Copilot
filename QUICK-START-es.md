# Guía de Inicio Rápido - AL Development Collection

> **⚠️ Aviso sobre Contenido Generado por IA**: Este toolkit utiliza GitHub Copilot e inteligencia artificial generativa para asistir en el desarrollo AL. Las respuestas de los agentes y los resultados de generación de código pueden variar según el contexto, versiones del modelo y las entradas del usuario. Siempre revise y pruebe el código generado exhaustivamente antes de desplegarlo en entornos de producción.

**Desarrollo AL con IA en 2 pasos simples** para Microsoft Dynamics 365 Business Central.

---

## 🚀 Instalación Rápida (5 minutos)

### Opción 1: Extensión de VS Code (Recomendado)
```
1. Instalar desde Marketplace: Buscar "AL Development Collection"
2. Paleta de Comandos: AL Collection: Install Toolkit to Workspace
3. Recargar VS Code
```

### Opción 2: NPM
```bash
npm install github:javiarmesto/AL-Development-Collection-for-GitHub-Copilot
npx al-collection install
```

### Opción 3: Manual
```bash
git clone https://github.com/javiarmesto/AL_Copilot_Collection.git
cd AL_Copilot_Collection
node install.js install [tu-directorio-al]
```

**Después de la instalación**: Recarga VS Code (`Ctrl+Shift+P` → `Developer: Reload Window`)

---

## 📋 Dos Herramientas Principales

### 1️⃣ **al-architect** → Diseña la solución
**Usa cuando**: Necesitas planificar una nueva funcionalidad

```markdown
Use al-architect mode

Necesito construir un sistema de aprobación de ventas con:
- Niveles de aprobación por monto
- Notificaciones por email
- Rastro de auditoría
```

**Resultado**: Arquitectura completa, modelo de datos, puntos de integración

### 2️⃣ **al-conductor** → Implementa con TDD
**Usa cuando**: Tienes el diseño y quieres código listo para producción

```markdown
Use al-conductor mode

Implementa el sistema de aprobación diseñado por al-architect
```

**Resultado**: Código AL completo, 100% de tests, documentación automática

---

## 🎯 Flujo de Trabajo Básico

### Para Funcionalidades Simples (🟢 1-2 objetos)
```
Paso 1: Describe lo que necesitas
Paso 2: Copilot genera el código (con auto-guidelines)
Paso 3: @workspace use al-build → Despliegue
```

**Ejemplo**: "Añade validación de email a tabla Customer"

---

### Para Funcionalidades Moderadas (🟡 3-6 objetos)
```
Paso 1: Use al-architect mode → Diseña
Paso 2: Use al-conductor mode → Implementa con TDD
Paso 3: @workspace use al-permissions → Permisos
Paso 4: @workspace use al-build → Despliegue
```

**Ejemplo**: "Sistema de puntos de lealtad para clientes"

**Tiempo**: 2 horas (vs 2 días manual)

---

### Para Funcionalidades Complejas (🔴 7+ objetos)
```
Paso 1: Use al-architect mode → Arquitectura completa
Paso 2: Use al-api mode (si hay APIs)
Paso 3: Use al-conductor mode → Implementación multi-fase
Paso 4: @workspace use al-performance → Validación
Paso 5: @workspace use al-build → Despliegue
```

**Ejemplo**: "Integración con pasarela de pago externa (OAuth + webhooks)"

**Tiempo**: 1-2 días (vs 1-2 semanas manual)

---

## 💡 ¿Qué Complejidad Tengo?

### 🟢 Simple (Directamente con Copilot)
- ✅ Cambio en 1-2 objetos
- ✅ Validación de campo
- ✅ Extensión de página
- ✅ Campo calculado

### 🟡 Moderada (al-architect + al-conductor)
- ✅ 3-6 objetos relacionados
- ✅ Lógica de negocio con flujos
- ✅ Eventos de integración interna
- ✅ 2-3 fases de implementación

### 🔴 Compleja (al-architect + especialistas + al-conductor)
- ✅ 7+ objetos
- ✅ APIs externas
- ✅ OAuth/autenticación
- ✅ 4+ fases de implementación

---

## 🛠️ Comandos Útiles

### Comandos de Setup
```bash
@workspace use al-initialize    # Inicializa proyecto
@workspace use al-build         # Construye y despliega
@workspace use al-permissions   # Genera permisos
```

### Comandos de Debugging
```bash
@workspace use al-diagnose      # Debug completo
@workspace use al-performance   # Análisis de rendimiento
```

### Modos Especializados
```markdown
Use al-architect mode     # Diseño de arquitectura
Use al-conductor mode     # Implementación TDD
Use al-api mode          # APIs REST/OData
Use al-debugger mode     # Diagnóstico profundo
Use al-tester mode       # Estrategia de testing
```

---

## 📖 Ejemplo Completo: Sistema de Puntos de Lealtad

> **✅ Caso real validado** - Este ejemplo ha sido probado completamente (24/24 validaciones pasadas)

### 🎯 Qué Vamos a Construir

**Sistema de fidelización de clientes** que:
- Acumula puntos automáticamente al facturar ventas (1% del monto)
- Permite canjear puntos por descuentos
- Muestra saldo de puntos en tarjeta de cliente
- Registra historial de transacciones de puntos
- **Complejidad**: 🟡 MEDIUM (3-6 objetos, 2-3 fases)
- **Tiempo**: ~2 horas (vs 2 días manual)

---

### 📋 Paso 1: Diseño con al-architect (20 min)

**Abre VS Code** en tu proyecto AL y ejecuta:

```markdown
Use al-architect mode

Diseña un sistema de puntos de lealtad para clientes con estos requisitos:

FUNCIONALIDAD:
- Los clientes acumulan puntos al facturar ventas (1% del monto)
- Los puntos se pueden canjear por descuentos
- Mostrar saldo de puntos en la tarjeta de cliente
- Registrar todas las transacciones de puntos

REGLAS DE NEGOCIO:
- 1 punto = 1% del monto de venta
- Redención mínima: 100 puntos
- Los puntos no caducan
- Registro de auditoría completo

CONSIDERACIONES TÉCNICAS:
- Usar eventos (no modificar objetos base BC)
- Estructura AL-Go (App vs Test)
- Cobertura de tests 100%
```

**Al-architect responderá con**:

```
📐 ARQUITECTURA: Sistema de Puntos de Lealtad

🗂️ MODELO DE DATOS:
1. Table 50100 "Loyalty Point Entry"
   - Entry No., Customer No., Points, Transaction Type, Sales Document No.
   
2. TableExtension 50100 "Customer Ext" extends Customer
   - "Loyalty Points Balance" (FlowField calculado)
   - "Loyalty Points Enabled" (Boolean)

🔗 INTEGRACIÓN:
- Event Subscriber: OnAfterPostSalesInvoice → Calcular y asignar puntos
- Codeunit 50100 "Loyalty Management" → Lógica de cálculo y redención

📄 UI:
- PageExtension 50100 "Customer Card Ext" → Mostrar saldo
- Page 50100 "Loyalty Point Entries" → Historial

🧪 TESTING:
- Test al OnAfterPostSalesInvoice
- Test al cálculo de puntos
- Test al redención
- Test al FlowField
```

**✅ Arquitectura lista** → Guardada automáticamente en `.github/plans/architecture.md`

---

### 🎭 Paso 2: Implementación TDD con al-conductor (90 min)

**Ahora cambia a al-conductor** para implementar:

```markdown
Use al-conductor mode

Implementa el sistema de puntos de lealtad diseñado por al-architect
```

**Al-conductor orquestará automáticamente**:

#### 📊 Fase de Planning (5 min)
- Planning subagent analiza el proyecto
- Identifica objetos BC existentes
- Propone 7 fases de implementación

#### 🔴 Fase 1: Tabla Loyalty Point Entry (RED → GREEN → REFACTOR)
```
RED (2 min):
- Implementa: al-implement-subagent crea test que falla
- Test: "Insert Loyalty Point Entry with required fields"

GREEN (3 min):
- Implementa: Tabla con campos mínimos
- Test: ✅ PASS

REFACTOR (2 min):
- Review: al-review-subagent valida estructura
- Resultado: Código limpio y eficiente
```

#### 🔴 Fase 2: Customer Extension (RED → GREEN → REFACTOR)
```
RED: Test FlowField calculation
GREEN: TableExtension + FlowField
REFACTOR: Optimización SetLoadFields
```

#### 🔴 Fase 3: Loyalty Management Codeunit (RED → GREEN → REFACTOR)
```
RED: Test cálculo de puntos (1% de $1000 = 10 puntos)
GREEN: Función AddPoints + CalcPoints
REFACTOR: Extracción de constantes
```

#### 🔴 Fase 4: Event Subscriber (RED → GREEN → REFACTOR)
```
RED: Test integración OnAfterPostSalesInvoice
GREEN: Event subscriber que llama AddPoints
REFACTOR: Validación de errores
```

#### 🔴 Fase 5: Redención de Puntos (RED → GREEN → REFACTOR)
```
RED: Test RedeemPoints con validaciones
GREEN: Función con validación mínimo 100 puntos
REFACTOR: Mensajes de error descriptivos
```

#### 🔴 Fase 6: Customer Card Extension (RED → GREEN → REFACTOR)
```
RED: Test UI muestra saldo
GREEN: PageExtension con campo
REFACTOR: Formato y diseño
```

#### 🔴 Fase 7: Loyalty Entries Page (RED → GREEN → REFACTOR)
```
RED: Test navegación y filtrado
GREEN: Página lista con filtros
REFACTOR: Acciones y DrillDown
```

**Resultado Final**:
```
✅ 10 objetos AL creados
✅ 63 tests implementados (100% passing)
✅ Documentación en .github/plans/
✅ Código revisado y validado
✅ Listo para producción
```

---

### 🔒 Paso 3: Permisos y Despliegue (10 min)

```bash
# Generar permisos automáticamente
@workspace use al-permissions

# Construir y desplegar
@workspace use al-build
```

---

### 📦 Objetos Generados

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

### 🧪 Tests Generados (Ejemplos)

```al
[Test]
procedure TestAddPointsFromSales()
begin
    // [GIVEN] Cliente sin puntos
    CreateCustomer(Customer);
    
    // [WHEN] Factura venta de $1000
    CreateAndPostSalesInvoice(Customer, 1000);
    
    // [THEN] Cliente tiene 10 puntos (1% de 1000)
    Assert.AreEqual(10, GetLoyaltyPoints(Customer), 'Points calculation');
end;

[Test]
procedure TestRedeemPoints_Minimum()
begin
    // [GIVEN] Cliente con 50 puntos
    SetCustomerPoints(Customer, 50);
    
    // [WHEN] Intenta canjear
    asserterror RedeemPoints(Customer, 50);
    
    // [THEN] Error: mínimo 100 puntos
    Assert.ExpectedError('Minimum redemption is 100 points');
end;
```

---

### 📊 Resultados Medibles

| Métrica | Manual | Con Orchestra |
|---------|--------|---------------|
| **Tiempo total** | 2 días | 2 horas |
| **Objetos creados** | 10 | 10 |
| **Tests escritos** | 0-10 | 63 (100%) |
| **Bugs en producción** | 3-5 | 0 |
| **Documentación** | Manual | Automática |
| **Code review** | Manual | Automático |

---

### 🎓 Lo Que Aprendiste

✅ **Diseño antes de código** → al-architect planifica todo  
✅ **TDD automático** → al-conductor implementa con tests primero  
✅ **Event-driven** → No modificas objetos base BC  
✅ **Calidad garantizada** → Review automático en cada fase  
✅ **Documentación incluida** → Todo en `.github/plans/`  

---

### 🔄 Reproduce el Ejemplo Completo

**Guía paso a paso detallada**: [REPRODUCIBLE-EXAMPLE.md](./REPRODUCIBLE-EXAMPLE.md)

**Resumen rápido** (desde cero en tu proyecto):

1. **Diseña**:
   ```markdown
   Use al-architect mode
   
   [Copia requisitos del ejemplo]
   ```

2. **Implementa con TDD**:
   ```markdown
   Use al-conductor mode
   
   Implementa el diseño de al-architect
   ```

3. **Despliega**:
   ```bash
   @workspace use al-permissions
   @workspace use al-build
   ```

**Tiempo total**: ~2 horas desde cero hasta producción ✨

**Documentación completa con troubleshooting**: [Ver guía reproducible →](./REPRODUCIBLE-EXAMPLE.md)

---

## ✨ Auto-Guidelines (Trabajan en Segundo Plano)

Mientras codificas, estas reglas se aplican **automáticamente**:

- ✅ **al-code-style** → Formato y estructura
- ✅ **al-naming-conventions** → Nombres PascalCase
- ✅ **al-performance** → SetLoadFields, filtrado temprano
- ✅ **al-error-handling** → TryFunctions, error labels
- ✅ **al-events** → Patrón event-driven
- ✅ **al-testing** → Estructura AL-Go

**No necesitas pedirlas**, simplemente funcionan.

---

### 🎓 Tips para Máximo Rendimiento

### ✅ Haz Esto
1. **Empieza siempre con al-architect** para diseñar antes de codificar
2. **Usa al-conductor** para implementar con calidad TDD automático
3. **Proporciona contexto rico** → Describe requisitos, reglas de negocio, consideraciones
4. **Confía en las auto-guidelines** → Trabajan en segundo plano, no las pidas manualmente
5. **Sigue el ejemplo de Loyalty Points** → Es la referencia validada

### ❌ Evita Esto
1. No saltes el diseño arquitectónico (funcionalidades medias/complejas)
2. No implementes sin tests (al-conductor lo hace automático)
3. No modifiques objetos base BC (siempre usa eventos y extensiones)
4. No ignores los code reviews automáticos de al-review-subagent

---

## 🔧 Troubleshooting Rápido

### "No veo sugerencias de Copilot"
1. Verifica que Copilot está habilitado
2. Recarga VS Code
3. Abre un archivo `.al`

### "Los modos no aparecen"
1. Verifica archivos en `.github/copilot/agents/`
2. Recarga VS Code
3. Revisa que tienen extensión `.agent.md`

### "Validación falla"
```bash
npm install
npm run validate
```

---

## 📚 Documentación Completa

- **[Framework Completo](./al-development.md)** - Guía técnica detallada
- **[Instrucciones](./instructions/)** - Auto-guidelines
- **[Workflows](./prompts/README.md)** - Comandos disponibles
- **[Modos](./agents/)** - Especialistas

---

## 🎯 Siguiente Paso

### Si eres nuevo en AL:
```bash
@workspace use al-initialize
```

### Si tienes una funcionalidad que construir:
```markdown
Use al-architect mode

[Describe tu funcionalidad aquí]
```

### Si tienes un bug:
```markdown
Use al-debugger mode

[Describe el problema]
```

---

**Versión**: 2.7.0  
**Framework**: [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)  
**Última Actualización**: 2025-11-14

---

> **⚠️ Recordatorio del Asistente de IA**: Este contenido se genera con la asistencia de herramientas de IA. Los resultados, las sugerencias de código y las respuestas de los agentes pueden variar según múltiples factores, incluida la calidad de las entradas, el contexto y el comportamiento del modelo de IA. Siempre valide, pruebe y revise el contenido generado por IA antes de usarlo en producción.
