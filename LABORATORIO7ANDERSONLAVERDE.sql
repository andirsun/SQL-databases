*Triggers*   select * from information_schema.triggers
*Laboratorio 7*
*Punrto 1*
----------------------------------
CREATE OR REPLACE FUNCTION empleadosalariofuncion() RETURNS TRIGGER AS $$
DECLARE
maxsalario integer;
 BEGIN
select into maxsalario max(salario) from empsucursal;
if NEW.salario > maxsalario then
RAISE NOTICE ' no se puede hacer insertar el empleado';
RETURN NULL;
ElSE
	RETURN NEW;
END IF;
  END
$$ LANGUAGE 'plpgsql';
--------------------------------------------------------
CREATE TRIGGER empleadosalariofuncion BEFORE INSERT 
    ON empsucursal 
EXECUTE PROCEDURE empleadosalariofuncion();
----------------------------------------------------              

CASO  FALLA 
INSERT INTO empleado VALUES(1005,'anderson','laverde','calle 44',5001,'1999-08-30','001','102901901');
INSERT INTO empSucursal Values (100,1005,27,50000000,0.1); -- FALLA LA CREACION ---
CASO EXITOSO 

INSERT INTO empSucursal Values (100,1005,2,5000000,0.1);


*PUNTO 3*


INSERT INTO cargo Values(51,'President');

UPDATE empSucursal SET codcargo =51  FROM empleado WHERE nombre= 'Pat' and apellido ='Rugge';


CREATE OR REPLACE FUNCTION empleadosalario1() RETURNS TRIGGER AS $$
DECLARE
cargo_emp integer;
salario_old INTEGER;
 BEGIN
 SELECT max(empsucursal.salario) INTO salario_old,cargo.codcargo INTO cargo_emp FROM empSucursal inner join cargo on empSucursal.codcargo = cargo.codcargo where cargo.nombre='President';
 if(new.codcargo = cargo_emp) then
 else
   if (new.salario <= salario_old) then
        RETURN NEW;
    ElSE
        RAISE NOTICE 'no se puede hacer insertar el empleado';
        RETURN NULL;
    END IF;
END IF;
END
$$ LANGUAGE 'plpgsql';

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



-----------------------------------------------------------------------------







--*PUNTO 4*
CREATE OR REPLACE FUNCTION ruleta() 
 RETURNS SETOF VARCHAR  AS  $$

DECLARE 
rEmp RECORD;
rEmp1 RECORD;
cantidadclientes integer := 0;
numerorandom1 integer := 0;
numerorandom2 integer := 0;
numerorandom3 integer := 0;
contparaupdate integer :=0;
cursortabla CURSOR IS 
  select nom_cliente,nom_tipocliente 
      from cliente natural join tipocliente
          where nom_tipocliente='Cliente Nuevo' or nom_tipocliente ='Cliente Normal';
  varText VARCHAR := '';
cursortabla1 CURSOR IS 
  select nom_cliente,nom_tipocliente 
      from cliente natural join tipocliente
          where nom_tipocliente='Cliente Nuevo' or nom_tipocliente ='Cliente Normal' FOR UPDATE OF CLIENTE;
BEGIN 
  FOR rEmp IN cursortabla
  LOOP 
    varText :=  varText ||  ' - ' || rEmp.nom_cliente|| ' '   || rEmp.nom_tipocliente;
    cantidadclientes = cantidadclientes + 1;
  END LOOP; 
  numerorandom1 = floor(random()*(-cantidadclientes+1))+cantidadclientes;
  numerorandom2 = floor(random()*(-cantidadclientes+1))+cantidadclientes;
  numerorandom3 = floor(random()*(-cantidadclientes+1))+cantidadclientes;
  RAISE NOTICE 'Los Clientes que Ganaron fueron los numeros %,%,%',numerorandom1,numerorandom2,numerorandom3;
  RAISE NOTICE 'Y los que jugaron fueron';
  RETURN NEXT varText;

  FOR rEmp1 IN cursortabla1
    LOOP
      contparaupdate = contparaupdate +1;
      IF(contparaupdate = numerorandom1 or contparaupdate = numerorandom2 or contparaupdate= numerorandom3) THEN 
        UPDATE  cliente SET  cod_tipocliente= 2 WHERE CURRENT OF  cursortabla1 ;
      END IF;

    END LOOP;
END;$$  LANGUAGE 'plpgsql';



UPDATE CLIENTE set cod_tipocliente = 1 where idclientee = 2 ;
UPDATE CLIENTE set cod_tipocliente = 3 where idclientee = 1 ;
UPDATE CLIENTE set cod_tipocliente = 1 where idclientee = 4 ;




-----------------------------------------------------------------------------



CREATE  OR  REPLACE FUNCTION ventasdiarias()  
RETURNS SETOF VARCHAR   AS  $$
DECLARE       
rEmp RECORD;    
cont SMALLINT :=  1;  
curs3 CURSOR  IS  
  SELECT sum(precio_unitario) AS SUMA,r.nombre AS nombre  FROM cabezera_pedidos cp 
    INNER JOIN detalle_pedido dp ON cp.codcabezerapedido = dp.cod_cabezerapedido 
    INNER JOIN restaurante r ON cp.codrestaurante = r.codrestaurante
     WHERE  cp.codrestaurante = r.codrestaurante GROUP BY r.nombre;
       
  varText VARCHAR :=  '';
BEGIN
  FOR rEmp IN curs3
  LOOP
      varText :=  varText ||  ' - ' || rEmp.nombre || ' '   ||  rEmp.SUMA  ;
    
  END LOOP;
  RETURN NEXT varText;  
END;$$  LANGUAGE 'plpgsql';