# Justificación Técnica y Metodológica del Desarrollo

El presente proyecto ha sido desarrollado utilizando el motor **Godot Engine 4.x**, empleando una metodología de aprendizaje basada en la investigación de estándares de la industria y documentación técnica oficial. A continuación, se detallan las fuentes y fundamentos que sustentan la arquitectura del software.

---

## 1. Implementación de Lógica Core (Match-3)

La mecánica fundamental de intercambio y detección de patrones se basa en algoritmos de **Grid Management** y **Recursive Match Detection**.

La lógica de control contenida en el archivo `match3_core.gd` fue adaptada siguiendo los principios de **separación de responsabilidades (Model-View-Controller)**, inspirada en patrones de diseño documentados en comunidades de desarrollo de videojuegos como:

- **GDQuest** y **KidsCanCode**: referentes en la implementación de arreglos bidimensionales (*Arrays de Arrays*) para la gestión de grillas lógicas.
- **Documentación oficial de Godot (Resources)**: el uso de `Resource` para la definición de tipos de fichas permite una arquitectura extensible y basada en datos, facilitando la adición de nuevos elementos sin modificar el código fuente principal.

---

## 2. Sintaxis y Nomenclatura Híbrida (Inglés / Español)

La decisión de mantener una nomenclatura mixta responde a criterios de interoperabilidad y estabilidad del software:

- **API Native Binding**: las funciones críticas del motor (ej. `_ready`, `_physics_process`, `move_and_collide`) son inalterables por diseño del lenguaje GDScript. Se optó por mantener variables relacionadas en inglés para conservar la coherencia semántica con las funciones nativas.
- **Referencia de Documentación Técnica**: al consultar hilos de soporte en plataformas como Reddit (`r/godot`) y los Godot Forums, el estándar de resolución de errores se presenta globalmente en inglés. Para evitar colisiones lógicas o errores de referencia al integrar fragmentos de lógica compleja (como el cálculo de trayectorias), se conservaron los términos técnicos originales.

---

## 3. Gestión de Colisiones y Física 2D

La resolución del movimiento de piezas mediante `CharacterBody2D` y el método `move_and_collide` fue seleccionada tras investigar la diferencia de desempeño en el manual oficial de Godot respecto a `move_and_slide`.

**Fundamento:** para un sistema de rompecabezas, se requiere una detención inmediata ante la detección de un objeto en el vector de movimiento, eliminando el “deslizamiento” inercial propio de los juegos de plataformas.

---

## 4. Integración de Recursos Visuales (Assets)

El pack de arte integrado proviene de repositorios de **Itch.io** (estándar CC0 o atribución).

La jerarquía de carpetas y los nombres de los archivos PNG se mantuvieron en su formato original para asegurar la integridad de las rutas de importación (`res://assets/...`), evitando errores de carga por caracteres especiales o rutas rotas durante el despliegue del proyecto.

---

# Bibliografía y Referencias de Consulta

- **Godot Engine 4.x Documentation**: *Nodes and Scenes*, *Scripting*, *Groups*.
- **University of Game Design (YouTube)**: *Match-3 Logic and Grid Systems in Godot*.
- **Godot Recipes (official tutorial lists)**: *Drag and Drop with InputEvent*.
- **Stack Overflow / Reddit Dev Community**: *Handling Mouse Filter for Background Elements*.

