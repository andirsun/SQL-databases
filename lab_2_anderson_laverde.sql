/* ANDERSON LAVERDE GRACIA */
/* Punto 1 */

select apellido,nombre from empleado where fechanacimiento < '1967-01-01'order by apellido,nombre ASC;

/*Punto 2 */

select empleado.nombre,apellido,nrocuenta
  from empleado inner join banco on empleado.codBanco=banco.codBanco
    where banco.nombre = 'Davivienda'and substr(apellido,1,1)='P';

/* PUnto 3 */

select distinct  pagonomina.fechapago from pagonomina NATURAL JOIN
		( select * from empsucursal NATURAL JOIN
		 (select * from sucursal NATURAL JOIN ciudad where(ciudad.nombreciudad ='Bogota'))as sucursalbogota)as sucur ;

/* PUnto 4 */
select empleado.id, UPPER(empleado.apellido) as apellido, UPPER(cargo.nombre) as nombreCargo,empsucursal.salario, sucursal.nombre as nombresucursal from empsucursal inner join sucursal on empsucursal.codsucursal=sucursal.codsucursal inner join cargo on
empsucursal.codcargo=cargo.codcargo inner join empleado on empsucursal.idempleado=empleado.id;

/* PUnto 5 */


select RIGHT(apellido, 5) from empleado where ciudadres is NULL;

/* PUnto 6 */

select empleado.nombre, empleado.direccion, ciudad.nombreciudad from empleado left join ciudad on empleado.ciudadres = ciudad.codciudad ;


/* PUnto 7 */


select distinct banco.nombre from banco inner join (select * from pagonomina) as pago on banco.codbanco = pago.codbanco ;

/* PUnto 8 */

select datos.idempleado, datos.apellido,pagonomina.fechapago from pagonomina inner join
	(select * from empsucursal inner join empleado on empsucursal.idempleado = empleado.id)as datos on pagonomina.idempleado = datos.idempleado
		where ( pagonomina.fechapago > '2018-01-01');
