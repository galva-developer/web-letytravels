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

### 5. Actualizar el Código

Abre el archivo `lib/data/services/email_service.dart` y reemplaza:

```dart
static const String _serviceId = 'YOUR_SERVICE_ID';
static const String _templateIdClient = 'YOUR_TEMPLATE_ID_CLIENT';
static const String _templateIdBusiness = 'YOUR_TEMPLATE_ID_BUSINESS';
static const String _publicKey = 'YOUR_PUBLIC_KEY';
```

Con tus valores reales de EmailJS.

## 📝 Ejemplo de Configuración

```dart
static const String _serviceId = 'service_abc1234';
static const String _templateIdClient = 'template_xyz5678';
static const String _templateIdBusiness = 'template_def9012';
static const String _publicKey = 'user_klm3456';
```

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
