# AR 3D Viewer

Una aplicación Flutter para Android que permite visualizar modelos 3D superpuestos sobre la vista de la cámara en tiempo real, creando una experiencia de realidad aumentada (AR).

## 📱 Características

- ✅ **Vista de cámara en tiempo real** - Acceso completo a la cámara del dispositivo
- ✅ **Superposición de modelos 3D** - Renderizado de modelos GLB/GLTF sobre la cámara
- ✅ **Control de escala** - Ajustar el tamaño del modelo 3D con slider interactivo
- ✅ **Control de rotación** - Rotar el modelo en el eje Y para mejor visualización
- ✅ **Mostrar/Ocultar modelo** - Toggle para activar/desactivar la visualización
- ✅ **Reset de transformaciones** - Restaurar modelo a su estado original
- ✅ **Interfaz moderna** - UI/UX optimizada con Material Design 3
- ✅ **Gestión de permisos** - Manejo automático de permisos de cámara
- ✅ **Optimizado para Android** - Configuración específica para rendimiento Android

## 🚀 Modelos 3D Incluidos

- **Astronauta** (`Astronaut.glb`) - Modelo 3D de un astronauta espacial
- **Hamburguesa** (`hamburguesa.glb`) - Modelo 3D de una hamburguesa realista


## 📋 Requisitos del Sistema

- **Flutter SDK**: 3.0.0 o superior
- **Dart SDK**: 3.0.0 o superior
- **Android SDK**: API level 21 (Android 5.0) o superior
- **Dispositivo**: Cámara trasera funcional
- **Almacenamiento**: ~50MB para la aplicación y modelos

## 🛠️ Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  model_viewer_plus: ^1.7.2    # Renderizado de modelos 3D
  camera: ^0.10.5+9            # Acceso a la cámara
  permission_handler: ^11.3.1   # Gestión de permisos
  cupertino_icons: ^1.0.2      # Iconos iOS
```

## 📦 Instalación

### 1. Clonar el repositorio
```bash
git clone https://github.com/DenovanMonroy/ar_3d_viewer.git
cd ar_3d_viewer
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Configurar modelos 3D
Coloca tus archivos de modelos 3D en la carpeta:
```
assets/models/
├── Astronaut.glb
└── hamburguesa.glb
```

### 4. Ejecutar la aplicación
```bash
flutter run
```

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
└── screens/
    ├── home_screen.dart      # Pantalla principal con lista de modelos
    └── ar_camera_screen.dart # Pantalla de cámara AR con controles

assets/
└── models/
    ├── Astronaut.glb         # Modelo 3D del astronauta
    └── hamburguesa.glb       # Modelo 3D de la hamburguesa

android/
├── app/
│   ├── build.gradle.kts      # Configuración de construcción Android
│   └── src/main/
│       ├── AndroidManifest.xml               # Configuración de permisos
│       └── res/xml/network_security_config.xml # Configuración de red
```

## ⚙️ Configuración Android

### Permisos requeridos
La aplicación requiere los siguientes permisos en `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### Configuración de seguridad de red
Para permitir el servidor HTTP local del `model_viewer_plus`:

```xml
<application
    android:usesCleartextTraffic="true"
    android:networkSecurityConfig="@xml/network_security_config">
```

## 🎮 Uso de la Aplicación

### Pantalla Principal
1. **Seleccionar modelo**: Toca cualquier tarjeta de modelo para iniciar AR
2. **Permisos automáticos**: La app solicita permisos de cámara si es necesario

### Pantalla AR
1. **Mostrar modelo**: Presiona el botón azul "Mostrar" para superponer el modelo 3D
2. **Controlar escala**: Usa el slider superior para ajustar el tamaño (0.3x - 2.5x)
3. **Controlar rotación**: Usa el slider inferior para rotar el modelo (-180° a 180°)
4. **Ocultar modelo**: Presiona el botón rojo "Ocultar" para desactivar AR
5. **Reset**: Presiona el botón naranja "Reset" para restaurar transformaciones

## 🔧 Solución de Problemas

### Error: `ERR_CLEARTEXT_NOT_PERMITTED`
**Solución**: Asegúrate de que el archivo `network_security_config.xml` esté creado correctamente y referenciado en `AndroidManifest.xml`.

### Modelo no se carga
**Posibles causas**:
- Archivo GLB corrupto o formato incompatible
- Ruta incorrecta en `pubspec.yaml`
- Permisos de red bloqueados

### Cámara no funciona
**Solución**: Verifica permisos de cámara y reinicia la aplicación.

### Rendimiento lento
**Optimizaciones**:
- Usar modelos 3D optimizados (< 5MB recomendado)
- Cerrar aplicaciones en segundo plano
- Usar dispositivos con Android 7.0+

