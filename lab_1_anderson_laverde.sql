Taller 1  anderson laverde

CREATE TABLE ciudad(codCiudad int PRIMARY KEY,nombreCiudad varchar(14) NOT NULL);
INSERT INTO ciudad VALUES(11001,'Bogota');
INSERT INTO ciudad VALUES(5001,'Medellin');
INSERT INTO ciudad VALUES(8001,'Barranquilla');
INSERT INTO ciudad VALUES(19001,'Popayan');

CREATE TABLE sucursal(codSucursal smallint PRIMARY KEY,nombre varchar(10) NOT NULL,codCiudad int NOT NULL REFERENCES ciudad(codciudad));

\COPY sucursal FROM sucursal.csv with(delimiter ',', HEADER, FORMAT csv);

CREATE TABLE empleado(id smallint PRIMARY KEY,
                      nombre varchar(10) NOT NULL, 
                      apellido varchar(10) NOT NULL,
                      direccion varchar(10),
                      ciudadres int REFERENCES ciudad(codCiudad),
                      fechaNacimiento date NOT NULL,
                      codBanco varchar(3) NOT NULL REFERENCES banco(codBanco) ,
                      nroCuenta varchar(10) NOT NULL  );

CREATE TABLE cargo(codCargo smallint PRIMARY KEY,
                  nombre varchar(10) NOT NULL);
