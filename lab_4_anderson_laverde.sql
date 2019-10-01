/*Anderson laverde */
/*Punto 1 */
UPDATE empleado SET direccion='41 Mar St' WHERE (nombre='Dion' and apellido='Simeone');

/*Punto 2 */

update detallepago set valor = valor + ( valor*0.1)/100
   from conceptopago,pagonomina
    where fechaPago= '2018-02-28' and  descripcion = 'Aporte Salud'
                                  and pagonomina.nrocomprobante = detallepago.nrocomprobante
                                  and detallepago.codconcepto = conceptopago.codconcepto;

/*Punto 3 */
DELETE FROM detallePago  WHERE nrocomprobante =6503698 and codConcepto=4; /*Para borrar toda la fila */

/*Punto 4 */
delete from detallePago
          using pagonomina,conceptopago,empleado
            where conceptopago.descripcion = 'Impuesto de renta'
                  and pagonomina.fechapago ='2018-02-28'
                  and empleado.nombre = 'Teresita'
                  and empleado.apellido ='Nucci'
                  and empleado.id = pagonomina.idempleado
                  and pagonomina.nrocomprobante = detallePago.nrocomprobante
                  and detallePago.codConcepto = conceptopago.codconcepto;

/*Punto 5 */
delete from detallePago
        using pagonomina /*Importante primero eliminar la tabla que tiene la felcha apuntando a la otra en este ejemplo la tabla detalle pago referencia la otra no al revez*/
            where detallepago.nrocomprobante = 6500641
                  and detallepago.nrocomprobante = pagonomina.nrocomprobante
                  RETURNING *;

/*Punto 6 */

alter table empleado
    add column fechaingreso date check (fechaingreso > '2000-01-01');

alter table banco add constraint nombre_unico UNIQUE (nombre);
