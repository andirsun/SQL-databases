/*Anderson laverde */

/*Punto 1 */
select sucursal.nombre,count(distinct empleado.ciudadres ) as suma
    from empSucursal inner join empleado on empSucursal.idempleado = empleado.id
                      inner join sucursal on empsucursal.codsucursal = sucursal.codSucursal
                        inner join  ciudad on empleado.ciudadres = ciudad.codciudad
                          group by sucursal.nombre
                          having count(distinct empleado.ciudadres )> 3 ;



/*Punto 2 */
select  distinct  ciudad.nombreciudad,sucursal.nombre, cargo.nombre
    from empSucursal 
          natural join sucursal 
            natural join ciudad 
              inner join cargo on empsucursal.codcargo = cargo.codcargo
    order by ciudad.nombreciudad, sucursal.nombre,cargo.nombre;

/*punto 3 debo agregar datos para que se cumpla las condiciones y muestre a alguna persona */
insert into empleado values (0,'Anderson','laverde','calle444',5001,'2001-08-30','003','1101010');
insert into empsucursal values (100,0,10,1000000,null);
insert into pagonomina values(1234,0,'1101010',001,'2017-10-31');
insert into detallepago values (1234,2,123456);

select empsucursal.idempleado,empleado.nombre
    from empsucursal inner join empleado on empsucursal.idempleado = empleado.id 
                      inner join pagonomina on empsucursal.idempleado = pagonomina.idempleado 
                      inner join detallepago on detallepago.nrocomprobante = pagonomina.nrocomprobante
                      natural join conceptopago 
      where bonificacion is NUll and conceptopago.tipo = 'PAG' and conceptopago.descripcion ='Bonificacion' ;

/*punto 4 */

/*Punto 5 */




