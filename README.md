# ✈️ ByLetyTravels - Agencia de Viajes

<div align="center">

![ByLetyTravels](https://img.shields.io/badge/ByLetyTravels-Travel%20Agency-blue?style=for-the-badge)
![Flutter](https://img.shields.io/badge/Flutter-3.7.2-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-Language-0175C2?style=for-the-badge&logo=dart)

**Tu próxima aventura comienza aquí** 🌍

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

## 🛠️ Tecnologías Utilizadas

### Frontend
- **Flutter 3.7.2**: Framework multiplataforma
- **Dart**: Lenguaje de programación
- **Material Design 3**: Sistema de diseño

### Arquitectura
```
lib/
├── main.dart                           # Punto de entrada de la app
├── data/
│   ├── models/                         # Modelos de datos
│   │   └── package_travel.dart        # Modelo de paquete de viaje
│   ├── providers/                      # Proveedores de datos
│   └── repositories/                   # Repositorios
├── bloc/                               # Gestión de estado con BLoC
├── presentation/
│   ├── pages/
│   │   └── home_page.dart             # Página principal
│   └── widgets/
│       ├── travel_package_card.dart   # Card de paquete
│       └── sections/                   # Secciones de la página
│           ├── hero_section.dart
│           ├── popular_destinations_section.dart
│           ├── our_packages_section.dart
│           ├── booking_section.dart
│           └── contact_footer_section.dart
```

### Dependencias Principales
```yaml
dependencies:
  flutter: sdk
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^5.0.0
```

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

- 📧 **Email**: contact@letytravels.com
- 💬 **WhatsApp**: [Contactar ahora](#) *(Configura tu número)*
- 🌐 **Website**: [byletytravels.com](#)

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
