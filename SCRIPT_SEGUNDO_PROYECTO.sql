-- Created by JEISSON SANTACRUZ
			-- ANDER LAVERDE

-- tables
-- Table: cabezera_pedidos
CREATE TABLE cabezera_pedidos (
    codcabezerapedido int NOT NULL,
    valor int NOT NULL,
    fecha_pedido date NOT NULL,
    cantidad_total int NOT NULL,
    cod_cliente int NOT NULL,
    direccion_pedido varchar(30) NOT NULL,
    CONSTRAINT cabezera_pedidos_pk PRIMARY KEY (codcabezerapedido)
);

-- Table: ciudad
CREATE TABLE ciudadproyecto (
    codciudadd int NOT NULL ,
    nom_ciudad varchar(20) NOT NULL,
    cod_pais int NOT NULL,
    CONSTRAINT ciudad_pk PRIMARY KEY (codciudadd)
);

-- Table: cliente
CREATE TABLE cliente (
    idclientee int NOT NULL ,
    nom_cliente varchar(20) NULL,
    direccion varchar(30) NULL,
    correo varchar(30) NULL,
    telefono varchar(10) NULL,
    cod_ciudad int NOT NULL,
    cedula int NULL,
    fecha_inscripcion date NULL,
    cod_tipocliente int NULL,
    num_pedidos int NOT NULL,
    descuento int NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (idclientee)
);

-- Table: detalle_pedido
CREATE TABLE detalle_pedido (
    coddetallepedido int NOT NULL,
    cod_cabezerapedido int NOT NULL,
    cod_producto int NOT NULL,
    cantidad_producto int NOT NULL,
    precio_unitario int NOT NULL,
    CONSTRAINT detalle_pedido_pk PRIMARY KEY (coddetallepedido)
);

-- Table: domiciliarios
CREATE TABLE domiciliarios (
    iddomiciliario int NOT NULL,
    nom_domiciliario varchar(30) NOT NULL,
    telefono int NOT NULL,
    correo varchar(30) NOT NULL,
    num_pedidosentregados int NOT NULL,
    salario int NOT NULL,
    ciudad_res int NOT NULL,
    CONSTRAINT domiciliarios_pk PRIMARY KEY (iddomiciliario)
);

-- Table: domicilios
CREATE TABLE domicilios (
    cod_pedido int NOT NULL,
    id_domiciliario int NOT NULL,
    valor_domicilio int NOT NULL,
    valor_total int NOT NULL,
    CONSTRAINT domicilios_pk PRIMARY KEY (cod_pedido,id_domiciliario)
);

-- Table: ingredientes
CREATE TABLE ingredientes (
    codingredientes int NOT NULL ,
    nom_ingrediente varchar(20) NOT NULL,
    CONSTRAINT ingredientes_pk PRIMARY KEY (codingredientes)
);

-- Table: pais
CREATE TABLE pais (
    codpaiss int NOT NULL ,
    nom_pais varchar(20) NOT NULL,
    CONSTRAINT pais_pk PRIMARY KEY (codpaiss)
);

-- Table: productos
CREATE TABLE productos (
    codproducto int NOT NULL ,
    nom_producto varchar(20) NOT NULL,
    tipo_producto int NOT NULL,
    precio int NOT NULL,
    cod_ingredientes int NOT NULL,
    CONSTRAINT productos_pk PRIMARY KEY (codproducto)
);

-- Table: restaurante
CREATE TABLE restaurante (
    codrestaurante int NOT NULL,
    direccion_res varchar(30) NOT NULL,
    ranking int NOT NULL,
    cod_ciudad int NOT NULL,
    cod_telefonos int NOT NULL,
    CONSTRAINT restaurante_pk PRIMARY KEY (codrestaurante)
);

-- Table: restaurantesXproductos
CREATE TABLE restaurantesXproductos (
    cod_restaurante int NOT NULL,
    cod_producto int NOT NULL,
    cantidad int NOT NULL,
    CONSTRAINT restaurantesXproductos_pk PRIMARY KEY (cod_restaurante,cod_producto)
);

-- Table: telefono
CREATE TABLE telefono (
    num_telefono int NOT NULL,
    cod_restaurante_tele int NOT NULL,
    CONSTRAINT telefono_pk PRIMARY KEY (cod_restaurante_tele)
);

-- Table: tipoproductos
CREATE TABLE tipoproductos (
    codtipoproducto int NOT NULL ,
    nom_tipoproducto varchar(20) NOT NULL,
    CONSTRAINT tipoproductos_pk PRIMARY KEY (codtipoproducto)
);

-- Table: valordistancia
CREATE TABLE valordistancia (
    distancia int NOT NULL,
    valor_metro int NOT NULL,
    cod_valordistancia int NOT NULL,
    CONSTRAINT valordistancia_pk PRIMARY KEY (cod_valordistancia)
);

-- foreign keys
-- Reference: cabezera_pedidos_cliente (table: cabezera_pedidos)
ALTER TABLE cabezera_pedidos ADD CONSTRAINT cabezera_pedidos_cliente FOREIGN KEY cabezera_pedidos_cliente (cod_cliente)
    REFERENCES cliente (idclientee);

-- Reference: city_country (table: ciudad)
ALTER TABLE ciudad ADD CONSTRAINT city_country FOREIGN KEY city_country (cod_pais)
    REFERENCES pais (codpaiss);

-- Reference: client_city (table: cliente)
ALTER TABLE cliente ADD CONSTRAINT client_city FOREIGN KEY client_city (cod_ciudad)
    REFERENCES ciudadproyecto (codciudadd);

-- Reference: detalle_pedido_cabezera_pedidos (table: detalle_pedido)
ALTER TABLE detalle_pedido ADD CONSTRAINT detalle_pedido_cabezera_pedidos FOREIGN KEY detalle_pedido_cabezera_pedidos (cod_cabezerapedido)
    REFERENCES cabezera_pedidos (codcabezerapedido);

-- Reference: domiciliarios_ciudad (table: domiciliarios)
ALTER TABLE domiciliarios ADD CONSTRAINT domiciliarios_ciudad FOREIGN KEY domiciliarios_ciudad (ciudad_res)
    REFERENCES ciudadproyecto (codciudadd);

-- Reference: domicilios_cabezera_pedidos (table: domicilios)
ALTER TABLE domicilios ADD CONSTRAINT domicilios_cabezera_pedidos FOREIGN KEY domicilios_cabezera_pedidos (cod_pedido)
    REFERENCES cabezera_pedidos (codcabezerapedido);

-- Reference: domicilios_domiciliarios (table: domicilios)
ALTER TABLE domicilios ADD CONSTRAINT domicilios_domiciliarios FOREIGN KEY domicilios_domiciliarios (id_domiciliario)
    REFERENCES domiciliarios (iddomiciliario);

-- Reference: domicilios_valordistancia (table: domicilios)
ALTER TABLE domicilios ADD CONSTRAINT domicilios_valordistancia FOREIGN KEY domicilios_valordistancia (valor_domicilio)
    REFERENCES valordistancia (cod_valordistancia);

-- Reference: product_product_type (table: productos)
ALTER TABLE productos ADD CONSTRAINT product_product_type FOREIGN KEY product_product_type (tipo_producto)
    REFERENCES tipoproductos (codtipoproducto);

-- Reference: productos_ingredientes (table: productos)
ALTER TABLE productos ADD CONSTRAINT productos_ingredientes FOREIGN KEY productos_ingredientes (cod_ingredientes)
    REFERENCES ingredientes (codingredientes);

-- Reference: restaurante_ciudad (table: restaurante)
ALTER TABLE restaurante ADD CONSTRAINT restaurante_ciudad FOREIGN KEY restaurante_ciudad (cod_ciudad)
    REFERENCES ciudadproyecto (codciudadd);

-- Reference: restaurante_telefono (table: restaurante)
ALTER TABLE restaurante ADD CONSTRAINT restaurante_telefono FOREIGN KEY restaurante_telefono (cod_telefonos)
    REFERENCES telefono (cod_restaurante_tele);

-- Reference: restaurantesXproductos_productos (table: restaurantesXproductos)
ALTER TABLE restaurantesXproductos ADD CONSTRAINT restaurantesXproductos_productos FOREIGN KEY restaurantesXproductos_productos (cod_producto)
    REFERENCES productos (codproducto);

-- Reference: restaurantesXproductos_restaurante (table: restaurantesXproductos)
ALTER TABLE restaurantesXproductos ADD CONSTRAINT restaurantesXproductos_restaurante FOREIGN KEY restaurantesXproductos_restaurante (cod_restaurante)
    REFERENCES restaurante (codrestaurante);



