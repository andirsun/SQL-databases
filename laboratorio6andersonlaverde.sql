*PUNTO 1*
CREATE OR REPLACE FUNCTION public.prima(id integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
declare
  result int;
BEGIN
  SELECT (detallepago.valor/2) into result
  FROM detallepago natural join conceptopago natural join pagonomina
  WHERE  idempleado = id and descripcion = 'Salario';
  return(result);
END; $function$
-------------------------------------------------------------------
*PUNTO2*
CREATE OR REPLACE FUNCTION INFO_EMPLEADO()
RETURNS TEXT AS $$
DECLARE
nom_sucursal VARCHAR;
num_empleados INTEGER;
textOutput TEXT := ' ';
BEGIN
FOR nom_sucursal,num_empleados IN SELECT nombre,COUNT(idempleado) FROM  empSucursal NATURAL JOIN sucursal GROUP BY nombre 
LOOP
textOutput := textOutput||nom_sucursal ||','|| num_empleados 	 ||';';
END LOOP;

RETURN textOutput;
END; $$ LANGUAGE 'plpgsql';
----------------------------------------------------------------

*PUNTO 3*
CREATE OR REPLACE FUNCTION funcion3 (id int, fecha date)
	RETURNS TEXT AS $$

	DECLARE
	pago1 varchar;
	pagos int;
	textOutput TEXT := '';
BEGIN
	FOR pago1,pagos in select conceptopago.descripcion,detallepago.valor from detallepago natural join conceptoPago natural join pagonomina 
		where pagonomina.idempleado = id and pagonomina.fechaPago= fecha
		LOOP
		textOutput := textOutput || pago1 ||' : '||
			pagos||';'||' ';
		END LOOP;
	RETURN textOutput;
END; $$ LANGUAGE 'plpgsql';	
 
------------------------------------------------------
 * Punto 5 * 
CREATE OR REPLACE FUNCTION existe_empleado(nom varchar, apelli varchar , nom_sucursal varchar)
RETURNS VOID AS $$
DECLARE
		cargoempleado VARCHAR;
BEGIN
	PERFORM * FROM empSucursal NATURAL join sucursal
								inner join cargo  on empSucursal.codCargo = cargo.codCargo
								inner join empleado on empSucursal.idempleado = empleado.id
	 		where nom_sucursal = sucursal.nombre and empleado.nombre = nom and empleado.apellido = apelli ;
	IF NOT FOUND THEN
	RAISE NOTICE 'NO SE ENCONTRO EL EMPLEADO';
	RETURN ;
	ELSE
	RAISE NOTICE 'el cargo es: %',tabla1.nombre from ( select cargo.nombre FROM empSucursal NATURAL join sucursal
								inner join cargo  on empSucursal.codCargo = cargo.codCargo
								inner join empleado on empSucursal.idempleado = empleado.id
	 		where nom_sucursal = sucursal.nombre and empleado.nombre = nom and empleado.apellido = apelli) as tabla1 ;
	END IF;
END; $$ LANGUAGE 'plpgsql';

----------------------------------------



