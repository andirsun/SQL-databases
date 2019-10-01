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

