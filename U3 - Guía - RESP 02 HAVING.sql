/*------------------------------------------------------------------------------------------------
  Guia de Ejercicios SUBCONSULTAS HAVING
-------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------
 1. Se quiere saber ¿cuando realizo su primer venta cada vendedor? y ¿cuanto fue el importe total 
 de las ventas que ha realizado? Mostrar estos datos en un listado solo para los casos en que su 
 importe promedio de vendido sea superior al importepromedio general (importe promedio de todas 
 las facturas)
-------------------------------------------------------------------------------------------------*/
SELECT  f.cod_vendedor 'Codigo',
		ape_vendedor + ' ' + nom_vendedor 'Vendedor',
		MIN(fecha)'1er.Vta.',
		SUM(cantidad * pre_unitario)'Importe total'
   FROM facturas f 
   JOIN vendedores v ON f.cod_vendedor = v.cod_vendedor
   JOIN detalle_facturas d ON f.nro_factura = d.nro_factura
  GROUP BY f.cod_vendedor,
		   ape_vendedor + ' ' + nom_vendedor
 HAVING AVG(cantidad  *pre_unitario)>(SELECT AVG(cantidad * pre_unitario)
								  	    FROM detalle_facturas);

/*------------------------------------------------------------------------------------------------
 2. Liste los montos totales mensuales facturados por cliente y ademas del promedio de ese monto 
 y la el promedio de precio de articulos Todos esto datos correspondientes a periodo que va desde 
 el 1° de febrero al 30 de agosto del 2014. Solo muestre los datos si esos montos totales sea 
 superior o igual al promedio global.
-------------------------------------------------------------------------------------------------*/
SELECT YEAR(fecha)'Anio',
	   MONTH(fecha)'Mes',
	   c.cod_cliente, 
	   ape_cliente + ' ' + nom_cliente 'Cliente',
       SUM(cantidad * d.pre_unitario)'Monto Total',
       AVG(cantidad * d.pre_unitario)'Monto Promedio',
       AVG(d.pre_unitario) 'Precio Promedio'
  FROM facturas f 
  JOIN detalle_facturas d ON f.nro_factura = d.nro_factura 
  JOIN clientes c ON f.cod_cliente = c.cod_cliente
WHERE fecha BETWEEN '1/2/2014' AND '1/8/2014'
GROUP BY YEAR(fecha),
		 MONTH(fecha),
         c.cod_cliente, 
		 ape_cliente + ' ' + nom_cliente
HAVING SUM(cantidad * d.pre_unitario) >= (SELECT AVG(cantidad * pre_unitario)
									   	    FROM detalle_facturas);  

/*------------------------------------------------------------------------------------------------
  3. Por cada articulo que se tiene a la venta, se quiere saber el importe promedio vendido, la 
  cantidad total vendida por articulo, para los casos en que los numeros de factura no sean uno 
  de los siguientes: 2, 10, 7, 13, 22 y que ese importe promedio sea inferior al importe promedio 
  de ese articulo. 
 -------------------------------------------------------------------------------------------------*/
SELECT a.cod_articulo, descripcion,
       AVG(cantidad * d.pre_unitario)'Importe promedio',
       SUM(cantidad) 'Cantidad total'
  FROM articulos a 
  JOIN detalle_facturas d ON a.cod_articulo = d.cod_articulo
 WHERE d.nro_factura NOT IN (2, 10, 7, 13, 22)
 GROUP BY a.cod_articulo, 
		  descripcion
HAVING AVG(cantidad * d.pre_unitario) < (SELECT AVG(cantidad * pre_unitario)
										   FROM detalle_facturas
										  WHERE cod_articulo = a.cod_articulo); -- Ref. Externa

/*------------------------------------------------------------------------------------------------
  4. Listar la cantidad total vendida, el importe y promedio vendido por fecha, siempre que esa 
  cantidad sea superior al promedio de la cantidad global. Rotule y ordene. 
 -------------------------------------------------------------------------------------------------*/
SELECT fecha,
	   SUM(cantidad)'Cant. total vendida',
       AVG(cantidad*d.pre_unitario)'Importe promedio',
       SUM(cantidad*d.pre_unitario)'Promedio vendido'
  FROM facturas f 
  JOIN detalle_facturas d ON f.nro_factura = d.nro_factura
 GROUP BY fecha
HAVING SUM(cantidad) > (SELECT AVG(cantidad)
						  FROM detalle_facturas)
  ORDER BY 1;

/*------------------------------------------------------------------------------------------------
  5. Se quiere saber el promedio del importe vendido y la fecha de la primer venta por fecha y 
  articulo para los casos en que las cantidades vendidas oscilen entre 5 y 20 y que ese importe 
  sea superior al importe promedio de ese articulo. 
 -------------------------------------------------------------------------------------------------*/
SELECT fecha,a.cod_articulo, descripcion,
       AVG(cantidad * d.pre_unitario)'Importe promedio',
       MIN (fecha)'1er.fecha'
  FROM facturas f 
  JOIN detalle_facturas d ON f.nro_factura = d.nro_factura 
  JOIN articulos a ON a.cod_articulo = d.cod_articulo
 WHERE cantidad BETWEEN 5 AND 20
 GROUP BY fecha,
		  a.cod_articulo, 
		  descripcion
HAVING SUM(cantidad * d.pre_unitario) >	(SELECT AVG(cantidad * pre_unitario)
										   FROM detalle_facturas 
										  WHERE cod_articulo = a.cod_articulo);-- Ref. Externa

/*------------------------------------------------------------------------------------------------
  6. Emita un listado con los montos diarios facturados que sean inferior al importe promedio general. 
 -------------------------------------------------------------------------------------------------*/
SELECT fecha,
	   SUM(cantidad * d.pre_unitario) 'Monto diario'
  FROM facturas f 
  JOIN detalle_facturas d ON f.nro_factura = d.nro_factura
 GROUP BY fecha
HAVING SUM(cantidad * d.pre_unitario) < (SELECT AVG(cantidad * pre_unitario)
						   				   FROM detalle_facturas);

/*------------------------------------------------------------------------------------------------
  7. Se quiere saber la fecha de la primera y ultima venta, el importe total facturado por cliente 
  para los anios que oscilen entre el 2007 y 2010 y que el importe promedio facturado sea menor que 
  el importe promedio total para ese cliente.
 -------------------------------------------------------------------------------------------------*/
SELECT c.cod_cliente,
	   ape_cliente + ' ' + nom_cliente 'Cliente',
       MIN(fecha)'1er.Vta.', 
	   max(fecha)'Ultima venta',
       SUM(cantidad * d.pre_unitario)'Importe total facturado'
  FROM facturas f 
  JOIN detalle_facturas d ON f.nro_factura = d.nro_factura 
  JOIN clientes c ON f.cod_cliente = c.cod_cliente
 WHERE YEAR(fecha) BETWEEN 2007 AND 2010
 GROUP BY c.cod_cliente,
		 ape_cliente + ' ' + nom_cliente
HAVING AVG(cantidad * d.pre_unitario) < (SELECT AVG(cantidad * pre_unitario)
										   FROM facturas f1 
										   JOIN detalle_facturas d1 ON f1.nro_factura = d1.nro_factura
										  WHERE cod_cliente=c.cod_cliente); -- Ref. Externa
--Reultado: 8 filas
--3	 Abarca Hector		   2009-08-01	2009-08-01 00:00:00	237.40
--7	 Paez Roque			   2008-03-08 	2010-08-10 00:00:00	390.10
--10 Moriel Roberto		   2008-03-08   2010-08-10 00:00:00	146.00
--1	 Perez Rodolfo		   2007-02-13 	2009-08-04 00:00:00	363.00
--4	 Morales Santiago	   2008-02-15 	2010-08-07 00:00:00	123.70
--2	 Castillo Marta Analia 2008-02-08 	2010-08-05 00:00:00	416.45
--5	 Perez Carlos Antonio  2007-02-14 	2010-07-31 00:00:00	344.55
--8	 Luque Elvira Josefa   2009-08-01 	2010-07-31 00:00:00	111.60

/*------------------------------------------------------------------------------------------------
  8. Realice un informe que muestre cuanto fue el total anual facturado por cada vendedor, para 
  los casos en que el nombre de vendedor no comience con ‘B’ ni con ‘M’, que los nros. de facturas 
  oscilen entre 5 y 25 y que el promedio del monto facturado sea inferior al promedio de ese anio.
 -------------------------------------------------------------------------------------------------*/
SELECT f.cod_vendedor,
	   ape_vendedor + ' ' + nom_vendedor 'Vendedor',
       YEAR(fecha)'A?o',
	   SUM(cantidad * d.pre_unitario) 'Facturaci?n Total'
  FROM facturas f 
  JOIN detalle_facturas d ON f.nro_factura = d.nro_factura 
  JOIN vendedores v ON f.cod_vendedor = v.cod_vendedor
 WHERE nom_vendedor NOT LIKE '[b,m]%' 
   AND f.nro_factura BETWEEN 5 AND 25
 GROUP BY f.cod_vendedor,
		  ape_vendedor + ' ' + nom_vendedor,
		  YEAR(fecha)
 HAVING AVG(cantidad * d.pre_unitario) < (SELECT AVG(cantidad * pre_unitario)
										    FROM facturas fa 
											JOIN detalle_facturas de ON fa.nro_factura = de.nro_factura
										   WHERE YEAR(fecha)=YEAR(f.fecha));
--Resultado: 2 filas
--3	Lopez Alejandro	2001	185.00
--3	Lopez Alejandro	2002	135.00