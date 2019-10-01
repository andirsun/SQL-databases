Taller 1  anderson laverde

CREATE TABLE ciudad(codCiudad int PRIMARY KEY,
					nombreCiudad varchar(14) NOT NULL);

INSERT INTO ciudad VALUES(11001,'Bogota');
INSERT INTO ciudad VALUES(5001,'Medellin');
INSERT INTO ciudad VALUES(8001,'Barranquilla');
INSERT INTO ciudad VALUES(19001,'Popayan');

CREATE TABLE sucursal(codSucursal smallint PRIMARY KEY,
					  nombre varchar(10) NOT NULL,
					  codCiudad int NOT NULL REFERENCES ciudad(codciudad));

\COPY sucursal FROM sucursal.csv with(delimiter ',', HEADER, FORMAT csv);

CREATE TABLE empleado(id smallint PRIMARY KEY,
                      nombre varchar(10) NOT NULL, 
                      apellido varchar(10) NOT NULL,
                      direccion varchar(10),
                      ciudadres int REFERENCES ciudad(codCiudad),
                      fechaNacimiento date NOT NULL,
                      codBanco varchar(3) NOT NULL REFERENCES banco(codBanco) ,
                      nroCuenta varchar(10) NOT NULL  );


CREATE TABLE Banco(codBanco varchar(3) PRIMARY KEY, 
				   nombre varchar(20) NOT NULL);

CREATE TABLE cargo(codCargo smallint PRIMARY KEY,
                  nombre varchar(10) NOT NULL);

CREATE TABLE empSucursal(codSucursal smallint  REFERENCES sucursal(codSucursal),
						 IDEmpleado smallint  REFERENCES empleado(id),
						 codCargo smallint REFERENCES cargo(codCargo),
						 salario int CHECK (salario >= 1000000 and salario <= 20000000),
						 bonificacion numeric(3,2) CHECK (bonificacion > 0.0 and bonificacion <=0.50),
						 PRIMARY KEY(codSucursal,IDEmpleado,codCargo));

CREATE TABLE pagoNomina (nroComprobante int PRIMARY KEY,
						 IDEmpleado smallint references empleado(id) NOT NULL,
						 nroCuenta varchar(10) NOT NULL,
						 codBanco varchar(3) NOT NULL,
						 fechaPago  date  default CURRENT_DATE NOT NULL);

CREATE TABLE conceptoPago (codConcepto smallint PRIMARY KEY , 
						   descripcion varchar(10) NOT NULL,
						   tipo char(3) CHECK (tipo IN ('DED','PAG')) NOT NULL );



CREATE TABLE detallePago(nroComprobante int REFERENCES pagoNomina(nroComprobante),
						 codConcepto smallint REFERENCES conceptoPago(codConcepto),
						 valor int NOT NULL, PRIMARY KEY(nroComprobante,codConcepto));

INSERT INTO Banco VALUES(001,'Davivienda');
INSERT INTO Banco VALUES(002,'Banco de Colombia');
INSERT INTO Banco VALUES(003,'Banco de Occidente');

Alter Table conceptoPago 
Alter Column descripcion type varchar(18);  ## ESTABA MAL LA TABLE Y TOCA RESERVARLE MAS ESPACIOS 

\COPY conceptoPago FROM conceptoPago.csv with(delimiter ';', HEADER, FORMAT csv); ### EJEMPLO DE COMO hago COPY A LOS ARCHIVOS  LOS ARCHIVOS 

\COPY cargo FROM cargo.csv with(delimiter ',', HEADER, FORMAT csv); ## OTRO EJEMPLO, SE PUEDE REVISAR EN MI USUARIO

