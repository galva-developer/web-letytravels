# Configuración de EmailJS para Envío de Correos

Este proyecto utiliza **EmailJS** para enviar correos electrónicos de confirmación de reservas tanto a los clientes como al negocio.

## 📧 ¿Por qué EmailJS?

EmailJS es un servicio gratuito que permite enviar correos electrónicos directamente desde aplicaciones frontend (como Flutter Web) sin necesidad de un backend. Es perfecto para este proyecto porque:

- ✅ Funciona en Flutter Web
- ✅ No requiere servidor backend
- ✅ Gratis para hasta 200 emails/mes
- ✅ Fácil de configurar

## 🚀 Pasos para Configurar EmailJS

### 1. Crear una Cuenta en EmailJS

1. Ve a [https://www.emailjs.com/](https://www.emailjs.com/)
2. Haz clic en **"Sign Up"** (Registrarse)
3. Crea tu cuenta gratis

### 2. Conectar tu Servicio de Email

1. Una vez dentro, ve a **"Email Services"**
2. Haz clic en **"Add New Service"**
3. Selecciona tu proveedor de email:
   - **Gmail** (recomendado para byletytravels.oficial@gmail.com)
   - Outlook, Yahoo, etc.
4. Sigue las instrucciones para conectar tu cuenta
5. Copia el **Service ID** que se genera

### 3. Crear Templates de Email

#### Template 1: Email para el Cliente

1. Ve a **"Email Templates"**
2. Haz clic en **"Create New Template"**
3. Configura el template con estos campos:

**Asunto (Subject):**
```
Confirmación de Reserva - {{booking_number}} - By Lety Travels
```

**Contenido (Content):**
```html
Hola {{to_name}},

¡Gracias por reservar con By Lety Travels! 

Tu reserva ha sido confirmada exitosamente.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 DETALLES DE LA RESERVA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Número de Reserva: {{booking_number}}
Paquete: {{package_name}}
Destino: {{package_location}}
Duración: {{package_duration}}
Fecha de Salida: {{departure_date}}
Número de Viajeros: {{travelers}}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💰 RESUMEN DE PAGO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total: {{total_amount}}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📞 Información de Contacto:
Email: {{customer_email}}
Teléfono: {{customer_phone}}

Pronto nos pondremos en contacto contigo para coordinar los detalles finales de tu viaje.

¡Gracias por confiar en nosotros para tu próxima aventura!

Saludos,
By Lety Travels
byletytravels.oficial@gmail.com
www.byletytravels.com

✈ Tu aventura comienza aquí
```

4. Guarda el template y copia el **Template ID**

#### Template 2: Email para el Negocio (byletytravels.oficial@gmail.com)

1. Crea otro template nuevo
2. Configura:

**Asunto (Subject):**
```
Nueva Reserva Recibida - {{booking_number}}
```

**Contenido (Content):**
```html
🎉 NUEVA RESERVA RECIBIDA

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 INFORMACIÓN DE LA RESERVA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Número de Reserva: {{booking_number}}
Fecha de Reserva: (Ahora)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
👤 DATOS DEL CLIENTE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Nombre: {{customer_name}}
Email: {{customer_email}}
Teléfono: {{customer_phone}}
País: {{customer_country}}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✈ DETALLES DEL VIAJE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Paquete: {{package_name}}
Destino: {{package_location}}
Duración: {{package_duration}}
Fecha de Salida: {{departure_date}}
Tipo de Habitación: {{room_type}}

Viajeros:
- Adultos: {{adults}}
- Niños: {{children}}
- Infantes: {{infants}}
- Total: {{total_travelers}}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💰 RESUMEN FINANCIERO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Precio Base: {{base_price}}
Descuento: {{discount}}
TOTAL: {{total_amount}}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 SOLICITUDES ESPECIALES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

{{special_requests}}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠ Acción Requerida: Contactar al cliente para confirmar detalles finales.

---
Sistema de Reservas - By Lety Travels
```

3. Guarda y copia el **Template ID**

### 4. Obtener tu Public Key

1. Ve a **"Account"** → **"General"**
2. Copia tu **Public Key** (también llamado User ID)

### 5. Configurar las Credenciales de Forma Segura

🔒 **IMPORTANTE: Tus credenciales NO se subirán al repositorio**

1. Abre el archivo `lib/config/email_config.dart`
2. Reemplaza los valores de ejemplo con tus credenciales reales:

```dart
class EmailConfig {
  static const String serviceId = 'service_abc1234';  // Tu Service ID real
  static const String templateIdClient = 'template_xyz5678';  // Tu Template ID del cliente
  static const String templateIdBusiness = 'template_def9012';  // Tu Template ID del negocio
  static const String publicKey = 'user_klm3456';  // Tu Public Key real
}
```

3. Guarda el archivo

✅ **Este archivo está protegido en `.gitignore` y NO se subirá a GitHub**

**Nota:** Si el archivo `email_config.dart` no existe, cópialo desde `email_config.dart.example`:
```bash
cp lib/config/email_config.dart.example lib/config/email_config.dart
```

Con tus valores reales de EmailJS.

## 📝 Ejemplo de Configuración

Abre `lib/config/email_config.dart` y configura así:

```dart
class EmailConfig {
  // Reemplaza estos valores con los tuyos de EmailJS
  static const String serviceId = 'service_abc1234';
  static const String templateIdClient = 'template_xyz5678';
  static const String templateIdBusiness = 'template_def9012';
  static const String publicKey = 'user_klm3456';
}
```

🔒 **Recordatorio:** Este archivo NO se subirá a Git (está en .gitignore)

## ✅ Verificación

Para probar que todo funciona:

1. Ejecuta `flutter pub get` para instalar las dependencias
2. Ejecuta la aplicación: `flutter run -d chrome`
3. Completa una reserva de prueba
4. Verifica que lleguen los emails:
   - Al email del cliente que ingresaste
   - A byletytravels.oficial@gmail.com

## 🆓 Plan Gratuito de EmailJS

El plan gratuito incluye:
- ✅ 200 emails por mes
- ✅ Templates ilimitados
- ✅ Servicios de email ilimitados
- ✅ Soporte por email

Si necesitas más emails, puedes actualizar a un plan pago más adelante.

## 🔧 Troubleshooting

### Los emails no llegan

1. Verifica que los IDs en `email_service.dart` sean correctos
2. Revisa la consola del navegador para ver errores
3. Verifica que tu cuenta de EmailJS esté activa
4. Revisa la carpeta de spam del destinatario

### Error 403 Forbidden

- Verifica que tu Public Key sea correcta
- Asegúrate de que el servicio de email esté conectado correctamente

### Error 400 Bad Request

- Verifica que los Template IDs sean correctos
- Asegúrate de que todos los parámetros del template estén configurados

## 📚 Recursos Adicionales

- [Documentación de EmailJS](https://www.emailjs.com/docs/)
- [Dashboard de EmailJS](https://dashboard.emailjs.com/)
- [Ejemplos de Templates](https://www.emailjs.com/docs/examples/)

---

¿Necesitas ayuda? Contacta al desarrollador del proyecto.

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
