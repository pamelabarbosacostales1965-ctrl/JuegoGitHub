# 🎬 CineApp - Sistema de Reserva de Asientos

Este proyecto es una aplicación móvil desarrollada en **Flutter** que simula el proceso de selección y compra de asientos para una sala de cine. El objetivo es demostrar el manejo de estados complejos, navegación entre pantallas y el uso de buenas prácticas de desarrollo colaborativo.

---

## 👥 Integrantes del Equipo (Grupo X)
* **Pamela Barbosa** - *Lógica de Negocio y Modelado de Datos*
* **Estefania Solórzano** - *Interfaz de Usuario y Filtros de Sala*
* **Giuliana Auqui** - *Pantalla de Resumen, Confirmación y Documentación*
---

## 🚀 Funcionalidades Principales

### 1. Gestión de Sala Interactiva
* Visualización dinámica de asientos mediante una cuadrícula (`GridView`).
* **Estados de los asientos:**
    * 🟦 **Disponible:** Asiento libre para selección.
    * 🟩 **Seleccionado:** Selección temporal del usuario.
    * ⬜ **Reservado:** Asientos ocupados por el sistema (no seleccionables).
    * 🟥 **Comprado:** Estado final tras confirmar la transacción.

### 2. Lógica de Negocio (Riverpod)
* Implementación de `StateNotifierProvider` para centralizar el estado de la sala.
* Filtrado en tiempo real por tipo de asiento (**VIP** vs **Normal**).
* Cálculo automático del precio total basado en la categoría del asiento.

### 3. Flujo de Compra (Pantalla de Resumen)
* Desglose detallado de los asientos elegidos.
* Botón de confirmación que bloquea los asientos y limpia la selección actual.
* Notificaciones visuales mediante `SnackBar` para confirmar el éxito de la operación.

---

## 🛠️ Tecnologías y Herramientas
* **Lenguaje:** Dart 3.x
* **Framework:** Flutter 3.x
* **Arquitectura:** Clean Architecture (Capas de Presentación, Dominio y Data).
* **Estado:** Riverpod.
* **Control de Versiones:** Git & GitHub (Uso de ramas `feature/`).

---
## ⚙️ Instalación y Uso
* Para ejecutar correctamente la aplicación, asegúrate de cumplir con los siguientes requisitos y pasos:
*🔹 Requisitos previos
*-Tener instalado Flutter (versión 3.x o superior)
*-Tener instalado Visual Studio Code con las extensiones:
*-Flutter
*-Dart
*-Tener configurado un emulador o dispositivo físico
---
## Pasos para ejecutar el proyecto
* 1.Clonar el repositorio
* git clone https://github.com/pamelabarbosacostales1965-ctrl/JuegoGitHub.git
* 2.Abrir el proyecto en Visual Studio Code
* Instalar dependencias
* 3.En la terminal integrada de VS Code, ejecutar:
* flutter pub get
* 4. Ejecutar la aplicación
* flutter run
---
##Notas importantes
*Asegúrate de que Flutter esté correctamente configurado ejecutando:
*flutter doctor
*-Si es la primera vez ejecutando el proyecto, puede tardar unos minutos en descargar dependencias.
*-Verifica que tengas un dispositivo/emulador activo antes de ejecutar la app.
---
## 📂 Estructura del Código

```text
lib/
├── models/
│   └── asiento.dart          # Definición de clases y estados (enums).
├── providers/
│   └── cine_provider.dart    # Notifier y lógica de compra.
├── presentacion/
│   ├── pagina_principal.dart   # UI de la sala y filtros.
│   └── pantalla_resumen.dart   # UI de confirmación de pago.
└── main.dart                 # Configuración de rutas y Riverpod Scope.

