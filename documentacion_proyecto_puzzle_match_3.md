# Documentación del Proyecto: Puzzle Match-3 (Halloween Edition)

Este proyecto nació como un desafío para entender cómo gestionar sistemas de grillas y lógicas de combinación dentro de **Godot Engine 4.x**. A continuación, detallo las decisiones tomadas durante el desarrollo y las fuentes consultadas para resolver los problemas que fueron surgiendo.

---

## 1. Sobre la lógica del juego (The Core)

Hacer que un juego reconozca cuándo hay tres fichas iguales en línea no es tan simple como parece. Después de investigar en varios hilos de Reddit y ver tutoriales de comunidades como **GDQuest**, entendí que la mejor forma de manejarlo era separando la “matemática” de los “dibujitos”.

- Implementé un sistema de arreglos bidimensionales (*Arrays de Arrays*).
- Utilicé un script independiente `match3_core.gd` que funciona como el cerebro del juego, calculando los movimientos y las explosiones sin interferir con la parte visual hasta que sea necesario.

---

## 2. El uso del Inglés en el Código

Si revisan el código, van a ver una mezcla de variables en español con términos técnicos en inglés. Esto no fue al azar, sino por una cuestión de practicidad técnica:

- **Compatibilidad con el motor:** GDScript usa palabras clave como `ready`, `physics_process`, `instantiate` o `queue_free`. Para mantener una lectura fluida y profesional junto con las funciones nativas de Godot, se conservaron muchos nombres en inglés.
- **Integración de tutoriales:** gran parte de la documentación técnica consultada se encuentra en inglés. Mantener ciertos términos originales ayudó a preservar la lógica y facilitar el debugueo.

---

## 3. Gestión de Recursos y Assets

Para el apartado visual, se utilizó un pack de assets de **Itch.io**. Se mantuvieron los nombres originales de carpetas y archivos (como `Ghost`, `Bat`, `Pumpkin`) para evitar que Godot pierda las rutas de importación.

Renombrar imágenes dentro de un motor de juegos puede romper referencias, por lo que se priorizó la estabilidad del proyecto.

---

## 4. Físicas y Movimiento

Se eligió trabajar con nodos `CharacterBody2D` y la función `move_and_collide` en lugar de `move_and_slide`.

Según la documentación oficial de Godot, para un juego de rompecabezas donde las piezas deben frenar en seco y encajar exactamente en un casillero, esta función ofrece mayor precisión y evita que las fichas patinen por error.

---

# Principales Fuentes de Consulta

- **Manual de Godot 4.x:** secciones de *Input Events* y *Signal Management*.
- **Reddit (r/godot):** consultas sobre *Mouse Filter* para que el fondo no bloquee los clics en las fichas.
- **KidsCanCode:** guías sobre estructuras de grillas y posiciones globales de vectores.
- **Documentación de Assets:** licencias de uso de recursos gráficos en Itch.io.

---

## Nota personal

Este proyecto fue un ejercicio de **prueba y error**, donde gran parte del tiempo estuvo dedicada a ajustar la detección de los toques del mouse y la alineación dinámica de las fichas en pantalla.
