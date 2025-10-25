# ✈️ ByLetyTravels - Agencia de Viajes

<div align="center">

![ByLetyTravels](https://img.shields.io/badge/ByLetyTravels-Travel%20Agency-blue?style=for-the-badge)
![Flutter](https://img.shields.io/badge/Flutter-3.7.2-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-Language-0175C2?style=for-the-badge&logo=dart)

**Tu próxima aventura comienza aquí** 🌍

🌐 **[Ver Sitio Web en Vivo](https://web-letytravels.web.app/)** 🌐

[Características](#-características) • [Demo](#-demo) • [Instalación](#-instalación) • [Contacto](#-contacto)

</div>

---

## 📋 Descripción

**ByLetyTravels** es una plataforma web moderna desarrollada en Flutter para una agencia de viajes que ofrece paquetes turísticos exclusivos a destinos increíbles alrededor del mundo. Los usuarios pueden explorar diferentes destinos, conocer los detalles de cada paquete y contactar directamente con nuestros asesores de viaje mediante WhatsApp o Email para resolver consultas o reservar su próximo viaje.

### 🎯 Objetivo

Proporcionar una experiencia de usuario excepcional para que los viajeros puedan: 
- ✅ Explorar destinos populares y paquetes turísticos
- ✅ Conocer todos los detalles de cada paquete (vuelos, hoteles, tours guiados)
- ✅ Contactar fácilmente con asesores de viaje
- ✅ Reservar sus vacaciones soñadas de forma rápida y segura

---

## 🏗️ Arquitectura del Proyecto

### 📐 Patrón de Arquitectura

Este proyecto utiliza una **arquitectura limpia y escalable** basada en el patrón **Clean Architecture** adaptado para Flutter, separando las responsabilidades en capas bien definidas:

```
┌─────────────────────────────────────────────┐
│         PRESENTATION LAYER                  │
│  (UI, Widgets, Pages, State Management)     │
├─────────────────────────────────────────────┤
│         BUSINESS LOGIC LAYER                │
│        (BLoC, Use Cases, Events)            │
├─────────────────────────────────────────────┤
│           DATA LAYER                        │
│   (Models, Repositories, Data Sources)      │
├─────────────────────────────────────────────┤
│         EXTERNAL SERVICES                   │
│  (APIs, Firebase, Third-party Services)     │
└─────────────────────────────────────────────┘
```

### 🎯 Principios de Diseño

- **Separation of Concerns**: Cada capa tiene una responsabilidad específica
- **Dependency Injection**: Facilita testing y mantenibilidad
- **Single Responsibility**: Cada clase/widget tiene una única responsabilidad
- **DRY (Don't Repeat Yourself)**: Código reutilizable y modular
- **SOLID Principles**: Aplicados en toda la estructura del código

### 📁 Estructura de Carpetas Detallada

```
web-letytravels/
│
├── lib/
│   ├── main.dart                                 # Punto de entrada de la aplicación
│   │
│   ├── core/                                     # Núcleo de la aplicación
│   │   ├── constants/                            # Constantes globales
│   │   │   ├── app_colors.dart                  # Paleta de colores
│   │   │   ├── app_strings.dart                 # Textos y copys
│   │   │   └── app_routes.dart                  # Rutas de navegación
│   │   ├── utils/                                # Utilidades y helpers
│   │   │   ├── validators.dart                  # Validaciones de formularios
│   │   │   ├── date_formatter.dart              # Formato de fechas
│   │   │   └── currency_formatter.dart          # Formato de moneda
│   │   └── theme/                                # Temas de la app
│   │       ├── app_theme.dart                   # Tema principal
│   │       └── text_styles.dart                 # Estilos de texto
│   │
│   ├── data/                                     # CAPA DE DATOS
│   │   ├── models/                               # Modelos de datos
│   │   │   ├── package_travel.dart              # Modelo de paquete turístico
│   │   │   ├── booking.dart                     # Modelo de reserva
│   │   │   ├── user.dart                        # Modelo de usuario
│   │   │   └── review.dart                      # Modelo de reseña
│   │   ├── repositories/                         # Implementación de repositorios
│   │   │   ├── package_repository.dart          # Repositorio de paquetes
│   │   │   ├── booking_repository.dart          # Repositorio de reservas
│   │   │   └── user_repository.dart             # Repositorio de usuarios
│   │   └── providers/                            # Proveedores de datos
│   │       ├── firebase_provider.dart           # Proveedor de Firebase
│   │       ├── api_provider.dart                # Proveedor de API REST
│   │       └── local_storage_provider.dart      # Almacenamiento local
│   │
│   ├── domain/                                   # CAPA DE DOMINIO (Futura)
│   │   ├── entities/                             # Entidades del negocio
│   │   ├── repositories/                         # Interfaces de repositorios
│   │   └── usecases/                             # Casos de uso del negocio
│   │
│   ├── bloc/                                     # GESTIÓN DE ESTADO (BLoC)
│   │   ├── packages/                             # BLoC de paquetes
│   │   │   ├── packages_bloc.dart
│   │   │   ├── packages_event.dart
│   │   │   └── packages_state.dart
│   │   ├── booking/                              # BLoC de reservas
│   │   │   ├── booking_bloc.dart
│   │   │   ├── booking_event.dart
│   │   │   └── booking_state.dart
│   │   └── auth/                                 # BLoC de autenticación
│   │       ├── auth_bloc.dart
│   │       ├── auth_event.dart
│   │       └── auth_state.dart
│   │
│   └── presentation/                             # CAPA DE PRESENTACIÓN
│       ├── pages/                                # Páginas principales
│       │   ├── home_page.dart                   # Página de inicio
│       │   ├── packages_page.dart               # Página de paquetes
│       │   ├── package_detail_page.dart         # Detalle de paquete
│       │   ├── booking_page.dart                # Página de reserva
│       │   └── profile_page.dart                # Perfil de usuario
│       │
│       └── widgets/                              # Widgets reutilizables
│           ├── travel_package_card.dart         # Card de paquete
│           ├── custom_button.dart               # Botón personalizado
│           ├── custom_text_field.dart           # Campo de texto
│           ├── loading_indicator.dart           # Indicador de carga
│           │
│           └── sections/                         # Secciones de páginas
│               ├── hero_section.dart            # Sección hero
│               ├── popular_destinations_section.dart  # Destinos populares
│               ├── our_packages_section.dart    # Nuestros paquetes
│               ├── booking_section.dart         # Sección de reserva
│               └── contact_footer_section.dart  # Pie de página/contacto
│
├── assets/                                       # Recursos estáticos
│   ├── images/                                   # Imágenes
│   │   ├── background.jpg                       # Fondo hero section
│   │   ├── icons8-airport-50.png               # Logo de la marca
│   │   └── destinations/                        # Imágenes de destinos
│   ├── fonts/                                    # Fuentes personalizadas
│   │   └── font_regular.ttf                    # LetyTravelsFont
│   └── icons/                                    # Iconos personalizados
│
├── web/                                          # Configuración web
│   ├── index.html                               # HTML principal
│   ├── manifest.json                            # PWA manifest
│   └── icons/                                    # Iconos PWA
│
├── test/                                         # Tests unitarios
│   ├── widget_test.dart                         # Tests de widgets
│   └── unit/                                     # Tests unitarios
│
├── pubspec.yaml                                  # Dependencias del proyecto
├── analysis_options.yaml                         # Configuración de análisis
└── README.md                                     # Este archivo
```

### 🔄 Flujo de Datos

```
User Interaction (UI)
        ↓
  Presentation Layer (Widgets/Pages)
        ↓
  BLoC (Business Logic Component)
        ↓
  Repository (Abstracción de datos)
        ↓
  Data Provider (Firebase, API, Local)
        ↓
  External Services
        ↓
  ← ← ← Response flows back ← ← ←
```

### 🧩 Componentes Principales

#### 1. **Presentation Layer** (Capa de Presentación)
- **Responsabilidad**: Interfaz de usuario y visualización
- **Componentes**: Widgets, Pages, Sections
- **Tecnología**: Flutter Widgets, Material Design 3

#### 2. **BLoC Layer** (Capa de Lógica de Negocio)
- **Responsabilidad**: Gestión de estado y lógica de negocio
- **Patrón**: BLoC (Business Logic Component)
- **Tecnología**: flutter_bloc / Provider (futuro)

#### 3. **Data Layer** (Capa de Datos)
- **Responsabilidad**: Acceso y persistencia de datos
- **Componentes**: Models, Repositories, Providers
- **Tecnología**: Dart models, Repository pattern

#### 4. **Services Layer** (Capa de Servicios)
- **Responsabilidad**: Integración con servicios externos
- **Servicios**: Firebase, APIs, WhatsApp, Email
- **Tecnología**: HTTP, Firebase SDK, Third-party APIs

---

## 🛠️ Stack Tecnológico

### Frontend Framework
| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| **Flutter** | 3.7.2+ | Framework de desarrollo multiplataforma |
| **Dart** | 3.0+ | Lenguaje de programación |
| **Material Design 3** | Latest | Sistema de diseño de UI |

### Gestión de Estado
| Tecnología | Estado | Propósito |
|------------|--------|-----------|
| **flutter_bloc** | 🔄 Planeado | Gestión de estado reactiva con BLoC pattern |
| **Provider** | 🔄 Alternativa | Gestión de estado ligera |
| **GetX** | 🔄 Evaluando | Estado, navegación y dependencias |

### Backend & Servicios
| Servicio | Propósito | Estado |
|----------|-----------|--------|
| **Firebase** | Backend as a Service | 🔄 En implementación |
| └─ **Firestore** | Base de datos NoSQL | Para paquetes y reservas |
| └─ **Authentication** | Autenticación de usuarios | Login/registro |
| └─ **Storage** | Almacenamiento de imágenes | Fotos de destinos |
| └─ **Hosting** | Hosting de la web | Deployment |
| └─ **Cloud Functions** | Funciones serverless | Lógica backend |

### Integraciones Externas
| Servicio | Propósito | Estado |
|----------|-----------|--------|
| **WhatsApp Business API** | Chat con asesores | 🔄 Planeado |
| **SendGrid / Mailgun** | Envío de emails | 🔄 Planeado |
| **Stripe** | Pagos online | 🔄 Planeado |
| **PayPal** | Pagos alternativos | 🔄 Planeado |
| **Google Maps API** | Mapas de destinos | 🔄 Planeado |
| **Google Analytics** | Analítica web | 🔄 Planeado |

### Librerías de UI/UX
```yaml
# Planeadas para implementar
dependencies:
  # Animaciones
  animate_do: ^3.1.2              # Animaciones predefinidas
  lottie: ^2.7.0                  # Animaciones Lottie
  shimmer: ^3.0.0                 # Loading skeletons
  
  # UI Components
  carousel_slider: ^4.2.1         # Carousels de imágenes
  flutter_rating_bar: ^4.0.1      # Barras de rating
  cached_network_image: ^3.3.0    # Caché de imágenes
  
  # Forms & Validation
  flutter_form_builder: ^9.1.1    # Constructor de formularios
  intl: ^0.18.1                   # Internacionalización
  
  # Comunicación
  url_launcher: ^6.2.1            # Abrir URLs (WhatsApp, Email)
  share_plus: ^7.2.1              # Compartir contenido
  
  # Utilidades
  connectivity_plus: ^5.0.2       # Estado de conexión
  dio: ^5.4.0                     # Cliente HTTP
```

### Herramientas de Desarrollo
| Herramienta | Propósito |
|-------------|-----------|
| **VS Code** | Editor de código principal |
| **Flutter DevTools** | Debugging y profiling |
| **Firebase Console** | Gestión de backend |
| **Git & GitHub** | Control de versiones |
| **Flutter Lints** | Análisis estático de código |

### Testing
```yaml
# Planeado
dev_dependencies:
  flutter_test: sdk
  mockito: ^5.4.4                 # Mocking para tests
  bloc_test: ^9.1.5               # Testing de BLoCs
  integration_test: sdk           # Tests de integración
```

### DevOps & CI/CD
| Servicio | Propósito | Estado |
|----------|-----------|--------|
| **Firebase Hosting** | Hosting web | ✅ Implementado |
| **GitHub Actions** | CI/CD pipeline | 🔄 Planeado |
| **Codemagic** | CI/CD para Flutter | 🔄 Alternativa |

---

## 🎨 Convenciones de Código

### Estructura de Archivos
- **snake_case** para nombres de archivos: `package_travel.dart`
- **PascalCase** para nombres de clases: `PackageTravel`
- **camelCase** para variables y métodos: `getUserBookings()`
- **SCREAMING_SNAKE_CASE** para constantes: `MAX_PASSENGERS`

### Organización de Imports
```dart
// 1. Imports de Dart
import 'dart:async';

// 2. Imports de Flutter
import 'package:flutter/material.dart';

// 3. Imports de paquetes externos
import 'package:flutter_bloc/flutter_bloc.dart';

// 4. Imports del proyecto
import 'package:by_lety_travels/data/models/package_travel.dart';
```

### Comentarios y Documentación
```dart
/// Modelo que representa un paquete de viaje completo.
/// 
/// Incluye información sobre el destino, precio, servicios
/// incluidos y detalles del itinerario.
class PackageTravel {
  // Implementación...
}
```

---

## ✨ Características

### 🏠 **Página Principal Completa**
- **Sección Hero**: Banner atractivo con llamada a la acción
- **Destinos Populares**: Galería de los destinos más solicitados
- **Nuestros Paquetes**: Catálogo completo de paquetes turísticos
- **Sección de Reservas**: Facilita el proceso de booking
- **Contacto y Footer**: Información de contacto y redes sociales

### 🎨 **Diseño Profesional**
- Interfaz moderna y responsive
- Navegación intuitiva con scroll suave entre secciones
- Efectos hover en botones de navegación
- Paleta de colores corporativa (#072A47, #FFDC00)
- Tipografía personalizada "LetyTravelsFont"

### 📦 **Paquetes de Viaje**
Cada paquete incluye información detallada:
- 🏷️ **Título y precio** del paquete
- 📍 **Ubicación** del destino
- 📝 **Descripción** completa de la experiencia
- ⏰ **Duración** del viaje (días/noches)
- ✈️ **Vuelos incluidos** (si/no)
- 🏨 **Categoría del hotel** (3, 4 o 5 estrellas)
- 👥 **Tours guiados** incluidos
- 🖼️ **Imágenes** de alta calidad de cada destino

### 📱 **Contacto Directo**
- **WhatsApp**: Comunicación instantánea con asesores
- **Email**: Consultas detalladas por correo electrónico
- **Botones de acción**: "Reservar Ahora" en cada sección

### 🌐 **Navegación**
- Menú principal con 4 secciones:
  - 🏠 **Inicio** (Hero Section)
  - 📦 **Paquetes** (Destinos Populares)
  - 🎫 **Reservar** (Booking Section)
  - 📞 **Contacto** (Footer)
- Scroll automático a cada sección
- Botón destacado "¡Reservar Ahora!" con gradiente

---

## 🗺️ Destinos Destacados

### 🇫🇷 **Enchanting Paris**
- **Precio**: $1,500
- **Duración**: 5 Días / 4 Noches
- **Hotel**: 4 Estrellas ⭐⭐⭐⭐
- **Incluye**: Vuelos ✈️ | Tours Guiados 👥
- Experimenta la ciudad de las luces, monumentos icónicos y ambiente romántico

### 🇮🇹 **Ancient Rome Adventure**
- **Precio**: $1,350
- **Duración**: 6 Días / 5 Noches
- **Hotel**: 4 Estrellas ⭐⭐⭐⭐
- **Incluye**: Vuelos ✈️ | Tours Guiados 👥
- Explora ruinas históricas, arte magnífico y deliciosa gastronomía italiana

### 🇯🇵 **Mystical Kyoto Journey**
- **Precio**: $1,800
- **Duración**: 7 Días / 6 Noches
- **Hotel**: 5 Estrellas ⭐⭐⭐⭐⭐
- **Incluye**: Tours Guiados 👥
- Descubre templos serenos, hermosos jardines y cultura tradicional japonesa

---

## � Tecnologías Actuales

### Stack Implementado
- **Flutter 3.7.2**: Framework multiplataforma
- **Dart**: Lenguaje de programación
- **Material Design 3**: Sistema de diseño

### Dependencias en Uso
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

> 💡 **Nota**: Consulta la sección [Stack Tecnológico](#-stack-tecnológico) arriba para ver todas las tecnologías planeadas e integraciones futuras.

---

## 📥 Instalación

### Prerrequisitos
- Flutter SDK 3.7.2 o superior
- Dart SDK
- Editor de código (VS Code, Android Studio, etc.)

### Pasos de instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/tuusuario/web-letytravels.git
cd web-letytravels
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Ejecutar la aplicación**

Para Web:
```bash
flutter run -d chrome
```

Para Windows:
```bash
flutter run -d windows
```

Para todas las plataformas:
```bash
flutter run
```

4. **Generar build de producción**

Para Web:
```bash
flutter build web
```

Para Windows:
```bash
flutter build windows
```

---

## 🚀 Demo

### Screenshots

#### 🏠 Página Principal
- Hero Section con imagen de fondo
- Navegación sticky con efectos hover
- Diseño responsive y moderno

#### 📦 Destinos Populares
- Grid de 3 columnas con paquetes
- Cards con imágenes, descripciones y precios
- Botón "Book Now" en cada tarjeta

#### 🎫 Sección de Reservas
- Formulario de contacto
- Botones de WhatsApp y Email
- Llamadas a la acción destacadas

---

## 📞 Contacto

### ¿Listo para tu próxima aventura?

Nuestros asesores de viaje están disponibles para ayudarte:

- 📧 **Email**: byletytravels.oficial@gmail.com
- 💬 **WhatsApp**: [Contactar ahora](#)
- 🌐 **Website**: [byletytravels.com](https://web-letytravels.web.app/)

---

## 📧 Configuración de EmailJS

Este proyecto utiliza **EmailJS** para el envío de correos electrónicos de confirmación. Consulta el archivo [`README_EMAIL_SETUP.md`](README_EMAIL_SETUP.md) para instrucciones detalladas.

### Templates Configurados

El sistema envía correos para dos tipos de notificaciones:

#### 1. **Reservas de Paquetes Turísticos**
- **Template Cliente**: Confirmación de reserva al cliente
- **Template Negocio**: Notificación interna de nueva reserva

#### 2. **Citas de Asesoría Personalizada**
- **Template Cliente**: Confirmación de cita agendada
- **Template Negocio**: Notificación de nueva cita

### Variables de EmailJS para Citas

**Para el template del cliente (`templateIdAppointmentClient`):**
```
{{to_email}}          - Email del cliente
{{to_name}}           - Nombre del cliente
{{appointment_id}}    - ID único de la cita
{{appointment_date}}  - Fecha formateada (ej: "26 de Enero de 2025")
{{appointment_time}}  - Hora (ej: "09:00 AM")
{{appointment_type}}  - Tipo (Presencial/Video Llamada/Teléfono)
{{client_name}}       - Nombre completo
{{client_email}}      - Email
{{client_phone}}      - Teléfono
{{notes}}             - Notas especiales
```

**Para el template del negocio (`templateIdAppointmentBusiness`):**
```
Las mismas variables anteriores + {{status}} (Estado de la cita)
```

### Configuración Rápida

1. **Crea los templates en EmailJS** con el HTML proporcionado
2. **Copia los Template IDs** generados
3. **Actualiza `lib/config/email_config.dart`**:
```dart
static const String templateIdAppointmentClient = 'template_TU_ID_AQUI';
static const String templateIdAppointmentBusiness = 'template_TU_ID_AQUI';
```

Ver documentación completa en [`README_EMAIL_SETUP.md`](README_EMAIL_SETUP.md)

---

## 🎨 Personalización

### Colores Corporativos
```dart
// Azul Oscuro Principal
Color(0xFF072A47)

// Amarillo/Dorado Acento
Color(0xFFFFDC00)

// Naranja Gradiente
Color(0xFFD97806)
```

### Fuentes
- **Familia**: LetyTravelsFont
- **Archivo**: `assets/fonts/font_regular.ttf`

### Assets
```
assets/
├── images/
│   ├── background.jpg              # Fondo del hero
│   └── icons8-airport-50.png      # Logo de la marca
├── fonts/
│   └── font_regular.ttf           # Fuente personalizada
└── icons/
```

---

## 📝 Estructura de Datos

### Modelo PackageTravel
```dart
class PackageTravel {
  final String title;           // Título del paquete
  final String price;           // Precio (ej: "$1,500")
  final String location;        // Ubicación (ej: "Paris, France")
  final String description;     // Descripción completa
  final String duration;        // Duración (ej: "5 Days / 4 Nights")
  final bool flightsIncluded;   // Vuelos incluidos
  final String hotelRating;     // Categoría del hotel
  final bool guidedTours;       // Tours guiados incluidos
  final String? imageUrl;       // URL de la imagen
}
```

---

## 🔄 Roadmap

### Próximas Características
- [ ] Integración real de WhatsApp Business API
- [ ] Sistema de reservas online completo
- [ ] Panel de administración para gestionar paquetes
- [ ] Integración con pasarelas de pago
- [ ] Sistema de autenticación de usuarios
- [ ] Historial de reservas
- [ ] Notificaciones por email
- [ ] Multi-idioma (ES/EN)
- [ ] Blog de viajes y destinos
- [ ] Sistema de reseñas y valoraciones

---

## 👥 Equipo

Desarrollado con ❤️ por el equipo de ByLetyTravels

---

## 📄 Licencia

Este proyecto es privado y pertenece a ByLetyTravels. Todos los derechos reservados © 2025.

---

## 🙏 Agradecimientos

- Flutter Team por el increíble framework
- Unsplash por las imágenes de destinos
- Icons8 por los iconos

---

<div align="center">

**¿Listo para despegar? ✈️**

[Explorar Paquetes](#) • [Contactar Asesor](#) • [Reservar Ahora](#)

© 2025 ByLetyTravels. Todos los derechos reservados.

</div>
