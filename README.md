# 🚀 Proyecto Integrador: UIDE Super App

¡Bienvenidos al desafío!

El objetivo de hoy no es solo programar, sino **colaborar**. Vamos a construir una única aplicación ("La Super App del Campus") entre toda la clase. Cada grupo es responsable de un módulo vital. Si un módulo falla, la app falla.

## ⚠️ Reglas de Juego (Git Workflow)

Para evitar el caos, seguiremos estas reglas estrictas. **Quien dañe el `main`, invita las papas la próxima clase.**

1.  **PROHIBIDO** hacer commit directo a la rama `main`.
2.  Cada grupo debe crear su propia rama:
    ```bash
    git checkout -b feature/grupo-X-nombre-funcionalidad
    ```
3.  Al terminar, deben hacer **Push** a su rama y abrir un **Pull Request (PR)** hacia `main`.
4.  Deben resolver los conflictos de código hablando con los otros equipos. ¡La comunicación es parte de la nota!

---

## 📋 Asignación de Misiones por Grupo

Busca tu número de grupo y completa los requerimientos.

### 🔐 Grupo 1: Seguridad y Persistencia
Encargados de la puerta de entrada.
- [ ] Crear pantalla de **Login** (Diseño libre).
- [ ] Implementar lógica de validación (Usuario/Pass quemados o ficticios).
- [ ] Leer credenciales secretas desde un archivo `.env`.
- [ ] Guardar el estado de sesión (`isLoggedIn`) usando **SharedPreferences**.

### 👤 Grupo 2: Perfil de Usuario & UI
Encargados de la identidad visual.
- [ ] Crear pantalla de **Perfil de Usuario**.
- [ ] Diseñar un **Widget Personalizado** (`AvatarCard`) que reciba parámetros (foto, nombre).
- [ ] Mostrar datos del estudiante (Nombre, Carrera, Semestre) de forma estética.

### 🧭 Grupo 3: Navegación Central (The Managers)
**¡Atención!** Ustedes son el núcleo. Deben conectar el trabajo de todos.
- [ ] Definir las **Rutas (GoRouter)** (`routes`) en el `main.dart`.
- [ ] Implementar el menú principal (puede ser un `Drawer` o `BottomNavigationBar`).
- [ ] Crear los botones/enlaces que lleven a las pantallas de los otros 9 grupos.
- *Nota: Deben coordinar con todos los grupos para saber cómo llamar a sus clases.*

### ⚙️ Grupo 4: Configuración & Temas
Encargados del manejo de estado global.
- [ ] Crear pantalla de **Ajustes**.
- [ ] Implementar un **Switch** para activar/desactivar el "Modo Oscuro".
- [ ] Usar `ValueNotifier` o `ChangeNotifier` para que el cambio de tema se aplique en tiempo real.
- [ ] Guardar la selección usando **SharedPreferences**.

### 👁️ Grupo 5: Inteligencia Artificial (Texto)
Integración de servicios de IA.
- [ ] Crear pantalla **Escáner OCR**.
- [ ] Implementar **Google ML Kit (Text Recognition)**.
- [ ] Permitir que el usuario escanee un texto con la cámara y mostrar el resultado en un String editable.

### 🤖 Grupo 6: Inteligencia Artificial (Detección)
Integración de servicios de IA visual.
- [ ] Crear pantalla **Detector**.
- [ ] Implementar **Google ML Kit** (Face Detection o Barcode Scanning).
- [ ] Dibujar un recuadro sobre el rostro detectado o mostrar el valor del código de barras.

### 📰 Grupo 7: Listados y Datos
Manejo de colecciones y scroll.
- [ ] Crear pantalla de **Noticias UIDE**.
- [ ] Implementar un `ListView.builder` eficiente.
- [ ] Usar un Widget personalizado para cada "Tarjeta de Noticia" (Título, Imagen, Resumen).
- [ ] Simular datos con una lista/mapa local o JSON.

### 🕶️ Grupo 8: Realidad Aumentada / 3D
Experiencias inmersivas.
- [ ] Crear pantalla **Visor 3D**.
- [ ] Implementar un visor de modelos 3D (usando `model_viewer_plus` o similar).
- [ ] Mostrar un objeto `.glb` (ej: una silla, laptop o logo) que el usuario pueda rotar e interactuar (WebXR).

### 🚀 Grupo 9: Onboarding & Primera Ejecución
La bienvenida al usuario.
- [ ] Crear un **Onboarding** (Slider de 3 vistas explicando la app).
- [ ] Lógica: Solo debe aparecer la **primera vez** que se abre la app.
- [ ] Usar **SharedPreferences** para guardar la bandera `onboarding_visto`.

### 🚪 Grupo 10: Acerca de & Salida
El cierre del ciclo.
- [ ] Crear pantalla **Acerca De** (Créditos de la clase, versión de la app leída del `.env`).
- [ ] Implementar botón **Cerrar Sesión**.
- [ ] Lógica: Debe borrar los datos de sesión (Coordinar con Grupo 1) y redirigir al Login.

---

## 🛠️ Comandos Útiles

**Clonar el proyecto:**
```bash
git clone https://github.com/richardmijo/f_2526_prt_s7_2.git

---

## 🤝 Política de Revisión Cruzada

> **🚫 Regla de Oro:** Nadie tiene permiso para aprobar su propio Pull Request. Necesitan obligatoriamente el **'Approve'** de otro grupo para poder fusionar cambios.

### 🔄 ¿Cómo funciona el flujo?

1.  **Solicitud:** Cuando tu grupo abra un Pull Request (PR), deben pedir a otro equipo que los audite (¡Griten si es necesario!: *"¡Grupo 2, revisen nuestro código!"*).
2.  **La Auditoría:** El grupo revisor entra a GitHub y debe verificar:
    - [ ] Que no se estén subiendo archivos basura (`.idea/`, `build/`, `.vscode/`).
    - [ ] Que el código tenga sentido y no rompa nada obvio.
    - [ ] Que los nombres de variables/clases sean correctos.
3.  **El Veredicto:**
    * Si hay errores: Se dejan comentarios en el PR solicitando cambios ("Request Changes").
    * Si todo está bien: El revisor marca la opción **"Approve"**.
4.  **El Merge:** Solo cuando tengan el *check* verde de aprobación, el grupo autor puede dar click en **Merge**.