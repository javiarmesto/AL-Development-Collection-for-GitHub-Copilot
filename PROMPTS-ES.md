# Prompts de Desarrollo AL - Documentación de Parámetros

Este documento proporciona una visión completa de todos los prompts en la Colección de Desarrollo AL y el uso de sus parámetros.

## Resumen

La colección incluye **10 prompts específicos de tareas** que se pueden invocar usando:
```
@workspace use [nombre-prompt]
```

## Análisis de Parámetros

### Uso Actual de Parámetros

Todos los prompts actualmente usan variables `${input:NombreParametro}` en su declaración de objetivo. Estos parámetros son **opcionales** y sirven para proporcionar contexto. Los prompts funcionan con o sin estos parámetros ya que GitHub Copilot puede entender el contexto de:
- La solicitud en lenguaje natural del usuario
- Los archivos del workspace actual
- Archivos abiertos y contexto de código
- Historial de conversación

### Recomendación

**Los parámetros NO son estrictamente necesarios** para la funcionalidad de los prompts. Se utilizan principalmente para:
1. Hacer la declaración de objetivo más específica
2. Proporcionar un marcador para que los usuarios entiendan qué contexto proporcionar
3. Consistencia con los patrones de variables de entrada de VS Code

Los usuarios pueden simplemente invocar los prompts y describir sus necesidades en lenguaje natural, y Copilot entenderá el contexto.

## Tabla de Referencia de Prompts

| Nombre del Prompt | Comando | Parámetros | Descripción del Parámetro | ¿Requerido? | Valores de Ejemplo |
|-------------------|---------|------------|---------------------------|-------------|--------------------|
| **al-workspace** | `@workspace use al-workspace` | `ProjectName` | Nombre del proyecto AL a configurar | No | "GestiónClientes", "ExtensiónVentas", "AppInventario" |
| **al-build** | `@workspace use al-build` | `DeploymentType` | Entorno de destino para el despliegue | No | "Development", "Testing", "Production", "Existing Package Deployment", "Full Dependency Package" |
| **al-events** | `@workspace use al-events` | `EventScenario` | Funcionalidad de eventos a implementar | No | "Registro de documentos", "Validación de datos maestros", "Disparador de integración", "Extensión de workflow", "Personalización de UI" |
| **al-debug** | `@workspace use al-debug` | `DebugScenario` | Problema o escenario a depurar | No | "Error de permisos", "Problema de datos", "Problema de flujo de eventos", "Cuello de botella de rendimiento", "Error de runtime" |
| **al-performance** | `@workspace use al-performance` | `PerformanceIssue` | Problema de rendimiento a analizar | No | "Informe lento", "Carga de página", "Procesamiento por lotes", "Cálculo de FlowField", "Error recursivo AL0896" |
| **al-permissions** | `@workspace use al-permissions` | `ExtensionName` | Extensión para generar permisos | No | "MiExtensiónPersonalizada", "MejoraVentas", "HerramientasInventario" |
| **al-troubleshoot** | `@workspace use al-troubleshoot` | `IssueDescription` | Problema a diagnosticar y resolver | No | "Autenticación fallida", "Símbolos faltantes", "Error de compilación", "Falla de publicación", "Conflicto de versiones" |
| **al-migrate** | `@workspace use al-migrate` | `SourceVersion`, `TargetVersion` | Versiones actuales y objetivo de BC | No | Origen: "BC 20.x", "BC 21.x", "BC 22.x"<br>Destino: "BC 21.x", "BC 22.x", "BC 23.x", "BC 24.x" |
| **al-pages** | `@workspace use al-pages` | `PagePurpose` | Propósito de la página a diseñar | No | "Mejora de ficha de cliente", "Lista de ventas", "Página de documento", "Hoja de trabajo", "Role Center", "Vista móvil" |
| **al-workflow** | `@workspace use al-workflow` | `ProjectDescription` | Descripción del flujo de trabajo del proyecto | No | "Nueva funcionalidad de ventas", "Integración API", "Desarrollo de informe", "Personalización de página" |

## Detalles de Parámetros por Prompt

### al-workspace
**Parámetro:** `ProjectName`
- **Propósito:** Identifica el proyecto AL que se está configurando
- **Usado en:** Solo en la declaración de objetivo
- **Se puede omitir:** Sí - Copilot preguntará o inferirá del contexto
- **Alternativa:** Simplemente indique "Necesito configurar un workspace AL para gestión de clientes"

---

### al-build
**Parámetro:** `DeploymentType`
- **Propósito:** Especifica el entorno de despliegue objetivo
- **Usado en:** Declaración de objetivo y selección de flujo de trabajo
- **Se puede omitir:** Sí - El usuario puede especificarlo en lenguaje natural
- **Opciones:**
  - **Entorno de Desarrollo:** Iteración rápida con `al_incremental_publish`
  - **Entorno de Testing:** Validación completa con depuración habilitada
  - **Entorno de Producción:** Build de release sin símbolos de depuración
  - **Despliegue de Paquete Existente:** Desplegar archivos .app pre-compilados
  - **Paquete con Dependencias Completas:** Paquete con todas las dependencias para instalación offline

---

### al-events
**Parámetro:** `EventScenario`
- **Propósito:** Describe la funcionalidad de eventos a implementar
- **Usado en:** Solo en la declaración de objetivo
- **Se puede omitir:** Sí - El usuario describe el escenario naturalmente
- **Escenarios comunes:**
  - Intervenciones en registro de documentos
  - Validaciones de datos maestros
  - Disparadores de integración
  - Extensiones de workflow
  - Personalizaciones de UI

---

### al-debug
**Parámetros:** `DebugScenario`, `EnvironmentName` (en ejemplo de código)
- **Propósito:** Identifica qué necesita ser depurado
- **Usado en:** Declaración de objetivo y configuración de ejemplo
- **Se puede omitir:** Sí para DebugScenario; EnvironmentName es una variable de VS Code
- **Métodos de depuración:**
  - Depuración estándar con publicación
  - Depuración sin publicar
  - Depuración incremental
  - Depuración por snapshots (para problemas intermitentes)
  - Depuración de sesión de agente

**Nota:** `${input:EnvironmentName}` en launch.json es una variable de entrada de VS Code, no un parámetro del prompt.

---

### al-performance
**Parámetro:** `PerformanceIssue`
- **Propósito:** Especifica el problema de rendimiento a analizar
- **Usado en:** Solo en la declaración de objetivo
- **Se puede omitir:** Sí - El usuario describe el problema
- **Problemas comunes:**
  - Dependencias recursivas de FlowField (AL0896)
  - Consultas ineficientes
  - Necesidades de optimización de bucles
  - Patrones de acceso a base de datos
  - Problemas de estructura de código

---

### al-permissions
**Parámetro:** `ExtensionName`
- **Propósito:** Identifica qué extensión necesita permisos
- **Usado en:** Solo en la declaración de objetivo
- **Se puede omitir:** Sí - Se infiere del contexto del workspace
- **Tipos de permisos:**
  - Objeto AL Permission Set (archivo `.al`)
  - XML Permission Set (formato legacy)
  - Conjuntos de permisos basados en roles (Base, Usuario, Admin)

---

### al-troubleshoot
**Parámetro:** `IssueDescription`
- **Propósito:** Describe el problema a resolver
- **Usado en:** Solo en la declaración de objetivo
- **Se puede omitir:** Sí - El usuario describe el problema naturalmente
- **Problemas comunes:**
  - Problemas de autenticación
  - Problemas de símbolos (faltantes o conflictos de versión)
  - Errores de compilación
  - Fallos de publicación
  - Errores recursivos AL0896 de FlowField

---

### al-migrate
**Parámetros:** `SourceVersion`, `TargetVersion`
- **Propósito:** Especifica la ruta de migración entre versiones de BC
- **Usado en:** Declaración de objetivo y configuraciones de ejemplo
- **Se puede omitir:** Sí - El usuario especifica versiones en la descripción
- **Rutas de versión:**
  - BC 20.x → BC 21.x
  - BC 21.x → BC 22.x
  - BC 22.x → BC 23.x
  - BC 23.x → BC 24.x

**Nota:** `${input:TargetVersion}` en el ejemplo de app.json es un marcador de posición para documentación, no una variable activa de VS Code.

---

### al-pages
**Parámetro:** `PagePurpose`
- **Propósito:** Describe la intención del diseño de página
- **Usado en:** Solo en la declaración de objetivo
- **Se puede omitir:** Sí - Descrito en la solicitud del usuario
- **Tipos de página:**
  - Card Pages (visualización de registro único)
  - List Pages (múltiples registros)
  - Document Pages (estructura header/lines)
  - Worksheet Pages (entrada de datos)
  - Role Centers (dashboards de usuario)
  - Page Extensions (personalizar páginas existentes)

---

### al-workflow
**Parámetro:** `ProjectDescription`
- **Propósito:** Descripción general del proyecto para guía end-to-end
- **Usado en:** Solo en la declaración de objetivo
- **Se puede omitir:** Sí - El usuario describe su proyecto
- **Fases del workflow:**
  - Fase 1: Configuración del Proyecto
  - Fase 2: Desarrollo
  - Fase 3: Testing
  - Fase 4: Seguridad
  - Fase 5: Despliegue

---

## Recomendaciones de Uso

### Sin Parámetros (Recomendado)
Simplemente invoque el prompt y describa sus necesidades:

```
@workspace use al-workspace
"Necesito configurar un nuevo proyecto AL para gestión de clientes"
```

```
@workspace use al-build
"Desplegar esto a nuestro entorno de testing"
```

```
@workspace use al-debug
"Estoy obteniendo un error de permisos al registrar pedidos de venta"
```

### Con Parámetros (Opcional)
Si prefiere entrada estructurada, puede proporcionar contexto en su descripción:

```
@workspace use al-migrate
"Migrar de BC 22.5 a BC 24.0"
```

```
@workspace use al-performance
"El informe de ventas está tardando 30 segundos en generar con datasets grandes"
```

## Notas Técnicas

### Variables de Entrada de VS Code
Algunos prompts incluyen `${input:NombreVariable}` en fragmentos de código de ejemplo (ej., launch.json, app.json). Estas son:
- **Variables de entrada de VS Code** para usar en archivos de configuración
- **NO** son parámetros del prompt
- **Ejemplos** para que los usuarios implementen en sus propias configuraciones

### Parámetro de Prompt vs Variable de Configuración

| Tipo | Ubicación | Propósito | Requerido |
|------|-----------|-----------|-----------|
| **Parámetro de Prompt** | Declaración de objetivo (`Your goal is...`) | Contexto para Copilot | No |
| **Variable de Entrada de VS Code** | Ejemplos de archivos de configuración | Configuración en tiempo de ejecución | Depende de VS Code |

## Consideraciones Futuras

### Posibles Mejoras

1. **Hacer parámetros opcionales en prompts:**
   - Eliminar `${input:Parametro}` de las declaraciones de objetivo
   - Usar declaraciones de objetivo más genéricas como "Tu objetivo es guiar al usuario a través de..."
   - Dejar que Copilot extraiga el contexto del lenguaje natural del usuario

2. **Agregar validación de parámetros:**
   - Si se mantienen los parámetros, documentar valores válidos
   - Proporcionar sugerencias de autocompletado
   - Agregar esquemas de parámetros

3. **Prompts conscientes del contexto:**
   - Detectar el estado actual del workspace
   - Inferir escenarios comunes automáticamente
   - Sugerir parámetros basados en el contexto de archivos

## Conclusión

**Todos los parámetros en los archivos de prompt son opcionales** y sirven principalmente como marcadores de posición para el contexto. Los usuarios pueden usar exitosamente todos los prompts mediante:
1. Invocar el prompt con `@workspace use [nombre-prompt]`
2. Describir sus necesidades en lenguaje natural
3. Proporcionar cualquier contexto necesario en su mensaje

Los parámetros no necesitan ser suministrados formalmente; GitHub Copilot entenderá la intención de la conversación.

---

**Última Actualización:** 2025-10-18  
**Versión de la Colección:** 2.1  
**Total de Prompts:** 10
