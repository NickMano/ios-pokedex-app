# 📱 Pokédex App

Una aplicación iOS moderna de Pokédex construida con SwiftUI que permite explorar y visualizar información detallada de Pokémon.

<img src="https://i.imgur.com/0uhOMA4.png" alt="Pokédex App Screenshot" />

## ✨ Características

- 🔍 Búsqueda y visualización de lista completa de Pokémon
- 📊 Información detallada de cada Pokémon (estadísticas, habilidades, tipos)
- 🎨 Interfaz moderna con SwiftUI
- 🖼️ Carga asíncrona de imágenes
- 📖 Vista "About" con datos de especies, entrenamiento y reproducción
- 🎨 Diseño adaptable con gradientes temáticos por tipo

## 🛠 Tecnologías

- **Swift 5.9+**
- **SwiftUI** - Framework UI declarativo
- **Async/Await** - Manejo moderno de concurrencia
- **Combine** - Reactive programming

## 📋 Requisitos

- **Xcode 15.0+** recomendado
- **iOS 15.0+** mínimo

## 📦 Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/NickMano/ios-pokedex-app.git
cd ios-pokedex-app
```

2. Abre el proyecto en Xcode:

```bash
open Pokedex.xcodeproj
```

3. Las dependencias de Swift Package Manager se resolverán automáticamente

4. Selecciona tu dispositivo o simulador y ejecuta ▶️

## 🏗 Arquitectura

El proyecto implementa **MVVM (Model-View-ViewModel)** para la capa de presentación y **Clean Architecture** para las capas de dominio y datos.

### Estructura de Capas

```
├── Presentation (MVVM)
│   ├── Screens
│   │   ├── Home
│   │   │   ├── View
│   │   │   ├── ViewModel
│   │   │   └── Components
│   │   ├── Detail
│   │   └── AboutView
│   ├── Commons/Components
│   └── Utils
├── Domain (Use Cases, Entities)
└── Data (Repositories, Network)
```

### Patrón MVVM

- **View**: SwiftUI views que observan el ViewModel
- **ViewModel**: Lógica de presentación y estado con `@Published` properties
- **Model**: Entidades del dominio

**Nota**: El proyecto está en proceso de migración desde MVI (Model-View-Intent) a MVVM. HomeView ya usa MVVM, otras vistas aún usan MVI.

## 📚 Dependencias

El proyecto utiliza **Swift Package Manager** para gestionar dependencias:

### Dependencias Propias

- **[PokedexDomain](https://github.com/NickMano/ios-pokedex-domain-layer)** - Capa de dominio con casos de uso, entidades y protocolos de repositorio
- **[PokedexData](https://github.com/NickMano/ios-pokedex-data-layer)** - Capa de datos con implementación de repositorios y networking
- **[SwiftUtils](https://github.com/NickMano/swift-utils)** - Extensiones y utilidades reutilizables

### Dependencias Externas

- **[SwiftLint](https://github.com/realm/SwiftLint)** - Herramienta para mantener buenas prácticas de código

## 🚀 API

Este proyecto consume la [PokéAPI](https://pokeapi.co/) para obtener información de Pokémon.

## 📝 Características Técnicas

- ✅ Arquitectura limpia y modular
- ✅ Inyección de dependencias
- ✅ Programación reactiva con Combine
- ✅ Concurrencia moderna con async/await
- ✅ Manejo de errores robusto
- ✅ Código organizado y escalable
- ✅ SwiftLint para consistencia de código

## 📄 Licencia

Este proyecto está bajo la licencia MIT.

## 👨‍💻 Autor

**Nicolas Manograsso** - [@NickMano](https://github.com/NickMano)

---

⭐️ Si te gusta este proyecto, ¡dale una estrella en GitHub!
