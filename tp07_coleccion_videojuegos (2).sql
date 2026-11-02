-- Trabajo Práctico N.º 7 - Base de Datos 1
-- Proyecto: Catálogo y colección personal de videojuegos
-- Motor: MySQL / MariaDB (XAMPP - phpMyAdmin)
-- Datos de ejemplo ficticios. No incluir datos personales reales.

CREATE DATABASE IF NOT EXISTS coleccion_videojuegos
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE coleccion_videojuegos;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS resenas;
DROP TABLE IF EXISTS biblioteca;
DROP TABLE IF EXISTS juegos_desarrolladoras;
DROP TABLE IF EXISTS juegos_generos;
DROP TABLE IF EXISTS juegos_plataformas;
DROP TABLE IF EXISTS juegos;
DROP TABLE IF EXISTS desarrolladoras;
DROP TABLE IF EXISTS generos;
DROP TABLE IF EXISTS plataformas;
DROP TABLE IF EXISTS estados_juego;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE plataformas (
    id_plataforma INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    fabricante VARCHAR(80),
    tipo VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE generos (
    id_genero INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE desarrolladoras (
    id_desarrolladora INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL UNIQUE,
    pais VARCHAR(80)
) ENGINE=InnoDB;

CREATE TABLE estados_juego (
    id_estado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE,
    descripcion VARCHAR(200)
) ENGINE=InnoDB;

CREATE TABLE juegos (
    id_juego INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    fecha_lanzamiento DATE,
    clasificacion_edad VARCHAR(20),
    descripcion TEXT,
    UNIQUE KEY uq_juego_titulo_fecha (titulo, fecha_lanzamiento)
) ENGINE=InnoDB;

CREATE TABLE juegos_plataformas (
    id_juego INT UNSIGNED NOT NULL,
    id_plataforma INT UNSIGNED NOT NULL,
    fecha_lanzamiento_plataforma DATE,
    PRIMARY KEY (id_juego, id_plataforma),
    CONSTRAINT fk_jp_juego FOREIGN KEY (id_juego)
        REFERENCES juegos(id_juego) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_jp_plataforma FOREIGN KEY (id_plataforma)
        REFERENCES plataformas(id_plataforma) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE juegos_generos (
    id_juego INT UNSIGNED NOT NULL,
    id_genero INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_juego, id_genero),
    CONSTRAINT fk_jg_juego FOREIGN KEY (id_juego)
        REFERENCES juegos(id_juego) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_jg_genero FOREIGN KEY (id_genero)
        REFERENCES generos(id_genero) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE juegos_desarrolladoras (
    id_juego INT UNSIGNED NOT NULL,
    id_desarrolladora INT UNSIGNED NOT NULL,
    rol VARCHAR(40) NOT NULL DEFAULT 'Desarrollo',
    PRIMARY KEY (id_juego, id_desarrolladora),
    CONSTRAINT fk_jd_juego FOREIGN KEY (id_juego)
        REFERENCES juegos(id_juego) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_jd_desarrolladora FOREIGN KEY (id_desarrolladora)
        REFERENCES desarrolladoras(id_desarrolladora) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE biblioteca (
    id_biblioteca INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_juego INT UNSIGNED NOT NULL,
    id_plataforma INT UNSIGNED NOT NULL,
    id_estado INT UNSIGNED NOT NULL,
    fecha_adquisicion DATE,
    precio_compra DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    formato ENUM('Digital', 'Fisico', 'Suscripcion') NOT NULL DEFAULT 'Digital',
    notas VARCHAR(255),
    UNIQUE KEY uq_biblioteca_juego_plataforma (id_juego, id_plataforma),
    CONSTRAINT chk_precio_no_negativo CHECK (precio_compra >= 0),
    CONSTRAINT fk_bib_juego FOREIGN KEY (id_juego)
        REFERENCES juegos(id_juego) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_bib_plataforma FOREIGN KEY (id_plataforma)
        REFERENCES plataformas(id_plataforma) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_bib_estado FOREIGN KEY (id_estado)
        REFERENCES estados_juego(id_estado) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE resenas (
    id_resena INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_juego INT UNSIGNED NOT NULL UNIQUE,
    puntuacion TINYINT UNSIGNED NOT NULL,
    comentario TEXT,
    fecha_resena DATE NOT NULL,
    CONSTRAINT chk_puntuacion CHECK (puntuacion BETWEEN 1 AND 10),
    CONSTRAINT fk_resena_juego FOREIGN KEY (id_juego)
        REFERENCES juegos(id_juego) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- Datos iniciales de ejemplo (ficticios)
INSERT INTO plataformas (nombre, fabricante, tipo) VALUES
('PC', 'Varios', 'Computadora'),
('PlayStation 5', 'Sony', 'Consola'),
('Nintendo Switch', 'Nintendo', 'Consola');

INSERT INTO generos (nombre, descripcion) VALUES
('Aventura', 'Exploración y narrativa'),
('Acción', 'Combate y desafíos de reflejos'),
('RPG', 'Juego de rol y progresión de personajes'),
('Deportes', 'Simulación de deportes');

INSERT INTO desarrolladoras (nombre, pais) VALUES
('Estudio Ejemplo', 'Argentina'),
('Desarrolladora Ficticia', 'Japón');

INSERT INTO estados_juego (nombre, descripcion) VALUES
('Pendiente', 'Todavía no se comenzó'),
('Jugando', 'Se está jugando actualmente'),
('Completado', 'Se terminó el juego'),
('Abandonado', 'Se dejó de jugar');

INSERT INTO juegos (titulo, fecha_lanzamiento, clasificacion_edad, descripcion) VALUES
('Aventura de Ejemplo', '2024-05-10', '12+', 'Registro ficticio para probar la base'),
('Desafío Deportivo', '2023-09-15', '3+', 'Registro ficticio para probar la base');

INSERT INTO juegos_plataformas (id_juego, id_plataforma, fecha_lanzamiento_plataforma) VALUES
(1, 1, '2024-05-10'), (1, 2, '2024-05-10'), (2, 3, '2023-09-15');

INSERT INTO juegos_generos (id_juego, id_genero) VALUES
(1, 1), (1, 3), (2, 4);

INSERT INTO juegos_desarrolladoras (id_juego, id_desarrolladora, rol) VALUES
(1, 1, 'Desarrollo'), (2, 2, 'Desarrollo');

INSERT INTO biblioteca (id_juego, id_plataforma, id_estado, fecha_adquisicion, precio_compra, formato, notas) VALUES
(1, 1, 1, '2025-02-01', 12000.00, 'Digital', 'Dato de ejemplo'),
(2, 3, 3, '2024-01-20', 8000.00, 'Fisico', 'Dato de ejemplo');

INSERT INTO resenas (id_juego, puntuacion, comentario, fecha_resena) VALUES
(2, 8, 'Reseña de ejemplo; reemplazar por una opinión propia', '2025-03-01');

-- Consultas de prueba
SELECT j.titulo, p.nombre AS plataforma, e.nombre AS estado, b.precio_compra
FROM biblioteca b
JOIN juegos j ON b.id_juego = j.id_juego
JOIN plataformas p ON b.id_plataforma = p.id_plataforma
JOIN estados_juego e ON b.id_estado = e.id_estado
ORDER BY j.titulo;

SELECT j.titulo, GROUP_CONCAT(DISTINCT g.nombre ORDER BY g.nombre SEPARATOR ', ') AS generos
FROM juegos j
LEFT JOIN juegos_generos jg ON j.id_juego = jg.id_juego
LEFT JOIN generos g ON jg.id_genero = g.id_genero
GROUP BY j.id_juego, j.titulo;
