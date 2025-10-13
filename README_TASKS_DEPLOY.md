# 🚀 Guía de Despliegue - ByLetyTravels en Firebase Hosting

## 📋 Índice
1. [Prerrequisitos](#-prerrequisitos)
2. [Configuración Inicial](#-configuración-inicial)
3. [Preparación del Proyecto Flutter](#-preparación-del-proyecto-flutter)
4. [Configuración de Firebase](#-configuración-de-firebase)
5. [Build de Producción](#-build-de-producción)
6. [Despliegue en Firebase Hosting](#-despliegue-en-firebase-hosting)
7. [Configuración del Dominio Personalizado](#-configuración-del-dominio-personalizado)
8. [Verificación y Testing](#-verificación-y-testing)
9. [Mantenimiento y Actualizaciones](#-mantenimiento-y-actualizaciones)
10. [Troubleshooting](#-troubleshooting)

---

## ✅ Prerrequisitos

Antes de comenzar, asegúrate de tener instalado:

- [x] **Node.js** (versión 16 o superior)
  ```bash
  node --version
  ```
  Descarga: https://nodejs.org/

- [x] **Flutter SDK** (versión 3.7.2 o superior)
  ```bash
  flutter --version
  ```

- [x] **Git** instalado y configurado
  ```bash
  git --version
  ```

- [x] **Cuenta de Google** para acceder a Firebase Console

- [x] **Navegador web** moderno (Chrome recomendado)

---

## 🔧 Configuración Inicial

### Paso 1: Instalar Firebase CLI

Abre tu terminal y ejecuta:

```bash
npm install -g firebase-tools
```

Verifica la instalación:
```bash
firebase --version
```

### Paso 2: Iniciar Sesión en Firebase

```bash
firebase login
```

Esto abrirá tu navegador para que inicies sesión con tu cuenta de Google.

Para verificar que estás autenticado:
```bash
firebase projects:list
```

---

## 🎯 Preparación del Proyecto Flutter

### Paso 3: Verificar Configuración del Proyecto

Navega a la raíz de tu proyecto:
```bash
cd c:\Users\galva\Documents\Github\Projects\Letytravels\web-letytravels
```

### Paso 4: Actualizar Dependencias

```bash
flutter pub get
```

### Paso 5: Verificar que el Proyecto Compila

Ejecuta un build de prueba:
```bash
flutter build web --release
```

Si hay errores, resuélvelos antes de continuar.

### Paso 6: Configurar Base URL (Opcional)

Si vas a usar un dominio personalizado, actualiza el `index.html`:

Edita `web/index.html` y asegúrate de que tenga:
```html
<base href="/">
```

---

## 🔥 Configuración de Firebase

### Paso 7: Crear Proyecto en Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Haz clic en **"Agregar proyecto"** o **"Create a project"**
3. Nombre del proyecto: `web-letytravels` (o el que prefieras)
4. Habilita Google Analytics (opcional pero recomendado)
5. Selecciona la cuenta de Analytics
6. Haz clic en **"Crear proyecto"**
7. Espera a que se complete la configuración

### Paso 8: Inicializar Firebase en tu Proyecto Local

En la raíz de tu proyecto Flutter, ejecuta:

```bash
firebase init
```

Selecciona las siguientes opciones:

1. **¿Qué características de Firebase quieres configurar?**
   - [x] Hosting: Configure files for Firebase Hosting
   - Usa las flechas para navegar y ESPACIO para seleccionar

2. **Selecciona un proyecto existente o crea uno nuevo**
   - Selecciona el proyecto que creaste (`bylety-travels`)

3. **¿Cuál es tu directorio público?**
   ```
   build/web
   ```
   (Este es donde Flutter genera el build)

4. **¿Configurar como aplicación de una sola página?**
   ```
   Yes
   ```

5. **¿Configurar builds y deploys automáticos con GitHub?**
   ```
   No (por ahora)
   ```

6. **¿Sobrescribir build/web/index.html?**
   ```
   No
   ```

### Paso 9: Verificar Archivos Creados

Firebase habrá creado:
- `.firebaserc` - Configuración del proyecto
- `firebase.json` - Configuración de hosting

Verifica que `firebase.json` contenga algo similar a:
```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

---

## 🏗️ Build de Producción

### Paso 10: Limpiar Builds Anteriores

```bash
flutter clean
```

### Paso 11: Generar Build Optimizado

```bash
flutter build web --release
```

**Nota**: La opción `--web-renderer` fue eliminada en versiones recientes de Flutter (3.x+).
Flutter ahora automáticamente:
- Usa **CanvasKit** por defecto (mejor rendimiento y fidelidad visual)
- Hace fallback a **HTML renderer** cuando es necesario
- Optimiza según el navegador del usuario

### Paso 12: Verificar el Build

El build se generará en `build/web/`. Verifica que contenga:
- `index.html`
- Carpeta `assets/`
- Archivos JavaScript y CSS
- `favicon.png`

---

## 🌐 Despliegue en Firebase Hosting

### Paso 13: Deploy a Firebase

```bash
firebase deploy --only hosting
```

Verás un output similar a:
```
✔ Deploy complete!

Project Console: https://console.firebase.google.com/project/bylety-travels/overview
Hosting URL: https://bylety-travels.web.app
```

### Paso 14: Verificar el Despliegue

Abre la URL proporcionada en tu navegador:
```
https://bylety-travels.web.app
```

También tendrás una URL alternativa:
```
https://bylety-travels.firebaseapp.com
```

---

## 🌍 Configuración del Dominio Personalizado

### Paso 15: Conectar Dominio Propio (Opcional)

Si tienes un dominio como `byletytravels.com`:

1. Ve a Firebase Console → Hosting
2. Haz clic en **"Agregar dominio personalizado"**
3. Ingresa tu dominio: `byletytravels.com`
4. Firebase te dará registros DNS para configurar

### Paso 16: Configurar DNS

En tu proveedor de dominio (GoDaddy, Namecheap, etc.):

**Para dominio raíz (byletytravels.com):**
```
Tipo: A
Nombre: @
Valor: [IPs proporcionadas por Firebase]
```

**Para www (www.byletytravels.com):**
```
Tipo: CNAME
Nombre: www
Valor: bylety-travels.web.app
```

### Paso 17: Verificar Dominio

Firebase verificará automáticamente la configuración DNS. Esto puede tardar hasta 24 horas.

---

## ✅ Verificación y Testing

### Paso 18: Checklist de Verificación

- [x] La página carga correctamente
- [x] Todas las imágenes se muestran
- [x] Los assets (fuentes, iconos) cargan bien
- [x] La navegación funciona (scroll entre secciones)
- [x] Los botones de WhatsApp/Email funcionan
- [x] El diseño responsive se ve bien en móvil
- [x] No hay errores en la consola del navegador

### Paso 19: Testing en Diferentes Dispositivos

Prueba tu sitio en:
- **Desktop**: Chrome, Firefox, Safari, Edge
- **Móvil**: Android Chrome, iOS Safari
- **Tablet**: iPad, Android Tablets

Usa las DevTools de Chrome para simular dispositivos:
```
F12 → Toggle Device Toolbar
```

---

## 🔄 Mantenimiento y Actualizaciones

### Paso 20: Workflow de Actualización

Cuando hagas cambios en el proyecto:

1. **Desarrollar y probar localmente**
   ```bash
   flutter run -d chrome
   ```

2. **Generar nuevo build**
   ```bash
   flutter build web --release
   ```

3. **Desplegar actualización**
   ```bash
   firebase deploy --only hosting
   ```

### Paso 21: Ver Historial de Deploys

```bash
firebase hosting:releases:list
```

### Paso 22: Rollback a Versión Anterior (si es necesario)

En Firebase Console:
1. Ve a Hosting → Release history
2. Selecciona una versión anterior
3. Haz clic en "Rollback"

---

## 🎨 Optimizaciones Recomendadas

### Paso 23: Configurar Caché

Edita `firebase.json` para mejorar el rendimiento:

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**/*.@(jpg|jpeg|gif|png|svg|webp|ico)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      },
      {
        "source": "**/*.@(js|css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      }
    ]
  }
}
```

### Paso 24: Habilitar Compresión

Asegúrate de que `firebase.json` incluya:

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "cleanUrls": true,
    "trailingSlash": false
  }
}
```

---

## 🔍 Monitoreo y Analytics

### Paso 25: Configurar Google Analytics (Opcional)

1. Ve a Firebase Console → Analytics
2. Habilita Google Analytics para tu proyecto
3. Agrega el código de tracking a tu `web/index.html`

### Paso 26: Monitorear Performance

En Firebase Console:
- **Hosting → Usage**: Tráfico y ancho de banda
- **Analytics → Dashboard**: Usuarios y comportamiento

---

## 🛠️ Troubleshooting

### Problema 1: "Firebase command not found"
**Solución:**
```bash
npm install -g firebase-tools
```

### Problema 2: Build falla con errores
**Solución:**
```bash
flutter clean
flutter pub get
flutter build web --release
```

### Problema 3: Imágenes no cargan después del deploy
**Solución:**
- Verifica que las rutas en `pubspec.yaml` sean correctas
- Asegúrate de que `assets/images/` esté incluido
- Revisa que las rutas en el código no tengan `/` inicial

### Problema 4: Fuentes personalizadas no se muestran
**Solución:**
- Verifica `pubspec.yaml` → sección `fonts`
- Asegúrate de que `assets/fonts/` esté incluido
- Regenera el build: `flutter build web --release`

### Problema 5: "Permission denied" al hacer deploy
**Solución:**
```bash
firebase login --reauth
firebase deploy --only hosting
```

### Problema 6: Página en blanco después del deploy
**Solución:**
- Verifica que `base href` en `web/index.html` sea `"/"`
- Comprueba errores en la consola del navegador (F12)
- Revisa la configuración de rewrites en `firebase.json`

### Problema 7: Deploy lento o falla
**Solución:**
```bash
# Limpia y reconstruye
flutter clean
flutter build web --release

# Deploy con más info
firebase deploy --only hosting --debug
```

---

## 📊 Comandos Útiles

### Comandos de Firebase

```bash
# Ver proyectos
firebase projects:list

# Cambiar de proyecto
firebase use bylety-travels

# Ver configuración actual
firebase list

# Preview local antes de deploy
firebase serve --only hosting

# Deploy solo hosting
firebase deploy --only hosting

# Ver logs
firebase hosting:logs

# Ver sitios activos
firebase hosting:sites:list
```

### Comandos de Flutter

```bash
# Build para web
flutter build web --release

# Run en Chrome
flutter run -d chrome

# Limpiar proyecto
flutter clean

# Actualizar dependencias
flutter pub upgrade

# Verificar problemas
flutter doctor
```

---

## 📝 Checklist Final de Despliegue

- [x] Firebase CLI instalado y configurado
- [x] Proyecto Firebase creado en console
- [x] Firebase inicializado en proyecto local
- [x] Build de producción generado sin errores
- [x] Deploy exitoso a Firebase Hosting
- [x] URL de producción verificada y funcional
- [x] Todas las secciones de la página cargan correctamente
- [x] Imágenes y assets se muestran
- [x] Navegación funciona correctamente
- [x] Responsive design verificado
- [x] Botones de contacto configurados
- [x] Google Analytics configurado (opcional)
- [x] Dominio personalizado conectado (opcional)
- [x] SSL/HTTPS habilitado (automático en Firebase)
- [x] Performance testeada
- [x] Documentación actualizada

---

## 🎉 ¡Felicidades!

Tu sitio web **ByLetyTravels** está ahora desplegado en Firebase Hosting y disponible para todo el mundo.

### URLs de tu sitio:
- **Firebase Hosting**: https://bylety-travels.web.app
- **Alternativa**: https://bylety-travels.firebaseapp.com
- **Dominio personalizado**: https://tudominio.com (si lo configuraste)

### Próximos pasos:
1. Compartir la URL con tu equipo
2. Agregar WhatsApp Business y email real
3. Configurar Analytics para seguimiento
4. Promocionar en redes sociales
5. Actualizar paquetes de viaje según demanda

---

## 📚 Recursos Adicionales

- [Documentación Flutter Web](https://docs.flutter.dev/deployment/web)
- [Firebase Hosting Docs](https://firebase.google.com/docs/hosting)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)
- [Firebase CLI Reference](https://firebase.google.com/docs/cli)

---

## 🆘 Soporte

Si tienes problemas:
1. Revisa la sección de [Troubleshooting](#-troubleshooting)
2. Consulta los logs: `firebase hosting:logs`
3. Verifica la consola del navegador (F12)
4. Revisa [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
5. Comunidad Flutter: [Discord](https://discord.gg/flutter)

---

<div align="center">

**¡Buen despliegue! 🚀**

© 2025 ByLetyTravels

</div>
