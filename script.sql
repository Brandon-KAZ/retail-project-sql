DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;


CREATE TABLE clientes (
    id_cliente     SERIAL PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    apellido       VARCHAR(100) NOT NULL,
    email          VARCHAR(150) NOT NULL UNIQUE,
    edad           INTEGER      NOT NULL,
    fecha_registro DATE         NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT chk_clientes_edad CHECK (edad >= 18)
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre      VARCHAR(120)  NOT NULL,
    categoria   VARCHAR(80)   NOT NULL,
    precio      DECIMAL(10,2) NOT NULL,
    stock       INTEGER       NOT NULL DEFAULT 0,
    CONSTRAINT chk_productos_precio CHECK (precio > 0),
    CONSTRAINT chk_productos_stock  CHECK (stock >= 0)
);

CREATE TABLE ventas (
    id_venta    SERIAL PRIMARY KEY,
    id_cliente  INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad    INTEGER NOT NULL,
    fecha_venta DATE    NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_ventas_clientes  FOREIGN KEY (id_cliente)  REFERENCES clientes (id_cliente),
    CONSTRAINT fk_ventas_productos FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    CONSTRAINT chk_ventas_cantidad CHECK (cantidad > 0)
);


BEGIN;

INSERT INTO clientes (nombre, apellido, email, edad, fecha_registro) VALUES
    ('Bruno',  'Gomez',     'bruno@email.com',  25, '2026-01-10'),
    ('Camila', 'Fernandez', 'camila@email.com', 32, '2026-01-12'),
    ('Lucas',  'Martinez',  'lucas@email.com',  28, '2026-01-15'),
    ('Sofia',  'Rodriguez', 'sofia@email.com',  21, '2026-01-18'),
    ('Mateo',  'Lopez',     'mateo@email.com',  40, '2026-01-20');

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
    ('Auriculares Bluetooth', 'Electronica', 45000.00, 20),
    ('Mouse inalambrico',     'Electronica', 18000.00, 35),
    ('Teclado mecanico',      'Electronica', 65000.00, 15),
    ('Mochila urbana',        'Accesorios',  32000.00, 12),
    ('Botella termica',       'Accesorios',  15000.00, 40);

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    ((SELECT id_cliente FROM clientes WHERE email = 'bruno@email.com'),
     (SELECT id_producto FROM productos WHERE nombre = 'Auriculares Bluetooth'), 1, '2026-02-01'),
    ((SELECT id_cliente FROM clientes WHERE email = 'camila@email.com'),
     (SELECT id_producto FROM productos WHERE nombre = 'Mouse inalambrico'),     2, '2026-02-03'),
    ((SELECT id_cliente FROM clientes WHERE email = 'lucas@email.com'),
     (SELECT id_producto FROM productos WHERE nombre = 'Mochila urbana'),        1, '2026-02-07'),
    ((SELECT id_cliente FROM clientes WHERE email = 'sofia@email.com'),
     (SELECT id_producto FROM productos WHERE nombre = 'Teclado mecanico'),      1, '2026-02-10'),
    ((SELECT id_cliente FROM clientes WHERE email = 'mateo@email.com'),
     (SELECT id_producto FROM productos WHERE nombre = 'Botella termica'),       3, '2026-02-12'),
    ((SELECT id_cliente FROM clientes WHERE email = 'bruno@email.com'),
     (SELECT id_producto FROM productos WHERE nombre = 'Botella termica'),       1, '2026-02-15');

COMMIT;

SELECT id_producto, nombre, categoria, precio
FROM productos
WHERE categoria = 'Accesorios';

UPDATE productos
SET precio = ROUND(precio * 1.10, 2)
WHERE categoria = 'Accesorios';

SELECT id_producto, nombre, categoria, precio
FROM productos
WHERE categoria = 'Accesorios';


SELECT * FROM ventas WHERE id_venta = 6;

DELETE FROM ventas
WHERE id_venta = 6;

SELECT * FROM ventas ORDER BY id_venta;