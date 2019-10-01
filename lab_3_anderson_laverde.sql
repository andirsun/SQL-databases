/*punto 1 */
select max(empsucursal.salario), min(empsucursal.salario) from empsucursal inner join sucursal on empsucursal.codsucursal = sucursal.codsucursal where sucursal.nombre = 'Cali Sur';
/*punto 2*/

with tablaone as
(select * from conceptopago inner join detallepago on conceptopago.codconcepto = detallepago.codconcepto)

select  sum(tablaone.valor) from pagonomina inner join tablaone on pagonomina.nrocomprobante = tablaone.nrocomprobante where tablaone.descripcion ='Salario'and pagonomina.fechapago ='2018-01-31';

/*punto 3*/

select  sucursal.nombre, avg(empSucursal.salario)from empsucursal inner join sucursal on empsucursal.codsucursal = sucursal.codsucursal
    where empsucursal.codsucursal = sucursal.codsucursal
      group by sucursal.nombre order by avg(empsucursal.salario) desc ;


/*Punto4 */
select nombre,count(empSucursal.idempleado) from empsucursal natural join sucursal
    group by sucursal.nombre
      having count(empsucursal.idempleado)>125
        order by nombre;

/*Punto 5 */

select tabla1.nombreciudad , tabla1.nombre, tabla2.valor
  from (empSucursal NATURAL join sucursal natural join ciudad )  as tabla1
    natural join (detallepago natural join conceptopago natural join pagoNomina ) as tabla2
      where tabla2.descripcion ='Aporte Salud' and tabla2.fechapago >= '2018-01-01'
        group by tabla1.nombreciudad , tabla1.nombre, tabla2.valor,tabla2.fechapago
          order by tabla1.nombreciudad, tabla1.nombre ,extract('month' from tabla2.fechaPago);


/*Punto 6*/

With tabla1 as (select  descripcion,fechaPago,nombre,valor,idempleado from empsucursal natural join sucursal  natural join  ( detallepago natural join conceptopago natural join pagonomina)
    where nombre ='Principal' and descripcion ='Bonificacion' and fechapago='2017-11-30' ),tabla2 as (select avg(tabla1.valor) as prom from tabla1)
         select  tabla1.valor,tabla1.idempleado,tabla1.nombre from tabla1,tabla2 where  tabla1.valor >  tabla2.prom  ;

/*Punto 7 */


With tabla1 as (select  nombre,empleado.id,fechapago,valor,tipo,apellido from empsucursal inner join  empleado on empSucursal.idempleado = empleado.id
                                                                                    inner join pagonomina on pagoNomina.idempleado = empSucursal.idempleado
                                                                                      natural join detallepago
                                                                                        natural join conceptopago),

tabla2 as (select sum(tabla1.valor)as pagado,tabla1.id from tabla1 where tabla1.tipo='PAG' group by tabla1.id),
  tabla3 as (select sum(tabla1.valor)as deuda,tabla1.id from tabla1 where tabla1.tipo='DED' group by tabla1.id),
    tabla4 as(select tabla2.id,tabla2.pagado from tabla2 inner join tabla3 on tabla2.id =tabla3.id where  tabla2.pagado - tabla3.deuda > 11000000  )


select tabla1.nombre,tabla1.apellido,tabla1.id,tabla4.pagado from tabla4,tabla1 where  tabla1.id = tabla4.id;

/*punto 8*/


With tabla1 as (select  nombre,empleado.id,valor,tipo,apellido,fechaPago from empsucursal inner join  empleado on empSucursal.idempleado = empleado.id
                                                                                    inner join pagonomina on pagoNomina.idempleado = empSucursal.idempleado
                                                                                      natural join detallepago
                                                                                        natural join conceptopago),
tabla2 as (select sum(tabla1.valor)as pagado,tabla1.id from tabla1 where tabla1.tipo='PAG' group by tabla1.id),
tabla3 as (select sum(tabla1.valor)as deuda,tabla1.id from tabla1 where tabla1.tipo='DED' group by tabla1.id),
tabla4 as(select tabla2.id, (tabla2.pagado - tabla3.deuda ) as sueldoneto from tabla2 inner join tabla3 on tabla2.id =tabla3.id where tabla2.id =tabla3.id)

SELECT extract('month' from tabla1.fechaPago) as mes, SUM(sueldoneto) as total,tabla4.id,tabla1.nombre,tabla1.apellido,tabla4.id
FROM tabla1,tabla4
GROUP BY mes,tabla4.id,tabla1.nombre,tabla1.apellido having SUM(sueldoneto)>8000000 ;


/*PUNTO 9*/

select * from empSucursal natural join sucursal inner join empleado on empSucursal.idempleado = empleado.id natural join pagoNomina natural join detallepago natural join conceptopago  ;
