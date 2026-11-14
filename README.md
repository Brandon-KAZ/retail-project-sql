# retail_project - Pre-entrega SQL

Esquema base de un proyecto retail en PostgreSQL con tres tablas: `clientes`, `productos` y `ventas`.

## Contenido

- `script.sql`: DDL (creación de tablas con PRIMARY KEY, FOREIGN KEY, UNIQUE y CHECK) y DML (carga inicial en transacción, UPDATE y DELETE con WHERE).

## Cómo ejecutarlo

1. Crear la base de datos `retail_project` (en pgAdmin: clic derecho en *Databases* > *Create* > *Database*).
2. Abrir el *Query Tool* conectado a `retail_project`.
3. Abrir `script.sql` y ejecutarlo completo (F5).

El script se puede volver a ejecutar: al comienzo elimina las tablas si ya existen.

## Restricciones CHECK

- `clientes.edad >= 18`
- `productos.precio > 0`
- `productos.stock >= 0`
- `ventas.cantidad > 0`

## Tecnologías utilizadas

- PostgreSQL
- SQL (DDL y DML)
- pgAdmin 4
