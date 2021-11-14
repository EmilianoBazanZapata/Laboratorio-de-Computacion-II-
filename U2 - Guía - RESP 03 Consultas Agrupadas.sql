/*------------------------------------------------------------------------------------------------
  Guia de Ejercicios CONSULTAS AGRUPADAS
-------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------  
  1. Por cada factura emitida mostrar la cantidad total de artículos vendidos 
  (suma de las cantidades vendidas), la cantidad ítems que tiene cada factura en el detalle 
  (cantidad de registros de detalles) y el Importe total. 
-------------------------------------------------------------------------------------------------*/
SELECT fecha, COUNT(*) 'Cant. de facturas' 
  FROM facturas 
 GROUP BY fecha;

-- Cantidad de facturas por año
SELECT YEAR(fecha), COUNT(*) 'Cant. de facturas'
  FROM facturas
 GROUP BY YEAR(fecha);

-- Cantidad de facturas emitidas por cada vendedor ademas de la primer venta que hizo c/u
SELECT v.cod_vendedor,
       ape_vendedor + ' ' + nom_vendedor 'Vendedor',
       COUNT(*) 'Cant. de facturas',
       MIN(fecha) 'Primer Venta'
  FROM facturas f, vendedores v
 WHERE f.cod_vendedor = v.cod_vendedor
 GROUP BY v.cod_vendedor, ape_vendedor + ' ' + nom_vendedor;

-- Ingresos mensuales este año
SELECT MONTH(fecha) Mes, SUM(cantidad * pre_unitario) 'Importe'
  FROM detalle_facturas d, facturas f
 WHERE f.nro_factura = d.nro_factura
   AND YEAR(fecha) = YEAR(getdate())
 GROUP BY MONTH(fecha);

-- Cantidad de clientes
SELECT * 
  FROM clientes;
  
SELECT COUNT(*) 
  FROM clientes;
  
-- Es lo mismo que
SELECT COUNT(ape_cliente) 
  FROM clientes;

-- Cantidad de clientes con tel conocido
SELECT COUNT(nro_tel) 
  FROM clientes;

SELECT COUNT([e-mail]) 
  FROM clientes;

/*------------------------------------------------------------------------------------------------
  2. Se quiere saber en este negocio, cuánto se factura: 
  a) Diariamente 
  b) Mensualmente 
  c) Anualmente 
-------------------------------------------------------------------------------------------------*/
--a.Diariamente 
SELECT fecha Día, SUM(cantidad * pre_unitario) 'Importe Mensual'
  FROM detalle_facturas d, facturas f
 WHERE d.nro_factura = f.nro_factura
 GROUP BY fecha;

--b.Mensualmente 
SELECT YEAR(fecha) Año,
       MONTH(fecha) Mes,
       SUM(cantidad * pre_unitario) 'Importe Mensual'
  FROM detalle_facturas d, facturas f
 WHERE d.nro_factura = f.nro_factura
 GROUP BY YEAR(fecha), MONTH(fecha)
 ORDER BY 1, 2;

--c.Anualmente 
SELECT YEAR(fecha) A�o, SUM(cantidad * pre_unitario) 'Importe Mensual'
  FROM detalle_facturas d, facturas f
 WHERE d.nro_factura = f.nro_factura
 GROUP BY YEAR(fecha ORDER BY 1;
SELECT fecha, COUNT(*) 'Cant. de Facturas'
  FROM facturas
 WHERE MONTH(fecha) not in (1, 7, 12)
 GROUP BY fecha;

/*------------------------------------------------------------------------------------------------
  3. Emitir un listado de la cantidad de facturas confeccionadas diariamente, correspondiente 
  a los meses que no sean enero, julio ni diciembre. Ordene por la cantidad de facturas en forma 
  descendente y fecha. 
-------------------------------------------------------------------------------------------------*/
SELECT fecha, COUNT(*) 'Cant. de Facturas'
  FROM facturas
 WHERE MONTH(fecha) NOT IN (1, 7, 12)
 GROUP BY fecha
  
/*------------------------------------------------------------------------------------------------
  4. Mostrar la cantidad total de artículos vendidos, el importe total vendido 
  y la fecha de la primera venta por cliente, para nombres de cliente que no empiecen con “p”. 
-------------------------------------------------------------------------------------------------*/
SELECT c.cod_cliente 'Codigo',
       ape_cliente + ' ' + nom_cliente 'Cliente',
       SUM(cantidad) 'Cant. de art. vendidos',
       SUM(Cantidad * pre_unitario) 'Importe Total',
       MIN(fecha) 'Primer venta'
  FROM facturas f, detalle_facturas d, clientes c
 WHERE f.nro_factura = d.nro_factura
   AND c.cod_cliente = f.cod_cliente
   AND nom_cliente not LIKE 'p%'
 GROUP BY c.cod_cliente, ape_cliente + ' ' + nom_cliente;

/*------------------------------------------------------------------------------------------------
  5. Se quiere saber la cantidad y el importe promedio vendido por fecha y cliente, para códigos 
  de vendedor superiores a 2. Ordene por fecha y cliente. 
-------------------------------------------------------------------------------------------------*/
SELECT fecha 'Fecha Factura',
       c.cod_cliente 'Codigo Cliente',
       ape_cliente + ' ' + nom_cliente 'Cliente',
       SUM(cantidad) 'Cantidad total',
       AVG(cantidad) 'Promedio de cantidades',
       AVG(cantidad * pre_unitario) 'Importe promedio'
  FROM facturas f, detalle_facturas d, clientes c
 WHERE f.nro_factura = d.nro_factura
   AND c.cod_cliente = f.cod_cliente
   AND cod_vendedor > 2
 GROUP BY fecha, c.cod_cliente, ape_cliente + ' ' + nom_cliente
 ORDER BY 1, 2;

/*------------------------------------------------------------------------------------------------
  5. Se quiere saber el importe promedio vendido y la cantidad total vendida por fecha y artículo, 
  para códigos de cliente inferior a 3. Ordene por fecha y artículo. 
-------------------------------------------------------------------------------------------------*/
SELECT fecha 'Fecha Factura',
       a.cod_articulo 'Codigo Artaculo',
       descripcion 'Descripcion',
       AVG(cantidad * d.pre_unitario) 'Importe promedio',
       SUM(cantidad) 'Cantidad total'
  FROM facturas f, detalle_facturas d, articulos a
 WHERE f.nro_factura = d.nro_factura
   AND a.cod_articulo = d.cod_articulo
   AND cod_cliente < 3
 GROUP BY fecha, a.cod_articulo, descripcion
 ORDER BY 1, 2;

/*------------------------------------------------------------------------------------------------
  6. Listar la cantidad total vendida, el importe total vendido y el importe promedio total vendido
  por número de factura, siempre que la fecha no oscile entre el 13/2/2007 y el 13/7/2010. 
-------------------------------------------------------------------------------------------------*/
SELECT f.nro_factura 'Nro.Factura',
       SUM(cantidad) 'Cantidad total',
       SUM(cantidad * pre_unitario) 'Importe total',
       AVG(cantidad * pre_unitario) 'Importe promedio'
  FROM facturas f, detalle_facturas d
 WHERE d.nro_factura = f.nro_factura
   AND fecha not BETWEEN '13/02/2007' AND '13/07/2010'
 GROUP BY f.nro_factura;

/*------------------------------------------------------------------------------------------------
  8. Mostrar la cantidad de ventas para meses que oscilen entre julio y noviembre:
  a)	Por fecha y vendedor.
  b)	Por vendedor y fecha.
  Ordene por los mismos campos por los que agrupa.
-------------------------------------------------------------------------------------------------*/
--a)
SELECT fecha,
       f.cod_vendedor 'Cod.Vendedor',
       ape_vendedor + ' ' + nom_vendedor 'Nombre',
       COUNT(*) 'Cantidad de facturas'
  FROM facturas f, vendedores v
 WHERE MONTH(fecha) BETWEEN 7 AND 11
   AND f.cod_vendedor = v.cod_vendedor
 GROUP BY fecha, f.cod_vendedor, ape_vendedor + ' ' + nom_vendedor
 ORDER BY 1, 2;

--b)
SELECT f.cod_vendedor 'Cod.Vendedor',
       ape_vendedor + ' ' + nom_vendedor 'Nombre',
       fecha,
       COUNT(*) 'Cantidad de facturas'
  FROM facturas f, vendedores v
 WHERE MONTH(fecha) BETWEEN 7 AND 11
   AND f.cod_vendedor = v.cod_vendedor
 GROUP BY f.cod_vendedor, ape_vendedor + ' ' + nom_vendedor, fecha
 ORDER BY 1, 3;

/*------------------------------------------------------------------------------------------------
  9. Emitir un reporte que muestre la fecha de la primer y última venta y el importe comprado por 
  cliente. Rotule como CLIENTE, PRIMER VENTA, ÚLTIMA VENTA, IMPORTE. 
-------------------------------------------------------------------------------------------------*/
SELECT c.cod_cliente 'Codigo Cliente',
       ape_cliente + ' ' + nom_cliente 'Cliente',
       MIN(fecha) 'Primer vta.',
       MAX(fecha) 'Ultima vta.',
       SUM(cantidad * pre_unitario) 'Importe'
  FROM clientes c, facturas f, detalle_facturas d
 WHERE c.cod_cliente = f.cod_cliente
   AND f.nro_factura = d.nro_factura
 GROUP BY c.cod_cliente, ape_cliente + ' ' + nom_cliente;
--10 filas

/*------------------------------------------------------------------------------------------------
  10. Se quiere saber el importe total vendido, la cantidad total vendida y el precio unitario 
  promedio por cliente y artículo, siempre que el nombre del cliente comience con letras que van 
  de la “a” a la “m”. Ordene por cliente, precio unitario promedio en forma descendente y artículo. 
  Rotule como IMPORTE TOTAL, CANTIDAD TOTAL, PRECIO PROMEDIO. 
-------------------------------------------------------------------------------------------------*/
SELECT c.cod_cliente 'Cod.Cliente',
       ape_cliente + ' ' + nom_cliente 'Cliente',
       a.cod_articulo 'Cod.articulo',
       descripcion,
       SUM(cantidad * d.pre_unitario) Importe,
       SUM(cantidad) 'Cantidad total',
       AVG(d.pre_unitario) 'Precio promedio'
  FROM clientes c, articulos a, detalle_facturas d, facturas f
 WHERE c.cod_cliente = f.cod_cliente
   AND f.nro_factura = d.nro_factura
   AND a.cod_articulo = d.cod_articulo
   AND nom_cliente LIKE '[a-m]%'
 GROUP BY c.cod_cliente,
          ape_cliente + ' ' + nom_cliente,
          a.cod_articulo,
          descripcion
 ORDER BY 1, [Precio promedio] desc, a.cod_articulo;
--98 filas

/*------------------------------------------------------------------------------------------------
  11. Mostrar la fecha de la primera venta y la cantidad de ventas (cantidad de registros en el 
  detalle) por vendedor, para el año pasado. 
-------------------------------------------------------------------------------------------------*/
SELECT f.cod_vendedor 'Cod.vendedor',
       ape_vendedor + ' ' + nom_vendedor 'Nombre Vendedor',
       MIN(fecha) 'Primer Vta.',
       COUNT(*) 'Cantidad de ventas'
  FROM detalle_facturas d, facturas f, vendedores v
 WHERE YEAR(fecha) = YEAR(getdate()) - 1
   AND f.nro_factura = d.nro_factura
   AND v.cod_vendedor = f.cod_vendedor
 GROUP BY f.cod_vendedor, ape_vendedor + ' ' + nom_vendedor;

/*------------------------------------------------------------------------------------------------
  12. Se quiere saber la cantidad de facturas y la fecha la primer y última factura por vendedor 
  y cliente, para números de factura que oscilan entre 5 y 30. Ordene por vendedor, cantidad de 
  ventas en forma descendente y cliente.
-------------------------------------------------------------------------------------------------*/
SELECT f.cod_vendedor,
       ape_vendedor + ' ' + nom_vendedor Vendedor,
       c.cod_cliente,
       ape_cliente + ' ' + nom_cliente Cliente,
       COUNT(*) 'Cant.Facturas',
       MIN(fecha) 'Primer factura',
       MAX(fecha) 'Ultima factura'
  FROM facturas f, clientes c, vendedores v
 WHERE f.nro_factura BETWEEN 5 AND 30
   AND f.cod_cliente = c.cod_cliente
   AND f.cod_vendedor = v.cod_vendedor
 GROUP BY f.cod_vendedor,
          ape_vendedor + ' ' + nom_vendedor,
          c.cod_cliente,
          ape_cliente + ' ' + nom_cliente;
