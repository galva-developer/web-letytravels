# 🔒 Configuración Segura - Credenciales de EmailJS

## ⚠️ IMPORTANTE - Seguridad de Credenciales

Las credenciales de EmailJS están protegidas y **NO se suben al repositorio de GitHub**.

## 📁 Archivos de Configuración

### ✅ Archivos que SÍ se suben al repositorio:
- `lib/config/email_config.dart.example` - Plantilla de ejemplo
- `README_EMAIL_SETUP.md` - Instrucciones de configuración

### 🔒 Archivos que NO se suben (protegidos en .gitignore):
- `lib/config/email_config.dart` - **TUS CREDENCIALES REALES**

## 🚀 Primera Configuración

Si es la primera vez que clonas el repositorio:

1. Copia el archivo de ejemplo:
   ```bash
   cp lib/config/email_config.dart.example lib/config/email_config.dart
   ```

2. Edita `lib/config/email_config.dart` con tus credenciales reales

3. Verifica que `.gitignore` contenga:
   ```
   # EmailJS credentials - NEVER commit this file
   lib/config/email_config.dart
   ```

## ✅ Verificar Protección

Antes de hacer commit, verifica que tus credenciales NO se suban:

```bash
# Ver qué archivos se van a subir
git status

# Verificar que email_config.dart NO aparezca en la lista
# Si aparece, DETENTE y verifica el .gitignore
```

## 📝 Obtener Credenciales

Lee el archivo `README_EMAIL_SETUP.md` para instrucciones completas sobre:
- Crear cuenta en EmailJS
- Obtener Service ID
- Crear templates
- Obtener Public Key

## 🔐 Buenas Prácticas

1. ✅ **NUNCA** subas `email_config.dart` al repositorio
2. ✅ **NUNCA** compartas tus credenciales en screenshots o logs
3. ✅ **NUNCA** hagas hard-code de credenciales en otros archivos
4. ✅ Si accidentalmente subes credenciales, regenera inmediatamente en EmailJS
5. ✅ Mantén tus credenciales solo en `email_config.dart`

## 🆘 ¿Subiste credenciales por error?

Si accidentalmente subiste tus credenciales:

1. Ve a https://dashboard.emailjs.com/
2. Genera nuevas credenciales (Service ID, Templates, Public Key)
3. Actualiza `email_config.dart` con las nuevas
4. Las credenciales antiguas quedarán inválidas

## 📧 Contacto

Para más información, lee `README_EMAIL_SETUP.md` o contacta al equipo de desarrollo.
