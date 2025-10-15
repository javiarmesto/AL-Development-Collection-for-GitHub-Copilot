# 🚀 Colección AL Development - Guía de Instalación

**Para Desarrolladores y Arquitectos de AL y Business Central**

> Guía completa para instalar y configurar la Colección AL Development en tu workspace de VS Code.

## 📋 Requisitos Previos

Antes de empezar, asegúrate de tener:

- ✅ **Visual Studio Code** instalado (versión 1.80 o superior)
- ✅ **Extensión AL Language** instalada en VS Code
- ✅ **GitHub Copilot** activo (suscripción válida requerida)
- ✅ **Node.js** 14+ (opcional, solo para validación)
- ✅ Un **proyecto AL** (existente o nuevo)

## 🎯 Opciones de Instalación

Elige el método que mejor se adapte a tus necesidades:

- **Opción 1**: [Instalación Automática](#opción-1-instalación-automática-recomendada) ⭐ Recomendada
- **Opción 2**: [Instalación Manual](#opción-2-instalación-manual)
- **Opción 3**: [Solo un Proyecto](#opción-3-solo-un-proyecto)

---

## 🎯 Opción 1: Instalación Automática (Recomendada)

### Paso 1: Obtener la Colección

**Desde GitHub:**
```bash
# Navega a tu carpeta de proyectos
cd ~/Proyectos

# Clona el repositorio
git clone https://github.com/microsoft/copilot-instructions.git
cd copilot-instructions/collections/al-development
```

**O descarga como ZIP:**
1. Ve a https://github.com/microsoft/copilot-instructions
2. Navega a `collections/al-development`
3. Descarga como ZIP
4. Extrae en tu carpeta de proyectos

### Paso 2: Ejecutar el Instalador

```bash
# Haz el instalador ejecutable
chmod +x install.sh

# Ejecuta el instalador apuntando a tu proyecto AL
./install.sh /ruta/a/tu/proyecto/AL
```

**Ejemplo real:**
```bash
# Si tu proyecto está en ~/Proyectos/MiExtensionBC
./install.sh ~/Proyectos/MiExtensionBC
```

**Lo que hace el instalador:**
- ✅ Crea la estructura de directorios necesaria
- ✅ Copia todos los archivos de instrucciones (7 archivos)
- ✅ Copia todos los archivos de prompts (10 archivos)
- ✅ Copia todos los archivos de chat modes (6 archivos)
- ✅ Copia el manifiesto de colección y documentación
- ✅ Maneja archivos existentes de forma inteligente

### Paso 3: Recargar VS Code

1. Abre tu proyecto AL en VS Code
2. Presiona `Ctrl+Shift+P` (Windows/Linux) o `Cmd+Shift+P` (Mac)
3. Escribe: `Developer: Reload Window`
4. Presiona Enter

### Paso 4: Verificar Instalación

**Prueba Rápida:**
1. Abre cualquier archivo `.al`
2. Empieza a escribir código - nota que Copilot sigue los estándares AL
3. Prueba un prompt:
   ```
   @workspace use al-workspace
   ```
4. Deberías ver la guía de configuración de workspace

**Prueba Detallada:**
```bash
# Si tienes Node.js instalado
cd tu-proyecto-al
npm install
npm run validate
```

Salida esperada:
```
✅ Collection is fully compliant and ready for contribution!
```

---

## 🎯 Opción 2: Instalación Manual

### Paso 1: Crear Estructura de Carpetas

En la raíz de tu proyecto AL, crea estas carpetas:

```bash
mkdir -p .github/instructions
mkdir -p .github/copilot-prompts
mkdir -p chatmodes
mkdir -p collections
```

### Paso 2: Copiar Archivos de Instrucciones

Copia todos los archivos desde la colección descargada:

**En Linux/Mac:**
```bash
# Desde la carpeta de la colección descargada
cp -r .github/instructions/*.instructions.md TU_PROYECTO/.github/instructions/
cp -r .github/copilot-prompts/*.prompt.md TU_PROYECTO/.github/copilot-prompts/
cp -r chatmodes/*.chatmode.md TU_PROYECTO/chatmodes/
cp collections/al-development.collection.yml TU_PROYECTO/collections/
cp copilot-instructions.md TU_PROYECTO/
```

**En Windows (PowerShell):**
```powershell
# Desde la carpeta de la colección descargada
Copy-Item .github\instructions\*.instructions.md TU_PROYECTO\.github\instructions\
Copy-Item .github\copilot-prompts\*.prompt.md TU_PROYECTO\.github\copilot-prompts\
Copy-Item chatmodes\*.chatmode.md TU_PROYECTO\chatmodes\
Copy-Item collections\al-development.collection.yml TU_PROYECTO\collections\
Copy-Item copilot-instructions.md TU_PROYECTO\
```

### Paso 3: Verificar Estructura

Tu proyecto debería verse así:

```
TuProyectoAL/
├── .github/
│   ├── instructions/              ← 7 archivos .instructions.md
│   └── copilot-prompts/          ← 10 archivos .prompt.md
├── chatmodes/                    ← 6 archivos .chatmode.md
├── collections/
│   └── al-development.collection.yml
├── src/                          ← Tu código AL existente
├── app.json                      ← Tu archivo de proyecto
├── launch.json
└── copilot-instructions.md       ← Guía de integración
```

### Paso 4: Recargar VS Code

Presiona `Ctrl+Shift+P` → `Developer: Reload Window`

---

## 🎯 Opción 3: Solo un Proyecto

Usa esto si quieres probar la colección en UN proyecto sin instalación completa:

### Usando Configuración de Workspace

1. **Abre tu proyecto AL en VS Code**

2. **Crea/Edita `.vscode/settings.json`** en la raíz de tu proyecto:

```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    {
      "file": "https://raw.githubusercontent.com/microsoft/copilot-instructions/main/collections/al-development/.github/instructions/al-guidelines.instructions.md"
    },
    {
      "file": "https://raw.githubusercontent.com/microsoft/copilot-instructions/main/collections/al-development/.github/instructions/al-code-style.instructions.md"
    },
    {
      "file": "https://raw.githubusercontent.com/microsoft/copilot-instructions/main/collections/al-development/.github/instructions/al-naming-conventions.instructions.md"
    },
    {
      "file": "https://raw.githubusercontent.com/microsoft/copilot-instructions/main/collections/al-development/.github/instructions/al-performance.instructions.md"
    }
  ]
}
```

3. **Recarga VS Code**

> ⚠️ **Nota**: Este método es limitado y no incluye prompts ni chat modes. Para funcionalidad completa, usa Opción 1 o 2.

---

## ✅ Verificación Post-Instalación

### Prueba 1: Instrucciones Auto-Aplicadas

1. Abre cualquier archivo `.al`
2. Empieza a escribir código:
```al
procedure CalcularTotal
```
3. Copilot debería sugerir código con:
   - Nombres en PascalCase
   - Indentación de 2 espacios
   - Documentación XML para procedimientos públicos

### Prueba 2: Probar un Prompt

1. Abre el Chat de Copilot (`Ctrl+I` o `Cmd+I`)
2. Escribe:
```
@workspace use al-workspace
```
3. Deberías ver una respuesta guiada sobre configuración de workspace

### Prueba 3: Probar un Chat Mode

1. En el Chat de Copilot, escribe:
```
Use al-orchestrator mode
```
2. Luego pregunta:
```
Necesito construir un flujo de aprobación de ventas. ¿Por dónde empiezo?
```
3. Deberías recibir análisis estratégico y recomendaciones

### Prueba 4: Validación Completa (Opcional)

Si instalaste Node.js:

```bash
cd tu-proyecto-al
npm install
npm run validate
```

Salida esperada:
```
✅ Collection is fully compliant and ready for contribution!
```

---

## 🎓 Primeros Pasos Después de Instalar

### Para Desarrolladores Nuevos en AL

**1. Lee la documentación de usuario:**
```bash
# Abre en navegador o VS Code
code al-development.md
```

**2. Comienza con el Orchestrator:**
```
Chat de Copilot: "Use al-orchestrator mode"
Luego: "Soy nuevo en AL, ¿cómo debería empezar?"
```

**3. Usa el prompt de workspace:**
```
@workspace use al-workspace
Responde las preguntas para configurar tu primer proyecto
```

### Para Desarrolladores Experimentados en AL

**1. Revisa las instrucciones activas:**
```bash
# Lee los archivos en .github/instructions/
# Estos se aplican automáticamente mientras codeas
code .github/instructions/al-code-style.instructions.md
```

**2. Explora los prompts disponibles:**
```bash
# Ver todos los prompts
ls .github/copilot-prompts/

# Prueba uno relevante a tu tarea actual
@workspace use al-build    # Para deployment
@workspace use al-debug    # Para debugging
@workspace use al-api      # Para APIs
```

**3. Usa los modos especializados:**
```
al-architect   → Para diseño de soluciones
al-debugger    → Para troubleshooting
al-api         → Para desarrollo de APIs
al-copilot     → Para características de IA
```

### Para Arquitectos

**1. Comienza con el modo arquitecto:**
```
Chat: "Use al-architect mode"
Luego: "Necesito diseñar un flujo de aprobación multi-compañía"
```

**2. Combina con prompts según necesites:**
```
@workspace use al-events      # Para diseño de eventos
@workspace use al-performance # Para consideraciones de rendimiento
```

---

## 🔧 Configuración Avanzada

### Personalizar para Tu Equipo

Si quieres adaptar la colección a tu equipo:

**1. Haz un fork del repositorio**

**2. Modifica las instrucciones según tus estándares:**
```bash
# Edita .github/instructions/al-code-style.instructions.md
# Añade reglas específicas de tu equipo
```

**3. Comparte el fork con tu equipo:**
```bash
git clone https://tu-org/al-development-collection.git
```

### Workspace Multi-Proyecto

Si trabajas con múltiples proyectos AL:

**Opción A: Instalar en cada proyecto**
```bash
for proyecto in Proyecto1 Proyecto2 Proyecto3; do
    ./install.sh ~/Proyectos/$proyecto
done
```

**Opción B: Usar configuración global de VS Code**

Edita `~/.config/Code/User/settings.json` (Linux/Mac) o `%APPDATA%/Code/User/settings.json` (Windows):

```json
{
  "github.copilot.chat.codeGeneration.useInstructionFiles": true
}
```

---

## 🆘 Solución de Problemas

### Problema: Copilot no muestra sugerencias basadas en instrucciones

**Solución:**
1. Verifica que los archivos estén en ubicaciones correctas
2. Recarga VS Code (`Ctrl+Shift+P` > `Reload Window`)
3. Comprueba que Copilot esté activo (icono en barra inferior)
4. Confirma que estás trabajando con archivos `.al`

### Problema: Los prompts no funcionan (@workspace use...)

**Solución:**
1. Verifica que los archivos tengan extensión `.prompt.md`
2. Comprueba que estén en `.github/copilot-prompts/`
3. Recarga VS Code
4. Asegura sintaxis correcta: `@workspace use al-[nombre]`

### Problema: Los chat modes no responden

**Solución:**
1. Verifica que los archivos tengan extensión `.chatmode.md`
2. Comprueba que estén en carpeta `chatmodes/`
3. Usa nombre exacto: `Use al-architect mode` (no `al-architect-mode`)
4. Recarga VS Code

### Problema: Las instrucciones no parecen aplicarse

**Solución:**
1. Verifica que `alwaysApply: true` esté en frontmatter
2. Comprueba `globs` en frontmatter (debe incluir `"*.al"`)
3. Recarga VS Code completamente
4. Cierra y abre el archivo `.al`

### Problema: Error "File not found" en validación

**Solución:**
```bash
# Verifica que todos los archivos estén presentes
ls -la .github/instructions/
ls -la .github/copilot-prompts/
ls -la chatmodes/

# Si faltan archivos, reinstala
./install.sh .
```

---

## 📚 Recursos Adicionales

### Documentación Incluida

- **al-development.md** - Guía completa de usuario
- **copilot-instructions.md** - Integración con Copilot
- **COLLECTION-SUMMARY.md** - Referencia técnica completa
- **CONTRIBUTING.md** - Si quieres contribuir mejoras

### Documentación Externa

- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [AL Language Docs](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/developer/)
- [Business Central Development](https://learn.microsoft.com/es-es/dynamics365/business-central/dev-itpro/)

### Soporte

- **Issues**: Reporta problemas en GitHub
- **Discussions**: Pregunta a la comunidad
- **Updates**: Suscríbete al repositorio para actualizaciones

---

## 🎉 ¡Listo para Empezar!

Ahora tienes todo configurado. Algunos primeros pasos sugeridos:

### Primer Ejercicio: Crear una Tabla Simple

```al
// Empieza a escribir y deja que Copilot te guíe
table 50100 "Mi Primera Tabla"
{
    // Copilot sugerirá la estructura correcta
    // con DataClassification, campos apropiados, etc.
}
```

### Primer Flujo Completo

```
1. Chat: "Use al-orchestrator mode"
2. Pregunta: "Quiero añadir un nuevo campo a la tabla Customer"
3. Sigue las recomendaciones
4. Usa los prompts sugeridos para implementar
```

### Explorar Todas las Herramientas

```bash
# Lista todos los prompts disponibles
ls .github/copilot-prompts/

# Lista todos los modos
ls chatmodes/

# Lee la documentación de cada uno según necesites
```

---

**¿Necesitas ayuda?** Usa **al-orchestrator** - está diseñado para guiarte cuando no estás seguro:

```
Chat: "Use al-orchestrator mode"
Luego: "No estoy seguro qué herramienta usar para [tu tarea]"
```

**¡Feliz Desarrollo en AL!** 🚀

---

**Instalado**: 2025-10-15 08:35:16 UTC  
**Usuario**: javiarmesto  
**Versión de la Colección**: 2.0