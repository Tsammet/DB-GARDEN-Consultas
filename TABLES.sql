CREATE DATABASE gestionVentas;
USE gestionVentas;

CREATE TABLE pais (
    pais_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (50) NOT NULL
    );

CREATE TABLE region (
    region_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (50) NOT NULL,
    pais_id INT,
    FOREIGN KEY (pais_id) REFERENCES pais(pais_id)
);

CREATE TABLE ciudad(
    ciudad_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (50) NOT NULL,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES region(region_id)
);

CREATE TABLE gama_producto (
    gama_id VARCHAR(50) PRIMARY KEY,
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256)
    );
    
CREATE TABLE proveedor (
    proveedor_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE producto (
    producto_id VARCHAR(15) PRIMARY KEY ,
    nombre VARCHAR(70) NOT NULL,
    gama_id VARCHAR(50),
    dimensiones VARCHAR(25),
    proveedor_id INT,
    descripcion TEXT,
    cantidad_en_stock SMALLINT(6) NOT NULL,
    precio_venta DECIMAL(15,2) NOT NULL,
    precio_proveedor DECIMAL(15,2),
    FOREIGN KEY (gama_id) REFERENCES gama_producto(gama_id),
    FOREIGN KEY (proveedor_id) REFERENCES proveedor(proveedor_id)
    );


CREATE TABLE oficina(
    oficina_id VARCHAR(10) PRIMARY KEY,
    ciudad_id INT NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50),
    FOREIGN KEY(ciudad_id) REFERENCES ciudad(ciudad_id)
);

CREATE TABLE empleado(
    empleado_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    codigo_oficina_id VARCHAR(10),
    codigo_jefe_id INT(11),
    puesto VARCHAR(50),
    FOREIGN KEY (codigo_oficina_id) REFERENCES oficina(oficina_id),
    FOREIGN KEY (codigo_jefe_id) REFERENCES empleado(empleado_id)
);

CREATE TABLE cliente(
    cliente_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(50) NOT NULL,
    nombre_contacto VARCHAR(30),
    apellido_contacto VARCHAR(30),
    telefono VARCHAR(15) NOT NULL,
    fax VARCHAR(15) NOT NULL,
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR (50),
    ciudad_id INT NOT NULL,
    codigo_postal VARCHAR(10),
    empleado_id INT(11),
    limite_credito DECIMAL(15,2),
    FOREIGN KEY(ciudad_id) REFERENCES ciudad(ciudad_id),
    FOREIGN KEY (empleado_id) REFERENCES empleado(empleado_id)
);

CREATE TABLE forma_pago(
	forma_pago_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_forma_pago VARCHAR(50)
);

CREATE TABLE pago (
    transaccion_id VARCHAR(50) PRIMARY KEY,
    cliente_id INT(11) NOT NULL,
    forma_pago_id INT,
    fecha_pago_id DATE NOT NULL,
    total DECIMAL(15,2) NOT NULL,
    FOREIGN KEY(cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY(forma_pago_id) REFERENCES forma_pago(forma_pago_id)
);

CREATE TABLE estado_pedido(
	estado_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_estado VARCHAR(50)
);

CREATE TABLE pedido(
    pedido_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    estado_pedido_id INT,	
    fecha_pedido DATE NOT NULL,
    fecha_esperada DATE NOT NULL,
    fecha_entregada DATE,  
    comentarios TEXT,
    cliente_id INT(11),
    FOREIGN KEY(cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY(estado_pedido_id) REFERENCES estado_pedido(estado_id)
);

CREATE TABLE detalle_pedido(
    codigo_pedido INT(11) AUTO_INCREMENT,
    codigo_producto VARCHAR(15),
    cantindad INT(11),
    precio_unidad DECIMAL(15,2),
    numero_linea SMALLINT(6),
    PRIMARY KEY(codigo_pedido, codigo_producto) 
);
