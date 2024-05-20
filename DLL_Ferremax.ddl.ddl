-- Creación de tablas
CREATE TABLE categoria (
    id_categoria INTEGER PRIMARY KEY,
    nom_cat      VARCHAR(50) NOT NULL
);

CREATE TABLE cliente (
    rut    VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE vendedor (
    correo       VARCHAR(300) PRIMARY KEY,
    nombre       VARCHAR(50) NOT NULL,
    id_categoria INTEGER NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);

CREATE TABLE contacto (
    fecha_hora  TIMESTAMP PRIMARY KEY,
    descripcion VARCHAR(2000) NOT NULL,
    correo      VARCHAR(300) NOT NULL,
    rut         VARCHAR(12) NOT NULL,
    FOREIGN KEY (rut) REFERENCES cliente (rut),
    FOREIGN KEY (correo) REFERENCES vendedor (correo)
    FOREING KEY (id_estado_correo) REFERENCES estado_correo (id_estado_correo) 
);

CREATE TABLE estado (
    id_estado  INTEGER PRIMARY KEY,
    nom_estado VARCHAR(50) NOT NULL
);

CREATE TABLE marca (
    id_marca  INTEGER PRIMARY KEY,
    nom_marca VARCHAR(50) NOT NULL
);

CREATE TABLE sucursal (
    id_sucursal  INTEGER PRIMARY KEY,
    nom_sucursal VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
    codigo_prod  VARCHAR(50) PRIMARY KEY,
    nom_prod     VARCHAR(50) NOT NULL,
    valor        NUMERIC NOT NULL,
    id_estado    INTEGER NOT NULL,
    id_categoria INTEGER NOT NULL,
    id_marca     INTEGER NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado (id_estado),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria),
    FOREIGN KEY (id_marca) REFERENCES marca (id_marca)
);

CREATE TABLE stock (
    stock       INTEGER NOT NULL,
    codigo_prod VARCHAR(50) NOT NULL,
    id_sucursal INTEGER NOT NULL,
    PRIMARY KEY (codigo_prod, id_sucursal),
    FOREIGN KEY (codigo_prod) REFERENCES producto (codigo_prod),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal)
);



CREATE TABLE venta (
    id_venta       SERIAL PRIMARY KEY,
    monto_final    NUMERIC NOT NULL,
    fecha          DATE NOT NULL,
    metodo_de_pago VARCHAR(50) NOT NULL,
    rut            VARCHAR(12) NOT NULL,
    FOREIGN KEY (rut) REFERENCES cliente (rut)
);

CREATE TABLE detalle_venta (
    id_estado_correo 	SERIAL PRIMARY KEY,
    nom_estado		INTEGER NOT NULL,

);

CREATE TABLE estado_correo (
    valor       NUMERIC NOT NULL,
    cantidad    INTEGER NOT NULL,
    monto_total NUMERIC NOT NULL,
    id_venta    SERIAL,
    codigo_prod VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_venta, codigo_prod),
    FOREIGN KEY (codigo_prod) REFERENCES producto (codigo_prod),
    FOREIGN KEY (id_venta) REFERENCES venta (id_venta)
);

--para login 

ALTER TABLE cliente
ADD COLUMN correo VARCHAR(200) UNIQUE NOT NULL,
ADD COLUMN contraseña VARCHAR(600) NOT NULL;

-- Inserción de datos
INSERT INTO categoria (id_categoria, nom_cat) VALUES (1, 'Herramientas Manuales');
INSERT INTO categoria (id_categoria, nom_cat) VALUES (2, 'Materiales Básicos');
INSERT INTO categoria (id_categoria, nom_cat) VALUES (3, 'Equipos de Seguridad');

INSERT INTO marca (id_marca, nom_marca) VALUES (1, 'Makita');
INSERT INTO marca (id_marca, nom_marca) VALUES (2, 'Bosch');
INSERT INTO marca (id_marca, nom_marca) VALUES (3, 'Stihl');

INSERT INTO sucursal (id_sucursal, nom_sucursal) VALUES (1, 'Concepcion centro');
INSERT INTO sucursal (id_sucursal, nom_sucursal) VALUES (2, 'Mallplaza Trébol');

INSERT INTO cliente (rut, nombre, correo, contraseña) VALUES ('20.994.291-7', 'Nicolas', 'Nico@gmail.com', 'pruebasinemcriptar');

INSERT INTO estado (id_estado, nom_estado) VALUES (1, 'Oferta');
INSERT INTO estado (id_estado, nom_estado) VALUES (2, 'Nuevo');
INSERT INTO estado (id_estado, nom_estado) VALUES (3, 'Normal');

INSERT INTO vendedor (correo, nombre, id_categoria) VALUES ('nicon607@gmail.com', 'NicoVendedor', 2);

INSERT INTO producto (codigo_prod, nom_prod, valor, id_estado, id_categoria, id_marca) VALUES ('MaCa-Makita-01', 'Martillo Carpintero', 3000, 2, 1, 1);
INSERT INTO producto (codigo_prod, nom_prod, valor, id_estado, id_categoria, id_marca) VALUES ('TaPeEl-Bosch-01', 'Taladro Percutor Electrico', 60000, 3, 1, 2);

INSERT INTO contacto (fecha_hora, descripcion, correo, rut) VALUES ('2024-05-07 10:30:00', 'Descripción del contacto', 'nicon607@gmail.com', '20.994.291-7');

INSERT INTO estado_correo (id_estado_correo, nom_estado) VALUES ('1', 'En revision');
INSERT INTO estado_correo (id_estado_correo, nom_estado) VALUES ('2', 'Respondido');