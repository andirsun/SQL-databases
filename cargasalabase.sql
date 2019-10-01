INSERT INTO ciudadproyecto VALUES(11001,'Bogota',01);
INSERT INTO ciudadproyecto VALUES(5001,'Medellin',01);
INSERT INTO ciudadproyecto VALUES(8001,'Barranquilla',01);

INSERT INTO pais VALUES(01,'Colombia');

INSERT INTO restaurante VALUES(101,'calle 5 #24-3',24,11001,2699433,'Punta del mar');
INSERT INTO restaurante VALUES(102,'calle 3 #23-15',12,11001,3698745,'Puente comelon');
INSERT INTO restaurante VALUES(103,'calle 87 #14-10',84,5001,3548142,'Salt Bae');

INSERT INTO cliente VALUES(1,'Anderson Laverde','calle44 #113-44','ander@gmail.com','2699248',11001,114387154,'2017-12-01',2,20,10);
INSERT INTO cliente VALUES(2,'Jeison Santacruz','calle87 #41-10','js@gmail.com','3115414785',11001,123456789,'2016-03-14',1,3,4);
INSERT INTO cliente VALUES(3,'Juliana Caro','Conjunto Pdela Bocha 604A','JulianaC@gmail.com','3143811009',5001,134567854,'2016-06-14',2,10,9);

INSERT INTO cabezera_pedidos VALUES(2011,24000,'2018-03-01',4,1,'calle44 #113-44');
INSERT INTO cabezera_pedidos VALUES(2012,100000,'2018-03-04',9,2,'calle87 #41-10');
INSERT INTO cabezera_pedidos VALUES(2013,36000,'2018-03-09',7,3,'universidad javeriana');

INSERT INTO detalle_pedido VALUES(900001,2011,2004,10,10000);
INSERT INTO detalle_pedido VALUES(900002,2012,2006,10,20000);

INSERT INTO domicilios VALUES(300,2011,500,1,0);
INSERT INTO domicilios VALUES(301,2012,502,2,0);

INSERT INTO domiciliarios VALUES(500,'Eduardo Carranza',2698754,'ec@gmail',60,3000000,11001);
INSERT INTO domiciliarios VALUES(501,'Juan Bonet',2698785,'jb@gmail',100,2000000,11001);
INSERT INTO domiciliarios VALUES(502,'El Pelion',2698000,'Ep@gmail',251,2500000,5001);

INSERT INTO restaurantesXproductos VALUES(10,101,2004,10);
INSERT INTO restaurantesXproductos VALUES(11,102,2006,5);
INSERT INTO restaurantesXproductos VALUES(12,103,2005,10);

INSERT INTO productos VALUES(2004,'carne a la plancha',1,20000,1);
INSERT INTO productos VALUES(2005,'pollo a la plancha',1,19000,2);
INSERT INTO productos VALUES(2006,'postre de maracuya',3,20000,4);
INSERT INTO productos VALUES(2007,'pollocon salsade m',1,23000,2);
--INSERT INTO productos VALUES(2007,'pollocon salsade m',1,23000,3);
--INSERT INTO productos VALUES(2007,'pollocon salsade m',1,23000,4);

INSERT INTO tipoproductos VALUES(1,'Plato fuerte');
INSERT INTO tipoproductos VALUES(2,'Bebida');
INSERT INTO tipoproductos VALUES(3,'Postre');


INSERT INTO ingredientes VALUES(1,'filete de carne');
INSERT INTO ingredientes VALUES(2,'filete de pollo');
INSERT INTO ingredientes VALUES(3,'Arroz');
INSERT INTO ingredientes VALUES(4,'Maracuya');

INSERT INTO valordistancia VALUES(1,3000,2);
INSERT INTO valordistancia VALUES(2,3500,2);
INSERT INTO valordistancia VALUES(3,4200,2);






ALTER TABLE restaurante 
ADD COLUMN nombre VARCHAR;


*Punto 2*

with tabladerestaurantesconclientes as (select restaurante.nombre,restaurante.codrestaurante,cliente.nom_cliente,domicilios.valor_total
	 from restaurante inner join ciudad on ciudad.codciudad = restaurante.cod_ciudad
	 					inner join cliente on ciudad.codciudad = cliente.cod_ciudad
	 						inner join cabezera_pedidos on cliente.idclientee = cabezera_pedidos.cod_cliente
	 							inner join domicilios on cabezera_pedidos.codcabezerapedido = domicilios.cod_pedido
	 	where cabezera_pedidos.cod_cliente = cliente.idclientee),
tablarestaurantes as (select restaurante.nombre,restaurante.codrestaurante,restaurante.direccion_res from restaurante )
select tablarestaurantes.nombre,tablarestaurantes.direccion_res,tabladerestaurantesconclientes.nom_cliente,tabladerestaurantesconclientes.valor_total 
		from tabladerestaurantesconclientes right join tablarestaurantes 
			on tabladerestaurantesconclientes.codrestaurante = tablarestaurantes.codrestaurante ;




*punto 6* 

select  cod_cliente, min(distancia) as valordomi from domicilios inner join cabezera_pedidos on domicilios.cod_pedido = cabezera_pedidos.codcabezerapedido
																		inner join valordistancia on domicilios.valor_domicilio = valordistancia.cod_valordistancia
																		group by cod_cliente;
			






*Triggers*   select * from information_schema.triggers
*Laboratorio 7*
*Punrto 1*
----------------------------------
CREATE OR REPLACE FUNCTION empleadosalariofuncion() RETURNS TRIGGER AS $$
DECLARE
maxsalario integer;
 BEGIN
select into maxsalario max(salario) from empsucursal;
if new.salario < maxsalario then
RETURN NEW;
ElSE
	RAISE NOTICE 'no se puede hacer insertar el empleado';
	RETURN NULL;
END IF;
  END
$$ LANGUAGE 'plpgsql';
--------------------------------------------------------
CREATE TRIGGER empleadosalariofuncion BEFORE INSERT 
    ON empsucursal FOR EACH ROW
EXECUTE PROCEDURE empleadosalariofuncion();
----------------------------------------------------

CASO  FALLA 
INSERT INTO empleado VALUES(1005,'anderson','laverde','calle 44',5001,'1999-08-30','001','102901901');
INSERT INTO empSucursal Values (100,1005,27,50000000,0.1); -- FALLA LA CREACION ---
CASO EXITOSO 

INSERT INTO empSucursal Values (100,1005,2,5000000,0.1);


*PUNTO 3*

INSERT INTO cargo Values(28,'PRESIDENT');

UPDATE empSucursal SET codcargo =28  FROM empleado WHERE nombre= 'Pat' and apellido ='Rugge';


CREATE OR REPLACE FUNCTION empleadosalario1() RETURNS TRIGGER AS $$
DECLARE
cargo_emp VARCHAR;
salario_old INTEGER;
 BEGIN
 SELECT max(salario),codcargo INTO salario_old,cargo_emp FROM empSucursal NATURAL JOIN cargo;
 if(new.codcargo = cargo_emp) then
   
 else
   if (new.salario <= salario_old) then
        INSERT INTO  empSucursal(codSucursal,idempleado,codcargo,salario,bonificacion)VALUES(new.codSucursal,new.idempleado,new.codcargo,new.salario,new.bonificacion);
    ElSE
        RAISE NOTICE 'no se puede hacer insertar el empleado';
    END IF;
END IF;
   RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER empleadosalario1 BEFORE UPDATE 
    ON empSucursal FOR EACH ROW 
EXECUTE PROCEDURE empleadosalario1();

PUNTO 4--------------------------------------------------------------------------------------

CASO A-----
UPDATE empSucursal SET salario= 19000000 FROM empleado WHERE nombre= 'Carson' and apellido ='Paszak';

CASO B----
UPDATE empSucursal SET salario= 7000000 FROM empleado WHERE nombre= 'Carson' and apellido ='Paszak';


CASO C----
UPDATE empSucursal SET salario =15000000  FROM empleado WHERE nombre= 'Pat' and apellido ='Rugge';
