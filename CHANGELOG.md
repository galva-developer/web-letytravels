# 📝 Changelog - ByLetyTravels

Registro de cambios y mejoras implementadas en el proyecto.

---

## [v0.16.0] - 2025-01-12

### ✨ Nueva Funcionalidad

#### 📄 Páginas de Políticas Legales

Sistema completo de políticas y términos legales para cumplir con regulaciones y generar confianza.

- **Privacy Policy Page** (`lib/presentation/pages/privacy_policy_page.dart`) ✅
  - Página completa de Política de Privacidad
  - **Secciones**:
    * Información que recopilamos (personal, viaje, pago, navegación)
    * Cómo usamos tu información
    * Compartir información (solo con proveedores necesarios)
    * Protección de datos (encriptación SSL, almacenamiento seguro)
    * Derechos del usuario (acceso, corrección, eliminación, portabilidad)
    * Política de cookies
    * Protección de menores de edad
    * Cambios en la política
    * Información de contacto
  - **Características**:
    * Diseño limpio y legible
    * Listas con viñetas para fácil escaneo
    * Información de contacto destacada
    * Banner de aceptación al final
    * Fecha de última actualización
    * Layout responsivo con ancho máximo 900px
  - **Cumplimiento**: GDPR, CCPA, leyes de privacidad

- **Terms and Conditions Page** (`lib/presentation/pages/terms_conditions_page.dart`) ✅
  - Página completa de Términos y Condiciones
  - **Secciones (13 puntos)**:
    * 1. Aceptación de términos
    * 2. Descripción del servicio
    * 3. Proceso de reserva
    * 4. Precios y pagos (USD, múltiples métodos, depósito 30%)
    * 5. Cancelaciones y reembolsos (política general)
    * 6. Documentación de viaje (responsabilidades del cliente)
    * 7. Seguros de viaje (recomendaciones)
    * 8. Limitación de responsabilidad
    * 9. Comportamiento del cliente
    * 10. Propiedad intelectual
    * 11. Modificaciones del servicio
    * 12. Resolución de disputas
    * 13. Información de contacto
  - **Características**:
    * Banner de advertencia destacado
    * Formato fácil de leer
    * Listas detalladas por sección
    * Información de contacto legal
  - **Protección Legal**: Términos vinculantes para reservas

- **Cookie Policy Page** (`lib/presentation/pages/cookie_policy_page.dart`) ✅
  - Página explicativa sobre uso de cookies
  - **Secciones**:
    * Qué son las cookies
    * Cómo utilizamos las cookies
    * Tipos de cookies (4 categorías)
    * Cookies de terceros (Google, Facebook, Stripe, etc.)
    * Duración de las cookies
    * Cómo controlar las cookies
    * Consecuencias de deshabilitar cookies
    * Actualizaciones de la política
  - **4 Tipos de Cookies**:
    * Esenciales ✅ (verde) - No pueden desactivarse
    * Rendimiento ⚡ (azul) - Analytics y métricas
    * Funcionalidad ⚙️ (naranja) - Preferencias de usuario
    * Marketing 📢 (morado) - Publicidad y remarketing
  - **Características**:
    * Cards coloridas para cada tipo de cookie
    * Instrucciones por navegador (Chrome, Firefox, Safari, Edge)
    * Ejemplos específicos de cada categoría
    * Banner de aceptación
  - **Cumplimiento**: GDPR, ePrivacy Directive

- **Refund Policy Page** (`lib/presentation/pages/refund_policy_page.dart`) ✅
  - Página completa de Política de Reembolsos
  - **Política de Cancelación por Tiempo**:
    * 30+ días: 100% reembolso ✅ (verde)
    * 15-30 días: 50% reembolso ⚠️ (naranja)
    * <15 días: 0% reembolso ❌ (rojo)
  - **Secciones (11 puntos)**:
    * 1. Política general de cancelación
    * 2. Proceso de cancelación (email, timeframes)
    * 3. Excepciones (emergencias médicas, fallecimientos, desastres)
    * 4. Modificación de reservas (cambios de fecha/destino)
    * 5. Servicios no reembolsables
    * 6. Cancelación por parte de ByLetyTravels
    * 7. No shows (sin reembolso)
    * 8. Retrasos y cancelaciones de vuelos
    * 9. Método de reembolso (mismo método original)
    * 10. Seguros de viaje (recomendaciones)
    * 11. Información de contacto
  - **Características**:
    * Cards visuales por tier de reembolso
    * Consejos para evitar cargos
    * Banner de advertencia importante
    * Proceso claro paso a paso
  - **Transparencia**: Política clara y justa

- **Integración en Footer** ✅
  - Enlaces a las 4 políticas en el footer
  - **Ubicación**: Entre redes sociales y copyright
  - **Layout**: Wrap responsive que se adapta al ancho
  - **Diseño**:
    * Enlaces horizontales con spacing de 24px
    * Hover: Color amarillo + subrayado
    * Animación suave (200ms)
    * Cursor pointer
  - **Enlaces**:
    1. Política de Privacidad
    2. Términos y Condiciones
    3. Política de Cookies
    4. Política de Reembolsos
  - **Navegación**: Click abre página completa con AppBar y back button

### 🔧 Mejoras

- Footer reorganizado con mejor estructura
- Información de contacto más visible
- Enlaces interactivos con hover effects
- Diseño profesional y confiable
- Cumplimiento legal mejorado

### 🎨 UI/UX

- Páginas legibles con tipografía clara
- Secciones numeradas para fácil referencia
- Listas con viñetas para mejor escaneo
- Cards coloridas para categorización
- Banners de información destacados
- Diseño responsive (max-width 900px)
- AppBar con botón de retorno
- Scroll suave en páginas largas

### ⚖️ Cumplimiento Legal

- **GDPR**: Política de privacidad completa
- **CCPA**: Derechos del consumidor claros
- **ePrivacy**: Política de cookies detallada
- **Transparencia**: Términos y condiciones explícitos
- **Confianza**: Políticas de reembolso justas
- **Protección**: Información de contacto legal

### 📚 Documentación

- 4 páginas legales completas
- Contenido profesional y comprensible
- Fácil actualización con fecha automática
- Enlaces accesibles desde cualquier página

---

## [v0.15.0] - 2025-01-12

### ✨ Nueva Funcionalidad

#### 🌐 Enlaces a Redes Sociales

Integración completa de enlaces a redes sociales con diseño atractivo y animaciones.

- **SocialMediaLinks Widget** (`lib/presentation/widgets/social_media_links.dart`) ✅
  - Widget reutilizable para mostrar íconos de redes sociales
  - **Redes Sociales**:
    * Facebook: https://www.facebook.com/profile.php?id=61575652439979
    * Instagram: https://www.instagram.com/byletytravels.ok/
    * TikTok: https://www.tiktok.com/@byletytravels.ok
  - **Características**:
    * Iconos personalizados con colores de marca
    * Instagram: Gradiente característico (rojo-morado-azul)
    * Facebook: Azul oficial (#1877F2)
    * TikTok: Negro con ícono de nota musical
    * Animaciones hover: Escala 1.1x y background con opacidad
    * Tooltips descriptivos
    * Apertura en nueva pestaña/app externa
  - **Variantes**:
    * `SocialMediaLinks`: Base configurable (tamaño, spacing, alineación)
    * `SocialMediaLinksCompact`: Para navbar (24px, sin labels)
    * `SocialMediaLinksExpanded`: Para footer (32px, con título)
  - **Props Configurables**:
    * `iconSize`: Tamaño de los iconos (default: 32)
    * `showLabels`: Mostrar texto junto al ícono (default: false)
    * `alignment`: Alineación horizontal (default: center)
    * `spacing`: Espaciado entre íconos (default: 16)
  - **Tecnología**: `url_launcher` para abrir enlaces externos

- **Integración en AppBar** ✅
  - Íconos compactos en la barra de navegación superior
  - Posición: Lado derecho, antes del botón "Reservar Ahora"
  - Tamaño: 24px para no competir visualmente
  - Spacing: 12px entre íconos, 24px del botón
  - Responsive: Visible en desktop

- **Integración en Footer** ✅
  - Sección dedicada "Síguenos en Redes Sociales"
  - Posición: Encima del copyright en footer oscuro
  - Tamaño: 32px más visible
  - Layout: Centrado horizontalmente
  - Spacing: 20px entre íconos, 24px del copyright
  - Visible en todas las resoluciones

#### 📸 Feed de Instagram Embebido

Galería visual de las últimas publicaciones de Instagram integrada en la página principal.

- **InstagramFeed Widget** (`lib/presentation/widgets/instagram_feed.dart`) ✅
  - Widget para mostrar feed de Instagram con 6 publicaciones
  - **Características**:
    * Grid responsivo de publicaciones
    * Imágenes optimizadas con lazy loading
    * Hover effects con overlay gradient
    * Link directo a perfil de Instagram
    * Indicador de carga mientras se obtienen imágenes
    * Error handling con placeholder
  - **Layout Responsivo**:
    * Desktop (>900px): 6 columnas (todas en una fila)
    * Tablet (600-900px): 3 columnas (2 filas)
    * Móvil (<600px): 2 columnas (3 filas)
  - **Interactividad**:
    * Hover: Overlay oscuro con ícono de Instagram
    * Click: Abre perfil de Instagram en nueva pestaña
    * Animación suave al hacer hover
    * Elevación de card en hover
  - **Sección Completa**:
    * Título: "Síguenos en Instagram"
    * Ícono de Instagram con gradiente
    * Username clickeable: @byletytravels.ok
    * Subtítulo descriptivo
    * Grid de 6 publicaciones
    * Botón "Ver más en Instagram" al final
  - **Props Configurables**:
    * `instagramUsername`: Nombre de usuario (default: 'byletytravels.ok')
    * `instagramUrl`: URL del perfil (default: Instagram oficial)
    * `numberOfPosts`: Cantidad de publicaciones a mostrar (default: 6)
  - **Variantes**:
    * `InstagramFeed`: Versión completa (6 posts)
    * `InstagramFeedCompact`: Versión compacta (4 posts)
  - **Nota de Implementación**:
    * Actualmente usa imágenes placeholder de Unsplash
    * En producción: Integrar con Instagram Basic Display API
    * Imágenes temáticas de viajes: París, Maldivas, Santorini, etc.

- **Integración en HomePage** ✅
  - Posicionada entre BookingSection y ContactFooterSection
  - Separador visual natural entre contenido y footer
  - Anima a seguir en redes sociales antes del contacto
  - Background blanco para contraste con footer oscuro

### 🔧 Mejoras

- Animaciones suaves en hover (200ms)
- Feedback visual claro al interactuar
- Apertura de enlaces en modo externo (nueva pestaña/app)
- Tooltips informativos en todos los íconos
- Diseño consistente con la identidad de marca
- Grid responsivo que se adapta a cualquier pantalla
- Loading states durante carga de imágenes
- Error handling con placeholders elegantes

### 🎨 UI/UX

- Iconos con colores oficiales de cada plataforma
- Efectos hover: Escala + background color
- Bordes redondeados en variante con labels
- Estados hover diferenciados por red social
- Integración armoniosa en navbar y footer
- Overlay gradient en hover de publicaciones
- Transiciones suaves entre estados
- Cards elevadas en interacción

### 📚 Documentación

- Documentado widget SocialMediaLinks
- URLs oficiales de redes sociales
- Guía de uso de variantes
- Documentado InstagramFeed con props configurables
- Nota sobre integración futura con API de Instagram
- Ejemplos de uso compacto y expandido

---

## [v0.14.0] - 2025-01-12

### ✨ Nueva Funcionalidad

#### 📅 Sistema de Citas para Asesoría Personalizada

Implementación completa del sistema de reserva de citas con calendario interactivo y múltiples modalidades de atención.

- **Modelo Appointment** (`lib/data/models/appointment.dart`) ✅
  - Modelo para gestión de citas de asesoría
  - **Campos**:
    * `id` (String) - Identificador único (UUID)
    * `date` (DateTime) - Fecha de la cita
    * `timeSlot` (String) - Hora en formato "09:00 AM"
    * `type` (AppointmentType) - Tipo de cita
    * `clientName` (String) - Nombre del cliente
    * `clientEmail` (String) - Email del cliente
    * `clientPhone` (String?) - Teléfono opcional
    * `notes` (String?) - Notas adicionales
    * `status` (AppointmentStatus) - Estado de la cita
    * `createdAt` (DateTime) - Fecha de creación
  - **Enum AppointmentType**: 3 modalidades
    * `inPerson` - Cita presencial en oficina
    * `video` - Videollamada (Google Meet/Zoom)
    * `phone` - Llamada telefónica
  - **Enum AppointmentStatus**: 5 estados
    * `pending` - Pendiente de confirmación
    * `confirmed` - Confirmada por el equipo
    * `completed` - Cita completada
    * `canceled` - Cancelada
    * `noShow` - Cliente no se presentó
  - **Métodos de Validación**:
    * `isValid()` - Verifica campos requeridos y email
    * `isFuture()` - Valida que la cita sea futura
    * `canBeCanceled()` - Permite cancelar con 24h de anticipación
    * `getInvalidReason()` - Retorna razón de invalidez
  - **Getters**: `formattedDate`, `formattedTime`, `formattedDateTime`
  - **Extensiones**: `displayName`, `icon`, `description` para tipos y estados
  - Conversión: `toMap()`, `fromMap()`, `copyWith()`

- **Modelo TimeSlot** (`lib/data/models/time_slot.dart`) ✅
  - Modelo para slots de tiempo de 30 minutos
  - **Campos**:
    * `time` (String) - Hora en formato "09:00 AM"
    * `isAvailable` (bool) - Disponibilidad del slot
    * `hour` (int) - Hora en formato 24h
    * `minute` (int) - Minutos
  - **Factory**: `fromTime(hour, minute)` - Crea slot con formato
  - **Métodos**: `isPast(date)`, `copyWith(isAvailable)`
  - **TimeSlotGenerator** (clase estática):
    * `generateDailySlots(date, bookedSlots)` - Genera slots del día
    * **Horarios de Negocio**:
      - Lunes a Viernes: 9:00 AM - 7:00 PM (20 slots)
      - Sábados: 9:00 AM - 2:00 PM (10 slots)
      - Domingos: Cerrado (0 slots)
    * `getMorningSlots(slots)` - Filtra mañana (9AM-12PM)
    * `getAfternoonSlots(slots)` - Filtra tarde (12PM-7PM)
    * `hasAvailableSlots(date)` - Verifica disponibilidad del día
    * `getNextAvailableSlot(fromDate)` - Encuentra próximo slot libre (60 días)

- **AppointmentService** (`lib/data/services/appointment_service.dart`) ✅
  - Servicio para gestión completa de citas
  - **Storage**: Lista en memoria (preparado para Firebase/Supabase)
  - **Métodos CRUD**:
    * `getAppointments()` - Obtiene todas las citas
    * `getAppointmentsByDate(date)` - Filtra por fecha
    * `bookAppointment(appointment)` - Crea nueva cita con validación
    * `updateAppointmentStatus(id, status)` - Actualiza estado
    * `cancelAppointment(id)` - Cancela con validación 24h
    * `confirmAppointment(id)` - Confirma la cita
  - **Métodos de Disponibilidad**:
    * `getBookedSlots(date)` - Obtiene slots ocupados
    * `getAvailableSlots(date)` - Retorna lista de TimeSlot con disponibilidad
    * `isSlotAvailable(date, timeSlot)` - Verifica slot específico
    * `hasSlotsAvailable(date)` - Valida disponibilidad del día
    * `getNextAvailableDate()` - Encuentra próxima fecha disponible
  - **Métodos de Consulta**:
    * `getPendingAppointments()` - Citas pendientes futuras
    * `getConfirmedAppointments()` - Citas confirmadas futuras
    * `getUpcomingAppointments()` - Próximos 7 días
    * `getStatistics()` - Estadísticas por estado y tipo
  - **Métodos de Desarrollo**:
    * `clearAllAppointments()` - Limpia todas las citas
    * `addSampleAppointments()` - Agrega datos de prueba

- **AppointmentCalendar Widget** (`lib/presentation/widgets/appointment_calendar.dart`) ✅
  - Calendario mensual interactivo para selección de fecha
  - **Características**:
    * Navegación de meses (anterior/siguiente)
    * Encabezados de día de la semana (L M M J V S D)
    * Grid de calendario con alineación correcta
    * **Indicadores Visuales**:
      - Fecha seleccionada: Fondo azul, texto blanco
      - Día actual: Borde azul
      - Fechas pasadas: Deshabilitadas, texto gris
      - Domingos: Siempre deshabilitados (cerrado)
      - Días con disponibilidad: Texto negro
      - Días sin disponibilidad: Fondo gris claro
    * Leyenda explicativa (Disponible/No disponible)
    * Cache de disponibilidad para performance
  - **Estado**: `_currentMonth`, `_selectedDate`, `_availabilityCache`
  - **Métodos**: 
    * `_loadAvailability()` - Carga disponibilidad del mes
    * `_isDateAvailable()` - Verifica disponibilidad
    * `_selectDate()` - Maneja selección
  - **Callbacks**: `onDateSelected(DateTime)`
  - **Restricciones**: No permite navegar a meses pasados

- **AppointmentTimePicker Widget** (`lib/presentation/widgets/appointment_time_picker.dart`) ✅
  - Selector de horarios con slots de 30 minutos
  - **Características**:
    * Carga asíncrona de slots disponibles
    * **Separación por Periodo**:
      - Mañana: 9:00 AM - 12:00 PM (☀️ icono sol)
      - Tarde: 12:00 PM - 7:00 PM (🌆 icono twilight)
    * **Visualización de Chips**:
      - Slot seleccionado: Fondo azul, texto blanco, borde 2px, bold
      - Slot disponible: Fondo blanco, borde gris
      - Slot no disponible: Fondo gris, texto gris, no clickeable
    * Estado vacío: Icono + mensaje cuando no hay slots
    * Reactivo: Recarga al cambiar fecha
  - **Estado**: `_allSlots`, `_selectedTime`, `_isLoading`
  - **Callbacks**: `onTimeSelected(String)`
  - Layout: Wrap responsive para slots

- **AppointmentBookingDialog Widget** (`lib/presentation/widgets/appointment_booking_dialog.dart`) ✅
  - Diálogo modal de 4 pasos para reservar cita
  - **Estructura**:
    * Header: Fondo azul, título, subtítulo, botón cerrar
    * Body: Área scrollable con contenido del paso actual
    * Footer: Fondo gris, botones de navegación
  - **Paso 1: Selección de Fecha**:
    * Indicador de progreso (4 barras)
    * Texto de instrucciones
    * Widget AppointmentCalendar
    * Botón "Siguiente" habilitado al seleccionar fecha
  - **Paso 2: Selección de Hora**:
    * Widget AppointmentTimePicker para fecha seleccionada
    * Resetea hora al volver del paso 3
    * Botón "Siguiente" habilitado al seleccionar hora
  - **Paso 3: Tipo de Cita**:
    * 3 opciones en cards estilo radio:
      - 🏢 Presencial - Reunión en oficina
      - 📹 Video Llamada - Consulta virtual (defecto)
      - 📞 Teléfono - Llamada telefónica
    * Card seleccionada: Borde azul, fondo azul claro, check icon
    * Siempre tiene una selección (video por defecto)
  - **Paso 4: Formulario de Contacto**:
    * Card de resumen (fondo azul): Fecha, hora, tipo
    * **Campos del formulario**:
      - Nombre completo* (min 3 caracteres)
      - Email* (validación de formato)
      - Teléfono (opcional, validación si se llena)
      - Notas adicionales (opcional, max 500 caracteres)
    * Botón "Confirmar Cita" (verde)
  - **Gestión de Estado**:
    * `_currentStep` (0-3)
    * `_selectedDate`, `_selectedTime`, `_selectedType`
    * Controladores: `_nameController`, `_emailController`, `_phoneController`, `_notesController`
    * `_isSubmitting` para loading
  - **Navegación**:
    * Botón "Atrás": Visible en pasos 1-3
    * Botón "Siguiente": Visible en pasos 0-2, habilitado si paso válido
    * Botón "Confirmar": Paso 3, async con spinner
  - **Envío**:
    * Crea objeto Appointment
    * Llama `AppointmentService.bookAppointment()`
    * Éxito: Cierra diálogo, SnackBar verde con confirmación
    * Error: SnackBar rojo con mensaje de error
    * Loading: Botón deshabilitado con CircularProgressIndicator
  - **AppointmentBookingButton**:
    * Variante compacta: Icono + "Agendar"
    * Variante completa: Icono + "Agendar Asesoría Gratuita"
    * Fondo verde, texto blanco
    * Abre diálogo con `showDialog()`

- **Integración en ContactFooterSection** ✅
  - Agregado botón de citas en las 3 layouts responsivas
  - **Desktop (>900px)**: 3 columnas
    * Columna 1: Información de contacto
    * Columna 2: Asesoría personalizada (nuevo) 📅
    * Columna 3: Consulta rápida
  - **Tablet (>600px)**: 2 filas
    * Fila 1: Info contacto + Asesoría (2 columnas)
    * Fila 2: Consulta rápida (ancho completo)
  - **Móvil (<600px)**: 3 cards apiladas
    * Card 1: Información de contacto
    * Card 2: Asesoría personalizada (nuevo) 📅
    * Card 3: Consulta rápida
  - **Diseño de Card de Asesoría**:
    * Icono: `calendar_today` (verde)
    * Título: "Asesoría Personalizada"
    * Descripción: "Agenda una cita gratuita con nuestros expertos"
    * Botón: AppointmentBookingButton
    * Tema: Verde para diferenciar de otros métodos

### 🔧 Mejoras

- Optimización de cache de disponibilidad en calendario
- Validación completa de formularios con mensajes específicos
- Separación clara de slots AM/PM para mejor UX
- Loading states en todos los pasos del proceso
- Manejo robusto de errores con feedback al usuario
- Layout responsivo completo en todas las pantallas

### 📚 Documentación

- Documentados todos los modelos de citas
- Guía de uso del sistema de reservas
- Especificación de horarios de negocio
- Descripciones de tipos y estados de citas

---

## [v0.13.0] - 2025-01-12

### ✨ Nueva Funcionalidad

#### 📞 Sistema de Métodos de Contacto Rápido

Implementación completa de los métodos de contacto rápido para mejorar la comunicación con los clientes.

- **Modelo ContactInquiry** (`lib/data/models/contact_inquiry.dart`) ✅
  - Modelo para consultas de contacto rápido
  - Campos:
    * `name` (String) - Nombre completo del cliente
    * `email` (String) - Email del cliente
    * `phone` (String?) - Teléfono opcional
    * `message` (String) - Mensaje de consulta
    * `timestamp` (DateTime) - Fecha y hora de la consulta
    * `type` (InquiryType) - Tipo de consulta
    * `subject` (String?) - Asunto opcional
  - **Enum InquiryType**: 8 tipos de consulta
    * General, PackageInfo, Booking, Modification
    * Cancellation, Complaint, Payment, Other
  - **Métodos de Validación**:
    * `isValid()` - Verifica campos obligatorios
    * `_isValidEmail()` - Valida formato de email
    * `getInvalidReason()` - Retorna mensaje de error específico
  - Conversión: `toMap()`, `fromMap()`, `copyWith()`

- **ContactService** (`lib/data/services/contact_service.dart`) ✅
  - Servicio centralizado para gestión de contactos
  - **Información de Contacto**:
    * Teléfono: +51 984 102 859
    * WhatsApp: 51984102859
    * Email: info@byletytravels.com
    * Teléfono emergencia: +51 984 102 859
  - **Horarios de Atención**:
    * Lunes a Viernes: 9:00 AM - 7:00 PM
    * Sábados: 9:00 AM - 2:00 PM
    * Domingos: Cerrado
  - **Métodos Principales**:
    * `isOpenNow()` - Verifica si está abierto ahora
    * `getCurrentBusinessHoursText()` - Obtiene horario actual
    * `getAvailabilityStatus()` - Estado: "En línea" o "Fuera de horario"
    * `getWhatsAppMessage()` - Genera mensaje predefinido
    * `getWhatsAppUrl()` - URL con mensaje para WhatsApp
    * `getPhoneCallUrl()` - URL para llamada telefónica (tel:)
    * `getEmailUrl()` - URL mailto con subject/body
    * `sendInquiry()` - Envía consulta (simulado)
    * `isValidEmail()`, `isValidPhone()` - Validadores
    * `getNextOpeningTime()` - Próximo horario de apertura

- **FloatingWhatsAppButton** (`lib/presentation/widgets/floating_whatsapp_button.dart`) ✅
  - **Versión Completa**:
    * Botón flotante verde oficial WhatsApp (#25D366)
    * Posición fija: esquina inferior derecha
    * Animación de pulso con `SingleTickerProviderStateMixin`
    * Badge "En línea" cuando está disponible
    * Mensaje predefinido según contexto (puede recibir packageName)
    * Shadow effect con blur y spread
    * FloatingActionButton.extended con icono + texto
  - **Versión Compacta** (FloatingWhatsAppButtonCompact):
    * Solo icono circular
    * Badge verde de estado (punto)
    * Animación de pulso más pronunciada
    * FloatingActionButton estándar
  - **Integración**:
    * Usa `url_launcher` para abrir WhatsApp
    * Mode: LaunchMode.externalApplication
    * Manejo de errores con SnackBar
    * Verifica canLaunchUrl antes de abrir

- **CallNowButton** (`lib/presentation/widgets/call_now_button.dart`) ✅
  - **Versión Completa**:
    * Card blanco con padding y shadow
    * Icono de teléfono en círculo azul
    * Muestra número: +51 984 102 859
    * Sección de horario de atención
    * Badge verde/naranja según disponibilidad
    * Botón "Llamar Ahora" destacado
    * Click-to-call funcional en móviles
  - **Versión Compacta**:
    * Solo botón con icono + número
    * Padding reducido
    * Para uso en headers/toolbars
  - **CallNowIconButton**:
    * Solo icono con tooltip
    * Para espacios reducidos
  - **ContactInfoCard**:
    * Card completa con toda la info de contacto
    * Estado actual: "Estamos disponibles" / "Cerrado"
    * Lista completa de horarios por día
    * Integra CallNowButton compacto
    * Diseño responsivo

- **QuickInquiryDialog** (`lib/presentation/widgets/quick_inquiry_dialog.dart`) ✅
  - **Diálogo Modal**:
    * Máximo width: 500px
    * Border radius: 16px
    * Scrollable para móviles
    * Botón X para cerrar
  - **Formulario Completo**:
    * GlobalKey<FormState> para validación
    * Controllers: name, email, phone, message
    * Dropdown: InquiryType con 8 opciones
    * Nombre (3+ chars, requerido)
    * Email (formato válido, requerido)
    * Teléfono (opcional, validación si se llena)
    * Mensaje (10+ chars, requerido)
  - **Estados**:
    * _isSubmitting - Loading durante envío
    * Deshabilitado durante submit
    * CircularProgressIndicator en botón
  - **Confirmaciones**:
    * SnackBar verde con ícono check al enviar
    * Mensaje: "¡Consulta enviada! Nos pondremos en contacto pronto"
    * Duration: 4 segundos
    * SnackBar rojo si hay error
  - **QuickInquiryButton**:
    * Botón para abrir el diálogo
    * Versión completa y compacta
    * Puede recibir defaultType y defaultSubject
    * Llama showDialog con QuickInquiryDialog

- **Integración en Páginas** ✅
  - **HomePage** (`lib/presentation/pages/home_page.dart`):
    * Body cambió de SingleChildScrollView a Stack
    * FloatingWhatsAppButton posicionado sobre el contenido
    * Siempre visible durante scroll
  - **ContactFooterSection** mejorado:
    * Nueva sección "📞 Contáctanos" con título grande
    * Layout responsivo con LayoutBuilder:
      - **Desktop** (>900px): 3 columnas
        1. CallNowButton
        2. ContactInfoCard
        3. Card con QuickInquiryButton
      - **Tablet** (>600px): 2 filas
        1. CallNowButton + ContactInfoCard
        2. QuickInquiryButton full width
      - **Móvil** (<600px): 3 tarjetas apiladas
    * Padding vertical: 60px
    * Fondo: #072A47 (azul oscuro)
    * Footer copyright: gris oscuro con texto 2025

### 🎨 Mejoras UI/UX

- **Animaciones**:
  - Pulso continuo en FloatingWhatsAppButton (2 segundos loop)
  - Scale de 1.0 a 1.1 con ease-in-out
  - Badge "En línea" con punto verde animado
  - Transiciones suaves en todos los botones

- **Diseño Responsivo**:
  - ContactFooterSection con 3 breakpoints
  - Widgets adaptativos: CallNowButton isCompact
  - QuickInquiryDialog scrollable en móviles
  - Botones con padding ajustado según pantalla

- **Accesibilidad**:
  - Tooltips en IconButtons
  - Labels descriptivos en formularios
  - Mensajes de error específicos
  - Color contrast adecuado (WCAG)
  - Click-to-call funcional en móviles

### 🔧 Dependencias

- **url_launcher**: ^6.3.1 (ya existente)
  - Usado para WhatsApp, llamadas telefónicas y emails
  - Modos: externalApplication para apps
  - Validación con canLaunchUrl()

### 📱 Funcionalidades Móviles

- **Click-to-Call**:
  - URL: `tel:+51984102859`
  - Abre app de teléfono nativa
  - Funciona en Android/iOS/Web

- **WhatsApp Directo**:
  - URL: `https://wa.me/51984102859?text=...`
  - Mensaje predefinido personalizable
  - Abre WhatsApp o WhatsApp Web

- **Email Mailto**:
  - URL: `mailto:info@byletytravels.com?subject=...&body=...`
  - Pre-llena subject y body
  - Abre cliente de email predeterminado

### 🚀 Próximos Pasos

- [ ] Conectar ContactService.sendInquiry() con backend real
- [ ] Integrar con Firebase Firestore para guardar consultas
- [ ] Configurar SendGrid/Mailgun para envío de emails
- [ ] Agregar WhatsApp Business API para respuestas automáticas
- [ ] Implementar CRM para gestión de leads (HubSpot/Zoho)
- [ ] Analytics: rastrear clicks en botones de contacto

---

## [v0.12.0] - 2025-01-12

### ✨ Nueva Funcionalidad

#### 📝 Sistema de Reservas - Formulario Completo

Implementación integral del formulario de reserva con todas las secciones requeridas, validaciones y resumen en tiempo real.

- **Modelo de Datos**:
  - **BookingData** (`lib/data/models/booking_data.dart`) ✅
    * Información del viajero: nombre, apellidos, email, teléfono, país, fecha nacimiento, pasaporte
    * Detalles de reserva: paquete, fecha salida, número de viajeros (adultos/niños/infantes), tipo habitación
    * Servicios adicionales: seguro, traslado, tours, upgrade hotel, asientos
    * Cálculos automáticos: subtotal, servicios adicionales, impuestos (5%), total
    * Lógica de precios: adultos 100%, niños 70%, infantes 10%
    * Enum RoomType: Individual, Doble, Triple

- **Página de Reserva**:
  - **BookingFormPage** (`lib/presentation/pages/booking_form_page.dart`) ✅
    * Formulario multi-sección con GlobalKey para validación
    * Layout responsivo: columna en mobile, row con sidebar en desktop
    * Controllers para todos los campos de texto
    * Estado local para dropdowns, fechas, contadores, checkboxes
    * Navegación desde TravelPackageCard (botón "Book Now")

- **Sección 1: Información del Viajero** ✅
  - **Campos Implementados**:
    * Nombre y Apellidos (requeridos) - TextFormField con validación
    * Email (requerido) - Validación con regex
    * Teléfono (requerido) - Dropdown código país (+51 🇵🇪, +1 🇺🇸, etc.) + número
    * País de Residencia (requerido) - Dropdown con banderas
    * Fecha de Nacimiento (opcional) - DatePicker
    * Número de Pasaporte (opcional) - Input uppercase, max 12 chars
  
  - **Validaciones**:
    * Campos requeridos verifican no vacío
    * Email valida formato correcto
    * Teléfono valida mínimo 6 dígitos
    * Solo permite caracteres válidos en cada campo

- **Sección 2: Detalles de la Reserva** ✅
  - **Paquete Pre-llenado**:
    * Card con info del paquete seleccionado
    * Muestra: título, duración, ubicación, precio base
    * Estilo destacado con borde azul
  
  - **Fecha de Salida** (requerida):
    * DatePicker con rango: hoy → +2 años
    * Formato: "Lunes, 15 Noviembre 2025"
    * Validación: no permite fechas pasadas
  
  - **Número de Viajeros**:
    * Contadores con +/- buttons para Adultos (min: 1), Niños, Infantes
    * Descripciones: "Mayores de 12 años", "2-12 años (70%)", "0-2 años (10%)"
    * Actualización reactiva del resumen
  
  - **Tipo de Habitación**:
    * ChoiceChips: Individual, Doble, Triple
    * Selección única con highlight visual

- **Sección 3: Servicios Adicionales** ✅
  - **CheckboxListTile para cada servicio**:
    * 🛡️ Seguro de Viaje: +$50/persona - Cobertura médica y cancelación
    * 🚐 Traslado Aeropuerto: +$30/persona - Recogida y traslado
    * 🎫 Tour Adicional: +$100/persona - Tour especial no incluido
    * 🏨 Upgrade Hotel 5★: +$200/habitación - Categoría superior
    * ✈️ Asientos Preferentes: +$40/persona - Más espacio
  
  - **Cálculo Inteligente**:
    * Multiplica por número de personas según aplique
    * Upgrade hotel es costo único por habitación
    * Asientos solo para adultos y niños (no infantes)

- **Sección 4: Códigos de Descuento** ✅
  - **Modelo Coupon** (`lib/data/models/coupon.dart`):
    * Tipos: Porcentaje (5%-30%) o Monto fijo ($50-$200)
    * Validaciones: fecha expiración, compra mínima, usos máximos
    * Métodos: isValid(), isApplicableFor(), calculateDiscount()
    * getInvalidReason() para mensajes de error específicos
  
  - **CouponService** (`lib/data/services/coupon_service.dart`):
    * 10 cupones predefinidos para demostración
    * WELCOME10 (10% off), SUMMER20 (20% off), VIP25 (25% off)
    * SAVE50 ($50 off), SAVE100 ($100 off), EARLYBIRD ($150 off)
    * BLACKFRIDAY (30% off), NEWYEAR2026 (15% off)
    * Métodos: validateCoupon(), getActiveCoupons(), getRecommendedCoupons()
  
  - **UI de Cupones**:
    * Campo de texto uppercase para código (max 20 chars)
    * Botón "Aplicar" que valida y aplica cupón
    * Mensajes de error específicos: código inválido, expirado, compra mínima
    * Card verde de confirmación cuando cupón aplicado exitosamente
    * Botón "Remover" para limpiar cupón
    * Chips clickeables con cupones recomendados (4 sugerencias)
  
  - **Integración en BookingData**:
    * Campo appliedCoupon opcional
    * Getters: subtotalBeforeDiscount, discountAmount, subtotalAfterDiscount
    * Impuestos calculados DESPUÉS del descuento
    * copyWith() con parámetro clearCoupon
  
  - **Resumen Actualizado**:
    * Línea de subtotal antes de descuento
    * Línea de descuento en verde: "Descuento (CÓDIGO): -$XXX"
    * Subtotal con descuento en bold
    * Impuestos sobre monto con descuento
    * Total final refleja descuento aplicado

- **Sección 5: Comentarios Especiales** ✅
  - **TextArea** multilinea (5 líneas, max 500 chars)
  - Placeholder con ejemplos: habitación piso bajo, vegetariano, cumpleaños
  - Contador de caracteres

- **Resumen de Reserva en Tiempo Real** ✅
  - **Panel Lateral Sticky** (desktop) o debajo (mobile)
    * Card destacado con sombra y borde
    * Título: "Resumen de Reserva"
  
  - **Información de Reserva**:
    * Paquete seleccionado con ícono 🧳
    * Fecha de salida si está seleccionada 📅
    * Número total de viajeros 👥
  
  - **Desglose de Precios Detallado**:
    * Precio base × adultos
    * Precio × niños (70% mostrado)
    * Precio × infantes (10% mostrado)
    * Separador para "Servicios Adicionales"
    * Cada servicio × cantidad aplicable
    * Línea de Subtotal en bold
    * Impuestos (5%) calculados sobre subtotal + servicios
    * TOTAL A PAGAR en grande y bold (#072A47)
  
  - **Actualización Reactiva**:
    * Se recalcula con cada cambio en cualquier campo
    * setState() mantiene UI sincronizada
    * Formato: $X,XXX.XX con 2 decimales

- **Validaciones del Formulario** ✅
  - **Validación en Submit**:
    * _formKey.currentState!.validate() verifica todos los campos
    * SnackBar roja si hay errores: "Complete todos los campos requeridos"
    * No permite enviar si faltan campos obligatorios
  
  - **Validaciones Específicas**:
    * Email: formato válido con regex
    * Teléfono: mínimo 6 dígitos
    * Fecha salida: debe estar seleccionada
    * Al menos 1 adulto requerido (contador con min: 1)

- **Proceso de Envío** ✅
  - **Loading State**:
    * _isSubmitting = true muestra CircularProgressIndicator
    * Mensaje: "Procesando tu reserva..."
    * Simula API call con Future.delayed(2 segundos)
  
  - **Dialog de Confirmación**:
    * Ícono de check verde
    * Título: "¡Reserva Confirmada!"
    * Número de reserva único: BLT-[timestamp]
    * Card con resumen: Paquete, Viajeros, Total
    * Mensaje: "Email enviado a [email]"
    * Botones: "Cerrar" y "Descargar Voucher" (mock)
    * barrierDismissible: false

- **UX y Diseño**:
  - **Responsive Layout**:
    * Mobile: Formulario en columna, resumen debajo
    * Desktop: Formulario 2/3 + Resumen 1/3 lado a lado
    * Padding adaptativo: 16px mobile, 32px desktop
  
  - **Visual Design**:
    * Cards blancas con sombra suave (0.05 opacity)
    * Border radius 12px para consistencia
    * Color primario: #072A47 (azul oscuro)
    * Color acento: #FFDC00 (amarillo) en botón submit
    * Icons con color temático
  
  - **Botón Submit**:
    * Full width en mobile, fixed en desktop dentro del resumen
    * Color: Amarillo #FFDC00 con texto azul oscuro
    * Ícono check_circle_outline + texto "Confirmar Reserva"
    * Padding vertical 20px para fácil tap

- **Navegación**:
  - **Desde TravelPackageCard**:
    * Botón "Book Now" navega a BookingFormPage
    * Pasa el objeto PackageTravel completo
    * MaterialPageRoute con transición nativa
  
  - **Actualizado en**:
    * FilterablePackagesSection (grid principal)
    * PopularDestinationsSection (hero section)

- **Dependencias Agregadas**:
  - **intl: ^0.19.0** para formato de fechas
    * DateFormat con locale español
    * Formatos: dd/MM/yyyy, EEEE dd MMMM yyyy, dd MMM yyyy

- **Preparación para Futuro**:
  - Estructura lista para integrar backend real
  - toJson() method en BookingData para envío a API
  - Mock de email de confirmación
  - Placeholder para descarga de voucher PDF

---

## [v0.11.0] - 2025-01-12

### ✨ Nueva Funcionalidad

#### 📄 Sistema de Paginación

Implementación de paginación tradicional con controles de navegación y scroll to top.

- **Arquitectura de Paginación**:
  - **Estado en FilterablePackagesSection** ✅
    * Variables de estado: `_currentPage`, `_itemsPerPage = 9`, `_isLoadingPage`
    * Getters calculados: `_totalPages`, `_paginatedPackages`
    * ScrollController para gestión de scroll
    * Listener para mostrar/ocultar botón scroll-to-top (threshold: 300px)

- **Navegación de Páginas**:
  - **Métodos de Control** ✅
    * `_goToPage(int page)`: Navegación async con loading de 300ms + scroll
    * `_nextPage()`: Incrementa página si no está en la última
    * `_previousPage()`: Decrementa página si no está en la primera
    * `_scrollToTop()`: Scroll suave al inicio usando ScrollController
  
  - **Reset Automático** ✅
    * Resetea a página 1 al cambiar ordenamiento (`_updateSort()`)
    * Resetea a página 1 al aplicar filtros

- **Componentes UI**:
  - **Controles de Paginación** ✅
    * Ubicación: Debajo del grid de paquetes
    * Botones: Previous (◀), números de página, Next (▶)
    * Números visibles: Máximo 7 páginas con ellipsis (...)
    * Lógica inteligente: Muestra primera, última, actual y cercanas
    * Estilo: Página actual con fondo azul oscuro (#072A47), otras outlined
    * Responsive: Tamaño uniforme 40x40px para todos los botones
  
  - **Indicador de Resultados** ✅
    * Texto: "Mostrando X-Y de Z paquetes"
    * Posición: Arriba del grid
    * Actualización dinámica con cada cambio de página
  
  - **Loading State** ✅
    * CircularProgressIndicator durante transiciones de página
    * Oculta grid temporalmente (300ms) para smooth UX
    * Color: #072A47 (azul oscuro corporativo)
  
  - **Scroll to Top Button** ✅
    * FloatingActionButton con ícono arrow_upward
    * Aparece cuando scroll > 300px
    * Posición: Bottom-right (20, 20)
    * Acción: Scroll suave a posición 0 (500ms)
    * Tooltip: "Volver arriba"
    * Colores: Background #072A47, foreground blanco

- **Integración con Grid**:
  - **Actualización de GridView** ✅
    * Cambio de `_filteredPackages` a `_paginatedPackages`
    * itemCount actualizado a `_paginatedPackages.length`
    * Slice automático del array según página actual
  
  - **Wrapper en Column** ✅
    * Grid envuelto en Column para agregar controles debajo
    * Conditional rendering basado en `_isLoadingPage`

- **Responsive Design**:
  - Controles visibles en todos los breakpoints
  - Botones con tamaño fijo para consistencia
  - FAB siempre accesible en mobile y desktop

---

## [v0.10.0] - 2025-01-12

### ✨ Nueva Funcionalidad

#### ❤️ Sistema de Favoritos Completo

Implementación integral del sistema de favoritos con persistencia local y UI reactiva.

- **Arquitectura de Favoritos**:
  - **FavoritesService** (`lib/data/services/favorites_service.dart`) ✅
    * Gestión de localStorage con SharedPreferences
    * Métodos: add, remove, toggle, get, isFavorite, clear, getCount
    * Persistencia en navegador con key 'favorite_packages'
    * Almacena títulos de paquetes como List<String>
  
  - **FavoritesProvider** (`lib/presentation/providers/favorites_provider.dart`) ✅
    * State management global con ChangeNotifier
    * Propiedades reactivas: _favoriteTitles, favoritesCount, isLoading
    * Auto-carga desde storage en inicialización
    * Métodos: toggleFavorite, getFavoritePackages, clearAll, refresh
    * notifyListeners() para actualizaciones en tiempo real
  
  - **Provider Setup** en `main.dart` ✅
    * MultiProvider envuelve MaterialApp
    * ChangeNotifierProvider<FavoritesProvider> disponible globalmente

- **Componentes UI**:
  - **Botón de Favorito en Cards** ✅
    * Corazón en esquina superior derecha (top: 12, right: 12)
    * Icon filled (rojo) si es favorito, outlined (gris) si no
    * Consumer<FavoritesProvider> para updates reactivos
    * InkWell con CircleBorder para ripple effect
    * Fondo blanco circular con sombra
    * Toggle async con await
  
  - **Badge de Contador en Navbar** ✅
    * Ícono de corazón en AppBar actions
    * Consumer reactivo muestra count en tiempo real
    * Badge circular rojo con número
    * Muestra "99+" si count > 99
    * onPressed scroll a MyFavoritesSection
  
  - **MyFavoritesSection** (`lib/presentation/widgets/sections/my_favorites_section.dart`) ✅
    * Sección completa con Consumer<FavoritesProvider>
    * **Header**: Título, contador, botón "Limpiar Todo"
    * **Info banner**: Explica persistencia local y comparación (hasta 3)
    * **Empty State**: Mensaje, ícono grande, botón "Explorar Paquetes"
    * **Grid responsive**: 3 cols (desktop), 2 cols (tablet), 1 col (mobile)
    * **Confirmación de limpieza**: AlertDialog antes de eliminar todos
    * **SnackBar feedback**: Notifica acciones completadas
    * Integrada en HomePage después de OurPackagesSection

- **Dependencias Agregadas**:
  - `shared_preferences: ^2.3.3` - LocalStorage browser
  - `provider: ^6.1.2` - State management reactivo

- **Estado de Implementación**:
  - ✅ Service layer (localStorage CRUD)
  - ✅ Provider layer (global state)
  - ✅ Favorite button (cards) - Posicionado al lado del precio
  - ✅ Navbar badge (counter)
  - ✅ MyFavoritesSection (display & manage)
  - ✅ Comparison feature (comparar hasta 3 paquetes)

#### 🔀 Sistema de Comparación de Paquetes

Funcionalidad completa para comparar hasta 3 paquetes favoritos lado a lado.

- **Estado de Comparación en Provider**:
  - Lista `_selectedForComparison` para tracking de selección
  - Máximo 3 paquetes (`maxComparisonPackages = 3`)
  - Getters: `selectedForComparison`, `selectedComparisonCount`, `canCompare`, `isMaxComparisonReached`
  - Métodos: `toggleComparisonSelection()`, `clearComparisonSelection()`, `getSelectedPackagesForComparison()`
  - Auto-limpieza: Remueve de comparación si se elimina de favoritos

- **UI de Selección**:
  - **Checkbox en cada card** de MyFavoritesSection
    * Positioned en top-left con label "Comparar"
    * Fondo blanco con borde y sombra
    * Se deshabilita cuando se alcanza máximo (3) y no está seleccionado
    * Visual feedback: borde azul oscuro cuando seleccionado
  
- **Floating Action Button (FAB)**:
  - Aparece solo cuando 2-3 paquetes están seleccionados (`canCompare`)
  - Positioned en bottom-right
  - Color amarillo (#FFDC00) con texto azul oscuro (#072A47)
  - Ícono `compare_arrows` + label "Comparar (n)"
  - Elevation 8 para destacar

- **Modal de Comparación**:
  - Dialog fullscreen con max-width 1200px
  - **Header**: Título, ícono, botón cerrar (fondo azul oscuro)
  - **Tabla comparativa** con scroll:
    * Columnas: Label + 2-3 paquetes seleccionados
    * Filas: Precio, Precio Original, Descuento, Duración, Destino, Hotel, Vuelos, Tours, Servicios
    * Colores alternados para mejor legibilidad
    * Responsive: se adapta a mobile/tablet/desktop
  - **Footer**: Botón "Limpiar Selección" + "Cerrar"
  - Diseño alineado con color scheme de ByLetyTravels

- **UX Mejorada**:
  - ✅ Iconos visuales: ✅ incluido, ❌ no incluido, ⭐ rating
  - ✅ Colores temáticos: verde (precio), rojo (descuento), ámbar (hotel), azul (servicios)
  - ✅ Feedback inmediato al seleccionar/deseleccionar
  - ✅ Límite claro de 3 paquetes con deshabilitación automática

#### 🔍 Sistema de Búsqueda de Paquetes

Sistema completo de búsqueda con autocomplete, sugerencias y highlighting.

- **SearchProvider** (`lib/presentation/providers/search_provider.dart`) ✅:
  - State management para búsqueda con ChangeNotifier
  - Propiedades: `searchQuery`, `searchResults`, `searchHistory`, `isSearching`
  - **Algoritmo de búsqueda inteligente**:
    * Busca en: título, ubicación, descripción de paquetes
    * Ordenamiento por relevancia (título > ubicación > descripción)
    * Resultados en tiempo real mientras se escribe
  - **Historial de búsqueda**:
    * Guarda últimas 10 búsquedas en SharedPreferences
    * Muestra búsquedas recientes como sugerencias
    * Opción para eliminar items del historial
    * Botón para limpiar todo el historial

- **PackageSearchBar** Widget (`lib/presentation/widgets/package_search_bar.dart`) ✅:
  - Barra de búsqueda con diseño moderno
  - TextField con bordes redondeados y sombra
  - Ícono de búsqueda (prefijo) y botón clear (sufijo)
  - **Autocomplete con Overlay**:
    * Dropdown de sugerencias aparece al escribir
    * Muestra hasta 8 sugerencias relevantes
    * Sugerencias de historial con ícono `history`
    * Sugerencias nuevas con ícono `search`
  - **Text Highlighting**:
    * Resalta texto coincidente en negrita
    * Color azul oscuro (#072A47) para matches
    * RichText para highlighting preciso
  - **UX Features**:
    * Loading spinner mientras busca
    * Click en sugerencia auto-completa búsqueda
    * Enter key ejecuta búsqueda
    * Focus/unfocus maneja overlay automáticamente

- **SearchResultsPage** (`lib/presentation/pages/search_results_page.dart`) ✅:
  - Página completa dedicada a resultados
  - **Header** con search bar integrado
  - **Contador de resultados**: "X resultados para 'query'"
  - **Grid responsive** de paquetes encontrados
  - **Estados visuales**:
    * Empty state inicial: "Busca tu destino ideal"
    * Loading state con CircularProgressIndicator
    * No results state: "No encontramos resultados"
    * Results state con grid de cards
  - **Búsquedas recientes** como chips clickeables
  - Navegación: botón back en AppBar

- **Integración en HomePage**:
  - Botón de búsqueda (🔍) en AppBar actions
  - Abre SearchResultsPage con Navigator.push
  - SearchProvider disponible globalmente vía MultiProvider

- **Features Avanzadas**:
  - ✅ Autocomplete en tiempo real
  - ✅ Sugerencias contextuales
  - ✅ Highlighting de matches
  - ✅ Historial persistente
  - ✅ Búsqueda multi-campo
  - ✅ Ordenamiento por relevancia
  - ✅ UI responsive y moderna

---

## [v0.9.1] - 2025-01-12

### 🔧 Mejoras y Correcciones

#### 🎯 Fix: Flip Animation Button Accessibility & Persistent Flip

- **Problema 1 Resuelto**: La animación flip al hacer hover impedía hacer click en el botón "Ver Detalles"
- **Problema 2 Resuelto**: Después de leer info en la cara trasera, no había forma de volver al frente

- **Soluciones Implementadas**: 
  
  **1. Flip solo en imagen** ✅:
  - Flip animation ahora solo se activa con hover sobre la **imagen** del paquete
  - Los botones de acción quedan accesibles en todo momento
  - MouseRegion separado para la sección de imagen
  - `_handleFlipHover()` method solo para el área de la imagen
  - `_handleHover()` method mantiene el efecto de elevación en toda la card

  **2. Flip persistente con toggle** ✅:
  - La card permanece volteada después del hover en la imagen
  - **Click en la cara trasera** vuelve al frente (GestureDetector)
  - Estado `_isFlipped` mantiene el estado actual
  - Solo se resetea cuando el mouse sale completamente de la card
  - Icono de "touch" (👆) visible en esquina superior derecha del reverso

- **Flujo de Interacción**:
  1. Usuario pasa mouse sobre la **imagen** → Card se voltea
  2. Usuario lee información en la cara trasera
  3. Usuario hace **click en cualquier parte del reverso** → Vuelve al frente
  4. O usuario saca el mouse de la card → Vuelve al frente automáticamente

- **Beneficios de UX**:
  - Usuario puede hacer click en "Ver Detalles" sin problemas ✅
  - Botón "Reservar" siempre accesible ✅
  - Flip animation se mantiene como feature interesante ✅
  - Usuario puede **leer tranquilamente** la información del reverso ✅
  - **Click intuitivo** para volver (indicado con icono) ✅
  - Mejor experiencia de usuario y menor frustración ✅
  - Área de imagen sigue siendo interactiva con efecto flip ✅

- **Cambios Técnicos**:
  - Método `_handleFlipHover(bool shouldFlip)` para controlar flip inicial
  - Método `_toggleFlip()` para alternar estado con click
  - Estado `_isFlipped` para tracking del estado actual
  - MouseRegion envolviendo solo `_buildImageSection()`
  - GestureDetector envolviendo `_buildBackCard()` con onTap
  - Positioned widget con icono touch_app en esquina del reverso
  - Separación de concerns: hover general vs flip animation
  - Reset automático cuando mouse sale de la card

### 📱 UX Improvements

- **Zona "Safe"**: Botones siempre accesibles sin interferencia del flip
- **Hover Intelligence**: Solo la imagen activa la animación flip inicial
- **Click Reliability**: 100% de confiabilidad en los botones de acción
- **Persistent Flip**: Card permanece volteada para lectura cómoda
- **Easy Return**: Click en el reverso o salir de la card para volver
- **Visual Hint**: Icono touch_app indica que se puede hacer click para volver

---

## [v0.9.0] - 2025-01-12

### ✨ Nuevas Características

#### 🎯 Modal de Detalles del Paquete

- **Modal Dialog Completo**:
  - Dialog responsivo con tamaño máximo 1200x800px
  - Header con título, ubicación, y botones de acción
  - Sistema de tabs para organizar información
  - Footer con botones de contacto y reserva
  - Diseño adaptativo móvil/desktop

- **Header Interactivo**:
  - Título destacado en amarillo sobre fondo azul oscuro
  - Ubicación con icono de pin
  - Botón de favoritos (toggle corazón)
  - Botón de compartir
  - Botón cerrar (X)

- **Tab 1: Gallery** 📷:
  - Visualización de 5-10 imágenes del destino
  - Imagen principal con navegación (flechas anterior/siguiente)
  - Contador de imagen actual (ej. "3 / 6")
  - Tira de miniaturas en la parte inferior
  - Selección de imagen con borde amarillo destacado
  - Imágenes en modo contain para visualización completa

- **Tab 2: Itinerary** 🗓️:
  - Itinerario día a día expandible
  - Cards con ExpansionTile para cada día
  - Círculo con número de día en azul oscuro
  - Título del día destacado
  - Indicador de comidas incluidas (🍽️)
  - Lista de actividades con checkmarks
  - Primer día expandido por defecto

- **Tab 3: Included** ✅:
  - Card de resumen con precio y descuento
  - Precio tachado en rojo si hay descuento
  - Precio actual en verde (grande)
  - Badge de descuento (ej. "20% OFF")
  - Información básica: duración, hotel, vuelos, tours
  - Lista de inclusiones con ✅ checkmark verde
  - Lista de exclusiones con ❌ X roja
  - Terms & Conditions expandible

- **Tab 4: Map** 🗺️:
  - Placeholder de mapa con coordenadas
  - Ubicación del destino mostrada
  - Latitud y longitud visibles
  - Botón "Get Directions" para abrir Google Maps
  - Chips con fechas de salida disponibles
  - Calendario visual de fechas

- **Footer con Botones de Acción**:
  - Botón WhatsApp (verde, outlined)
  - Botón Email (azul, outlined)
  - Botón "Book Now" (amarillo, elevated)
  - Layout responsivo: columna en móvil, fila en desktop
  - Integración con url_launcher para WhatsApp y Email

- **Funcionalidades Adicionales**:
  - Link directo a WhatsApp con mensaje predefinido
  - Mailto con asunto y cuerpo prellenado
  - Abrir Google Maps en navegador externo
  - Toast notifications para acciones pendientes
  - Estado de favorito local (toggle)

### 🔧 Mejoras Técnicas

- **Modelo PackageTravel Extendido**:
  - `galleryImages`: List<String> de URLs de imágenes
  - `itinerary`: List<DayItinerary> para itinerario día a día
  - `inclusions`: List<String> de servicios incluidos
  - `exclusions`: List<String> de servicios no incluidos
  - `termsAndConditions`: String con T&C completos
  - `availableDates`: List<DateTime> de fechas disponibles
  - `latitude` y `longitude`: Double para coordenadas

- **Nueva Clase DayItinerary**:
  - `dayNumber`: int
  - `title`: String (ej. "Arrival in Paris")
  - `activities`: List<String> de actividades del día
  - `meals`: String (ej. "Breakfast, Lunch, Dinner")

- **Sample Data Actualizada**:
  - 2 paquetes completos con todos los detalles (París y Roma)
  - 6 imágenes de galería por paquete
  - Itinerarios completos de 5-6 días
  - 10+ inclusiones y 5+ exclusiones
  - 3-4 fechas de salida disponibles
  - Coordenadas reales de cada destino

- **Widget PackageDetailsModal**:
  - StatefulWidget con TabController
  - SingleTickerProviderStateMixin para animaciones
  - Gestión de estado local para imagen seleccionada
  - Responsive design con MediaQuery
  - Integración con url_launcher

- **Integración con TravelPackageCard**:
  - onViewDetailsPressed abre el modal con showDialog
  - Paso del objeto PackageTravel completo
  - Modal como overlay sobre la aplicación

### 🎨 Diseño UI/UX

- **Color Scheme Consistente**:
  - Azul oscuro (#072A47) para headers y elementos principales
  - Amarillo (#FFDC00) para acentos y CTAs
  - Gris claro (#F5F5F5) para fondos de cards
  - Verde para inclusiones y precios
  - Rojo para exclusiones y descuentos

- **Iconografía**:
  - Icons.photo_library (Gallery)
  - Icons.map (Itinerary)
  - Icons.check_circle_outline (Included)
  - Icons.location_on (Map)
  - Icons consistentes en toda la interfaz

- **Experiencia de Usuario**:
  - Navegación por tabs clara e intuitiva
  - Información organizada y fácil de consumir
  - Acciones rápidas desde el footer
  - Feedback visual en interacciones
  - Cierre del modal con botón o clic fuera

### 📱 Responsive

- **Mobile**:
  - Padding reducido (16px horizontal, 20px vertical)
  - Título más pequeño (20px vs 24px)
  - Footer en columna (botones apilados)
  - Tabs con iconos y texto reducido

- **Desktop**:
  - Modal más grande (1200x800px max)
  - Footer en fila con 3 botones
  - Galería con controles más grandes
  - Mejor aprovechamiento del espacio

### 📦 Archivos Modificados

- `lib/data/models/package_travel.dart`: Modelo extendido con 8+ nuevos campos
- `lib/data/repositories/sample_packages.dart`: 2 paquetes con datos completos
- `lib/presentation/widgets/package_details_modal.dart`: Nuevo widget (700+ líneas)
- `lib/presentation/widgets/sections/filterable_packages_section.dart`: Integración del modal

---

## [v0.8.1] - 2024-01-11

### ✨ Nuevas Características

#### 🔄 Animación Flip en Travel Package Card

- **Efecto Flip 3D con Hover**:
  - Rotación 3D de 180° en el eje Y al hacer hover
  - Animación suave de 600ms con curva easeInOut
  - Transición fluida entre frente y reverso
  - Perspectiva 3D para efecto realista

- **Cara Frontal (Front Card)**:
  - Diseño original con imagen, badges y precio
  - Información resumida del paquete
  - Botones de acción (Ver Detalles / Reservar)
  - Fondo gris claro (#F5F5F5)

- **Cara Trasera (Back Card)**:
  - Fondo azul oscuro (#072A47) para contraste
  - Información detallada organizada
  - Título destacado en amarillo (#FFDC00)
  - Secciones con iconos:
    * 📍 Destino
    * 📅 Duración
    * 💰 Precio
    * 🏨 Alojamiento
  - Lista de características incluidas con emojis
  - Botón "Reservar Ahora" destacado
  - Diseño centrado y fácil de leer

- **Implementación Técnica**:
  - `AnimationController` para control de la animación
  - `AnimatedBuilder` para reconstruir durante la animación
  - `Transform` con `Matrix4.rotateY()` para rotación 3D
  - Detección de ángulo para mostrar cara correcta
  - `MouseRegion` para detectar hover en web
  - Limpieza correcta de recursos con `dispose()`

- **Mejoras de UX**:
  - Hover activa flip automáticamente
  - Salida del hover revierte la animación
  - Elevación de card combinada con flip
  - Información completa sin abrir modales
  - Vista rápida de detalles importantes

### 🔧 Mejoras Técnicas

- Import de `dart:math` para cálculos matemáticos (π, rotación)
- Uso de `setEntry(3, 2, 0.001)` para perspectiva 3D
- Condición `angle <= math.pi / 2` para determinar cara visible
- Transform anidado para corregir orientación de cara trasera
- Métodos helper: `_buildBackCard()`, `_buildBackInfoRow()`, `_buildFeatureItem()`

### 🎨 Diseño del Reverso

- **Color scheme contrastante**: Azul oscuro con acentos amarillos
- **Gradiente decorativo**: Línea amarilla degradada bajo el título
- **Jerarquía visual clara**: Labels grises, valores blancos
- **Espaciado generoso**: Padding de 24px para mejor legibilidad
- **Iconografía consistente**: Iconos amarillos de 20px
- **CTA prominente**: Botón amarillo con ancho completo

---

## [v0.8.0] - 2024-01-11

### ✨ Nuevas Características

#### 🎨 Mejoras en Travel Package Card

- **Sistema de Badges Visual**:
  - Badge "OFERTA": Rojo con icono de oferta, para paquetes con descuento
  - Badge "NUEVO": Azul oscuro con icono "new", para paquetes recientes
  - Badge "POPULAR": Amarillo con icono de estrella, para los más vendidos
  - Badge "ÚLTIMAS PLAZAS": Naranja con icono de alerta, para disponibilidad limitada
  - Badges con sombras y posicionados sobre la imagen del paquete

- **Sistema de Descuentos**:
  - Precio anterior mostrado tachado en ROJO cuando hay descuento
  - Precio actual SIEMPRE en verde (con o sin descuento)
  - Línea de tachado también en rojo con grosor de 2px
  - Badge circular con porcentaje de descuento (ej: "¡20% OFF!")
  - Posicionado en esquina superior derecha de la imagen

- **Campos extendidos en PackageTravel**:
  - `hasDiscount` (bool): Indica si el paquete tiene descuento
  - `originalPrice` (double?): Precio original antes del descuento
  - `discountPercentage` (int?): Porcentaje de descuento (ej: 20 para 20%)
  - `isNew` (bool): Marca paquetes recientes
  - `isPopular` (bool): Marca paquetes populares
  - `hasLimitedSeats` (bool): Indica disponibilidad limitada
  - `availableSeats` (int?): Número de plazas disponibles

- **Iconos de Servicios Mejorados**:
  - Chips visuales con bordes coloreados
  - Iconos representativos: ✈️ Vuelos, 🏨 Hotel 5★, 🎯 Tours, 🍽️ Comidas
  - Colores corporativos (#072A47 azul, #FFDC00 amarillo)
  - Layout responsive con wrapping automático

- **Botones de Acción Dual**:
  - Botón "Ver Detalles": Outlined button con icono de información
  - Botón "Reservar": Elevated button destacado con icono de check
  - Ambos botones con igual ancho en layout responsivo
  - Callbacks configurables para cada acción

- **Efectos Hover Avanzados**:
  - Elevación de card de 4 a 12 cuando hace hover
  - Traslación vertical de -8px con animación suave
  - Duración de animación: 300ms con curva ease
  - MouseRegion para detectar hover en web

- **Mejoras Visuales**:
  - Fondo de card en gris claro (#F5F5F5) para mejor contraste
  - Bordes redondeados de 16px para diseño moderno
  - Imagen de altura fija 200px con bordes superiores redondeados
  - Espaciado consistente y jerarquía visual mejorada
  - Descripción limitada a 2 líneas con ellipsis
  - Título limitado a 2 líneas para mantener altura consistente

### 🎨 Esquema de Colores

- **Precio tachado**: Rojo (`Colors.red`) con línea roja de 2px de grosor
- **Precio actual**: Verde (`Colors.green`) - SIEMPRE verde, con o sin descuento
- **Fondo de card**: Gris claro (`#F5F5F5`)
- **Badge OFERTA**: Rojo
- **Badge NUEVO**: Azul oscuro (`#072A47`)
- **Badge POPULAR**: Amarillo (`#FFDC00`)
- **Badge ÚLTIMAS PLAZAS**: Naranja

### 📊 Datos de Ejemplo Actualizados

- **Paris**: 20% descuento ($1200 antes $1500), Popular
- **Rome**: Nuevo paquete, Últimas 3 plazas
- **Kyoto**: Popular badge
- **Bangkok**: 20% descuento ($712 antes $890), Últimas 5 plazas
- **New York**: Nuevo paquete
- **Rio**: 20% descuento ($2560 antes $3200)
- **Kenya Safari**: Popular, Últimas 2 plazas
- **Venice**: Popular badge

### 🔧 Mejoras Técnicas

- Conversión de StatelessWidget a StatefulWidget para manejar hover state
- Uso de SingleTickerProviderStateMixin para animaciones
- AnimatedContainer para transiciones suaves
- Mejor organización en métodos privados (_buildImageSection, _buildBadge, etc.)
- Props opcionales con valores por defecto para retrocompatibilidad

---

## [v0.7.0] - 2024-01-11

### ✨ Nuevas Características

#### 📊 Sistema de Ordenamiento de Paquetes

- **Enum de opciones de ordenamiento** (`PackageSortOption`):
  - `mostPopular`: Ordenar por popularidad (score de 0-100)
  - `priceLowToHigh`: Ordenar por precio ascendente
  - `priceHighToLow`: Ordenar por precio descendente
  - `duration`: Ordenar por duración (días)
  - `departureDate`: Ordenar por próximas salidas
  - Cada opción incluye label en español e icono representativo

- **Campos extendidos en PackageTravel**:
  - `popularityScore` (int): Métrica de popularidad del paquete (0-100)
  - `departureDate` (DateTime?): Fecha de próxima salida disponible
  - Valores predeterminados para retrocompatibilidad

- **Dropdown de ordenamiento responsive**:
  - Vista Desktop: Dropdown integrado en header junto a contador de paquetes
  - Vista Mobile: Dropdown con icono al inicio de la lista
  - Estilo consistente con el diseño del sistema de filtros
  - Iconos descriptivos para cada opción de orden

- **Lógica de ordenamiento**:
  - Método `_sortPackages()`: Aplica ordenamiento según opción seleccionada
  - Método `_updateSort()`: Actualiza vista al cambiar criterio de orden
  - Ordenamiento aplicado después de filtrado
  - Manejo especial de paquetes sin fecha de salida

- **Datos de ejemplo actualizados**:
  - 12 paquetes con scores de popularidad: 78-95
  - Fechas de salida distribuidas entre junio y diciembre 2024
  - Variedad de popularidad según destino y categoría

### 🔧 Mejoras Técnicas

- Lista de paquetes cambió de `const` a `final` para soportar DateTime
- Integración perfecta con sistema de filtros existente
- Performance optimizada: ordenamiento solo cuando cambia criterio o filtros

---

## [v0.6.0] - 2025-10-11

### ✨ Nuevas Características

#### 🔍 Sección Paquetes - Sistema de Filtros Avanzados

- **Integración completa en HomePage**:
  - Reemplazada `PopularDestinationsSection` con `FilterablePackagesSection`
  - Filtros visibles y funcionales en la página principal
  - Accesible desde el menú "Paquetes" en la navegación
  
- **Modelo de datos extendido** (`PackageTravel`):
  - Agregados campos para filtrado: `priceValue`, `continent`, `country`, `durationDays`, `category`, `services`
  - Compatibilidad con filtros complejos manteniendo la estructura original

- **Modelo de filtros** (`PackageFilters`):
  - Gestión centralizada de criterios de filtrado
  - Métodos `copyWith()` y `reset()` para manipulación inmutable
  - Propiedad `hasActiveFilters` para detectar filtros activos

- **Widget de filtros avanzados** (`PackageFiltersWidget`):
  - **Filtro por Precio**: 
    - Slider de rango con valores desde $500 a $5000
    - 45 divisiones para precisión en la selección
    - Visualización en tiempo real de los valores seleccionados
  
  - **Filtro por Destino**:
    - Dropdown de continentes (Europa, Asia, América, África, Oceanía)
    - Dropdown dinámico de países según continente seleccionado
    - Mapeo de países por continente predefinido
  
  - **Filtro por Duración**:
    - Opciones: 3-5 días, 6-8 días, 9+ días
    - Dropdown simple y claro
  
  - **Filtro por Categoría**:
    - Checkboxes interactivos: Aventura, Romántico, Familiar, Lujo
    - Selección múltiple mediante `FilterChip`
    - Estilo visual distintivo con colores corporativos
  
  - **Filtro por Servicios**:
    - Checkboxes con iconos: Vuelos, Hotel 5★, Tours Guiados, Comidas Incluidas
    - Iconografía intuitiva para cada servicio
    - Selección múltiple de servicios requeridos

- **Funcionalidades del sistema de filtros**:
  - **Botón "Clear All"**: Limpia todos los filtros activos
  - **Botón "Apply Filters"**: Aplica los filtros seleccionados
  - **Contador de resultados**: Muestra cantidad de paquetes filtrados
  - **Botón toggle**: Mostrar/ocultar panel de filtros en desktop
  
- **Sección de paquetes filtrable** (`FilterablePackagesSection`):
  - Integración completa del sistema de filtros
  - Lógica de filtrado en tiempo real
  - **Diseño responsivo**:
    - Desktop: Filtros en sidebar lateral (320px de ancho)
    - Tablet/Mobile: Filtros como sección expandible superior
  - **Grid adaptativo**:
    - Desktop: 3 columnas
    - Tablet: 2 columnas
    - Mobile: 1 columna
  
- **Mensaje de "no hay resultados"**:
  - Icono visual de búsqueda vacía
  - Mensaje amigable al usuario
  - Botón para resetear filtros rápidamente

- **Base de datos de ejemplo ampliada** (`SamplePackages`):
  - 12 paquetes de viaje diversos
  - Cobertura de 5 continentes
  - 4 categorías diferentes (Aventura, Romántico, Familiar, Lujo)
  - Rango de precios de $890 a $3500
  - Duraciones de 4 a 12 días
  - Métodos helper para filtrado por continente, categoría y precio

### 🔧 Mejoras Técnicas
- Arquitectura de filtrado modular y reutilizable
- Estado de filtros manejado de forma inmutable
- Separación de responsabilidades: modelo, vista, lógica
- Optimización de renderizado con `GridView.builder`
- Widgets stateful para manejo eficiente de estado local

### 🎨 Mejoras de UI/UX
- Diseño de filtros con estilo material moderno
- Uso de `FilterChip` para selecciones múltiples
- Iconografía consistente en todos los filtros
- Feedback visual inmediato al cambiar filtros
- Diseño responsivo que se adapta a cualquier tamaño de pantalla
- Colores corporativos (#072A47, #FFDC00) en toda la interfaz

---

## [v0.5.0] - 2025-10-11

### ✨ Nuevas Características

#### 📊 Hero Section - Indicadores y Estadísticas
- **Widget de estadísticas animadas** (`StatsIndicator`):
  - **Tres métricas principales**:
    - 500+ Viajeros Felices (Happy Travelers)
    - 50+ Destinos Disponibles (Destinations)
    - 10 Años de Experiencia (Years Experience)
  
- **Características del widget**:
  - **Animación de contador progresivo**: Los números se animan desde 0 hasta su valor objetivo en 2 segundos
  - **Iconos representativos** para cada estadística:
    - `Icons.person_outline` para viajeros
    - `Icons.location_on_outlined` para destinos
    - `Icons.workspace_premium_outlined` para años de experiencia
  - **Diseño responsivo**:
    - Layout horizontal en desktop con divisores verticales
    - Layout vertical en móvil para mejor legibilidad
  - **Efectos visuales**:
    - Iconos con fondo circular y borde amarillo (#FFDC00)
    - Contenedor con fondo semi-transparente y borde sutil
    - Sombras para profundidad
    - Animación fade-in y slide-up al aparecer
  
- **Integración en Hero Section**:
  - Reemplaza el contador individual de paquetes
  - Posicionado entre el texto animado y los botones CTA
  - Mantiene la estética coherente con el diseño existente

### 🔧 Mejoras Técnicas
- Creado componente reutilizable `StatsIndicator` en `/presentation/widgets/components/`
- Implementación de animaciones personalizadas con `TweenAnimationBuilder`
- Optimización de código removiendo variables y funciones obsoletas
- Responsive design con ajustes automáticos según tamaño de pantalla

---

## [v0.4.0] - 2025-10-11

### ✨ Nuevas Características

#### 🎯 Hero Section - Call-to-Action (CTA) Mejorado
- **Dos botones CTA principales**:
  - **Botón primario "Explore Destinations"**:
    - Diseño destacado con fondo amarillo corporativo (#FFDC00)
    - Icono de explorar animado
    - Tamaño más grande (40px horizontal, 24px vertical padding)
    - Tipografía bold de 18px con espaciado de letras
  - **Botón secundario "Talk to Advisor"**:
    - Diseño outline con fondo semi-transparente
    - Integración directa con WhatsApp Business
    - Icono de chat incluido
    - Estilo complementario al botón primario

- **Efectos interactivos implementados**:
  - **Efecto hover** con elevación dinámica (8 → 12)
  - **Ripple effect** nativo de Material Design al hacer click
  - **Cambio de elevación** al presionar (12 → 4)
  - **Cambio de color de borde** en hover (blanco → amarillo)
  - **Cambio de opacidad de fondo** en estados hover/pressed
  - **Cursor pointer** en hover

- **Integración con WhatsApp**:
  - Función `_openWhatsApp()` que abre WhatsApp con mensaje predefinido
  - Número configurable: `51999888777`
  - Mensaje automático: "Hello! I would like information about travel packages."
  - Manejo de errores con SnackBar si WhatsApp no está disponible
  - Apertura en aplicación externa (`LaunchMode.externalApplication`)

- **Animación de bounce**:
  - Ambos botones comparten la animación de bounce del `AnimationController`
  - Movimiento vertical sincronizado
  - Efecto visual atractivo sin ser invasivo

**Archivos modificados:**
- `lib/presentation/widgets/sections/hero_section.dart`
- `pubspec.yaml` (agregada dependencia `url_launcher: ^6.3.1`)

**Dependencias nuevas:**
- `url_launcher: ^6.3.1` - Para abrir WhatsApp y enlaces externos

**Características técnicas:**
- `MouseRegion` para cursor personalizado
- `WidgetStateProperty` para estados hover/pressed
- `ElevatedButton.icon` y `OutlinedButton.icon` con iconos
- `copyWith()` para personalización avanzada de estilos
- Navegación responsive entre botones (20px spacing)

---

## [v0.3.0] - 2025-10-11

### ✨ Nuevas Características

#### 🎬 Hero Section - Texto Dinámico y Animaciones
- **Efecto TypeWriter** con texto rotativo para destinos destacados:
  - "Discover Paris"
  - "Explore Rome"
  - "Experience Kyoto"
  - "Visit New York"
  - "Enjoy Bali"
- **Animaciones implementadas**:
  - Fade-in con slide-in para el título principal
  - Efecto typewriter para texto rotativo de destinos
  - Animación de bounce continuo para el botón CTA
  - Contador animado de paquetes disponibles (0 → 50+)
- **Mejoras visuales**:
  - Contador de paquetes con estilo destacado
  - Icono de viaje en el contador
  - Texto rotativo con color amarillo corporativo (#FFDC00)
  - Botón con icono de flecha añadido

**Archivos modificados:**
- `lib/presentation/widgets/sections/hero_section.dart`
- `pubspec.yaml` (agregada dependencia `animated_text_kit: ^4.2.2`)

**Dependencias nuevas:**
- `animated_text_kit: ^4.2.2` - Para efectos de texto animado

**Características técnicas:**
- Uso de `SingleTickerProviderStateMixin` para animaciones
- `AnimationController` para control de bounce del botón
- `TweenAnimationBuilder` para fade-in effects
- `AnimatedTextKit` con `TypewriterAnimatedText`
- Contador programático con incremento gradual

---

## [v0.2.0] - 2025-10-11

### ✨ Nuevas Características

#### 🏠 Hero Section - Slider de Imágenes
- **Implementado carousel de imágenes de fondo** con 6 imágenes rotativas
- **Auto-play automático** cada 5 segundos con transiciones suaves
- **Controles de navegación**:
  - Flechas izquierda/derecha para navegación manual
  - Indicadores de puntos (dots) para saltar entre imágenes
  - Pausa automática al interactuar con los controles
- **Mejoras visuales**:
  - Overlay oscuro para mejorar legibilidad del texto
  - Transiciones con curva `easeInOut` de 1000ms
  - Sombras en texto para mejor contraste
  - Botón CTA mejorado con colores corporativos

**Archivos modificados:**
- `lib/presentation/widgets/sections/hero_section.dart`
- `pubspec.yaml` (agregada dependencia `carousel_slider: ^4.2.1`)

**Assets utilizados:**
- `assets/images/background-0.jpg`
- `assets/images/background-1.jpg`
- `assets/images/background-2.jpg`
- `assets/images/background-3.jpg`
- `assets/images/background-4.jpg`
- `assets/images/background-5.jpg`

---

## [v0.1.0] - 2025-10-11

### 🎉 Versión Inicial

#### Estructura del Proyecto
- Arquitectura basada en Clean Architecture
- Separación en capas: Presentation, BLoC, Data
- Estructura de carpetas organizada y escalable

#### Páginas Implementadas
- **HomePage**: Página principal con navegación
- **HeroSection**: Sección hero inicial (versión básica)
- **PopularDestinationsSection**: Destinos populares
- **OurPackagesSection**: Catálogo de paquetes
- **BookingSection**: Sección de reservas (placeholder)
- **ContactFooterSection**: Pie de página con contacto

#### Componentes
- **TravelPackageCard**: Tarjeta de paquete de viaje con:
  - Imagen del destino
  - Título y precio
  - Ubicación y descripción
  - Duración del viaje
  - Servicios incluidos (vuelos, hotel, tours)
  - Botón "Book Now"

#### Modelos de Datos
- **PackageTravel**: Modelo para paquetes turísticos

#### Tema y Diseño
- Paleta de colores corporativa (#072A47, #FFDC00)
- Fuente personalizada: LetyTravelsFont
- AppBar con navegación entre secciones
- Scroll suave entre secciones
- Efectos hover en botones

#### Destinos Iniciales
- Enchanting Paris ($1,500)
- Ancient Rome Adventure ($1,350)
- Mystical Kyoto Journey ($1,800)

---

## 📋 Próximas Mejoras Planeadas

### Alta Prioridad 🔴
- [ ] Barra de búsqueda rápida de paquetes
- [ ] Sistema de filtros avanzados
- [ ] Modal de detalles de paquete
- [ ] WhatsApp integration flotante
- [ ] Formulario de reserva completo
- [ ] Scroll indicator animado

### Media Prioridad 🟡
- [ ] Sistema de favoritos
- [ ] Testimonios de clientes
- [ ] FAQ section
- [ ] Google Maps integration
- [ ] Newsletter signup

### Baja Prioridad 🟢
- [ ] Sistema de autenticación
- [ ] Chat en vivo
- [ ] Pasarela de pago
- [ ] PWA completa
- [ ] Multi-idioma

### ✅ Completadas
- [x] Slider de imágenes de fondo en Hero Section
- [x] Texto dinámico con TypeWriter effect
- [x] Animaciones de fade-in y bounce
- [x] Contador de paquetes disponibles
- [x] Botones CTA mejorados con efectos hover
- [x] Integración con WhatsApp Business

---

## 🔗 Referencias

- [README Principal](./README.md)
- [Guía de Despliegue](./README_TASKS.md)
- [Plan de Funcionalidades](./README_TASKS_FEATURES.md)

---

<div align="center">

**ByLetyTravels** - Tu próxima aventura comienza aquí ✈️

© 2025 ByLetyTravels

</div>
