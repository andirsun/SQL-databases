
Anderson laverde 
/*primer punto */

CREATE OR REPLACE FUNCTION infoCompra (anio integer,mes integer) RETURNS void AS $$
	DECLARE
		nomCliente VARCHAR;
		dia DATE;
		numOrden INTEGER;
		estOrden VARCHAR; 
	BEGIN
		for nomCliente,numOrden,dia,estOrden in select cliente.nombre, orden.nroOrden, orden.fecha, orden.estado 
		from cliente natural join orden where extract(year from orden.fecha)=anio and extract(month from orden.fecha)=mes loop
			 RAISE NOTICE 'El señor % realizó la orden número % el día %, y el estado actual de la orden es %',nomCliente,numOrden,dia,estOrden;
		end loop;
	return;
	END; $$ LANGUAGE 'plpgsql';

/*Segundo */

CREATE OR REPLACE FUNCTION infoCantidad (anio integer) RETURNS void AS $$
	DECLARE
		anio_ integer;
		nomProducto VARCHAR;
		cantidadPro INTEGER;
		promedio float;
		sumaPro integer;

	BEGIN
		select sum(productosOrden.cantidad) into sumaPro from productosOrden;

		select extract(year from orden.fecha), producto.nombrep, max(sumaPro), 
		avg(productosOrden.cantidad) into anio_,nomProducto, cantidadPro, 
		promedio from orden natural join productosOrden natural join producto 
		where extract(year from orden.fecha)=anio group by orden.fecha,producto.nombrep;
		RAISE NOTICE ''En el año % el producto más vendido fue % con % cantidad, y el promedio de venta de los productos fue % cantidad'',anio_,nomProducto,cantidadPro,promedio;
	return;
	END; $$ LANGUAGE 'plpgsql';

/*tercero */

CREATE OR REPLACE FUNCTION infoClientes () RETURNS void AS $$
	DECLARE
		registrosInfo record;

	BEGIN


		for registrosInfo in select cliente.nombre as nombre, ciudad.nombre as ciudad, orden.nroOrden as numOrden, 
		producto.nombrep as nomProducto from ciudad inner join cliente on ciudad.codCiudad=cliente.codCiudad natural 
		join orden natural join productosOrden inner join producto on producto.idProducto=productosOrden.idProducto loop
			RAISE NOTICE ''|%|%|%|%|'',registrosInfo.nombre,registrosInfo.ciudad,registrosInfo.numOrden,registrosInfo.nomProducto;
		end loop;
	return;

	END; $$ LANGUAGE 'plpgsql';

/*cuarto */

CREATE OR REPLACE FUNCTION verificarEstado (numOrden integer) RETURNS void AS $$
	DECLARE

		
		
	BEGIN
		perform producto.nombrep, productosOrden.cantidad from producto natural join productosOrden 
		natural join orden where orden.nroOrden=numOrden and orden.estado='Facturada';
			if found then
				select producto.nombrep, productosOrden.cantidad from producto natural join productosOrden 
				natural join orden where orden.nroOrden=numOrden and orden.estado='Facturada';
				raise notice '|%|%|',producto.nombrep, productosOrden.cantidad;
			else
				raise notice 'La compra aún no está facturada';
			end if;
	END; $$ LANGUAGE 'plpgsql';



