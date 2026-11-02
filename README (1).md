# TP N.º 7 — Proyecto de Base de Datos Personal y Control de Versiones

**Asignatura:** Base de Datos 1 — IPET 247  
**Proyecto:** Catálogo y colección personal de videojuegos  
**Motor:** MySQL/MariaDB con XAMPP y phpMyAdmin

## 1. Descripción de la base de datos

El proyecto organiza información de videojuegos y permite registrar en qué plataformas están disponibles, sus géneros, las empresas desarrolladoras y los juegos que forman parte de una colección personal. También permite anotar el estado de cada juego dentro de la colección, el precio y formato de adquisición, y una reseña con puntuación.

Los datos incluidos en el script son ejemplos ficticios para probar la estructura. Deben revisarse y personalizarse antes de la entrega.

## 2. Justificación e importancia

Una colección de videojuegos puede crecer y quedar registrada en distintas plataformas. Si la información se guarda de manera desordenada, resulta difícil saber qué juegos se poseen, cuánto costaron, cuáles están pendientes y qué géneros o desarrolladoras aparecen en la colección. Esta base centraliza la información y reduce la duplicación de datos mediante tablas relacionadas.

## 3. Objetivos

- Registrar videojuegos con su título, fecha de lanzamiento y descripción.
- Relacionar cada juego con una o varias plataformas.
- Clasificar los juegos por género y desarrolladora.
- Registrar el estado, formato y precio de adquisición de cada juego de la colección.
- Guardar reseñas y puntuaciones.
- Consultar la colección mediante sentencias SQL con `JOIN`.

## 4. Tablas del modelo

El modelo contiene 10 tablas:

1. `juegos`: información general de cada videojuego.
2. `plataformas`: plataformas donde se puede jugar.
3. `generos`: categorías de videojuegos.
4. `desarrolladoras`: empresas o estudios desarrolladores.
5. `estados_juego`: estados posibles dentro de la colección.
6. `juegos_plataformas`: relación muchos a muchos entre juegos y plataformas.
7. `juegos_generos`: relación muchos a muchos entre juegos y géneros.
8. `juegos_desarrolladoras`: relación muchos a muchos entre juegos y desarrolladoras.
9. `biblioteca`: registra la colección, el estado, el precio y el formato por juego y plataforma.
10. `resenas`: puntuación y comentario asociado a un juego.

## 5. Relaciones e integridad

- `juegos` ↔ `plataformas`: muchos a muchos, mediante `juegos_plataformas`.
- `juegos` ↔ `generos`: muchos a muchos, mediante `juegos_generos`.
- `juegos` ↔ `desarrolladoras`: muchos a muchos, mediante `juegos_desarrolladoras`.
- `biblioteca` referencia a `juegos`, `plataformas` y `estados_juego`.
- `resenas` referencia a `juegos` y permite una reseña por juego.

Las tablas tienen claves primarias (`PRIMARY KEY`). Las relaciones se implementan con claves foráneas (`FOREIGN KEY`). Las tablas que resuelven relaciones muchos a muchos usan claves primarias compuestas. Se utilizan tipos de datos como `INT`, `VARCHAR`, `DATE`, `DECIMAL`, `TEXT` y `ENUM` según el contenido.


## 7. Git y GitHub

Desde una terminal, dentro de la carpeta del proyecto:

```bash
git init
git add tp07_coleccion_videojuegos.sql README.md
git commit -m "Agregar TP07 de base de datos"
git branch -M main
git remote add origin URL_DE_TU_REPOSITORIO
git push -u origin main
```

## 8. Declaración de uso de IA

La consigna solicita declarar explícitamente la ayuda recibida. Adaptá esta tabla para que describa fielmente lo que revisaste, modificaste y aprendiste.

| Herramienta | Propósito | Prompt utilizado | Ajuste / edición | Aprendizaje |
|---|---|---|---|---|
| ChatGPT | Proponer la estructura del proyecto, las tablas y un borrador de SQL y documentación. | “Ayudame a realizar entender el TP 7 de Base de Datos 1 respetando la consigna del PDF.” | Revisar el SQL en phpMyAdmin, comprobar las relaciones y personalizar tema, datos, nombres y documentación antes de entregar. | Completar con lo que efectivamente hayas comprendido sobre claves primarias, claves foráneas, relaciones muchos a muchos y consultas con JOIN. |

## 8. captura de pphpmyadmin
pegar enlace de la imagen que esta en el repositorio 