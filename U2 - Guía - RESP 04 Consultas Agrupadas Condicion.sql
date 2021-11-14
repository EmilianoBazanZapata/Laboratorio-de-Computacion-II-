/*------------------------------------------------------------------------------------------------
  Guia de Ejercicios CONSULTAS AGRUPADAS CON CONDICIÓN
-------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------   
  1. Se quiere saber la fecha de la primera venta, la cantidad total vendida y el importe total 
  vendido por vendedor para los casos en que el promedio de la cantidad vendida sea inferior 
  o igual a 56. 
-------------------------------------------------------------------------------------------------*/   
SELECT v.cod_vendedor,
       ape_vendedor + ' ' + nom_vendedor 'VENDEDOR',
       MIN(fecha) 'PRIMERA VENTA',
       SUM(cantidad) 'CANTIDAD TOTAL',
       SUM(pre_unitario * cantidad) 'IMPORTE TOTAL'
  FROM vendedores v, facturas f, detalle_facturas d
 WHERE v.cod_vendedor = f.cod_vendedor
   AND f.nro_factura = d.nro_factura
 GROUP BY v.cod_vendedor, ape_vendedor + ' ' + nom_vendedor
HAVING AVG(cantidad) <= 56;

/*------------------------------------------------------------------------------------------------
  2. Liste el importe máximo y mínimo e importe total por factura y por cliente donde el importe 
  total sea entre 100 y 500.
-------------------------------------------------------------------------------------------------*/ 
SELECT f.nro_factura,
       c.cod_cliente,
       ape_cliente + ' ' + nom_cliente 'Cliente',
       MAX(pre_unitario * cantidad) 'Importe maximo',
       MIN(pre_unitario * cantidad) 'Importe minimo',
       SUM(cantidad * pre_unitario) 'Importe total'
  FROM facturas f, clientes c, detalle_facturas d
 WHERE f.nro_factura = d.nro_factura
   AND c.cod_cliente = f.cod_cliente
 GROUP BY f.nro_factura, c.cod_cliente, ape_cliente + ' ' + nom_cliente
HAVING SUM(pre_unitario * cantidad) BETWEEN 100 AND 500;

/*------------------------------------------------------------------------------------------------
  3. Se necesita un listado que informe sobre el monto máximo, mínimo y total que gastó en esta 
  librería cada cliente el año pasado, pero solo donde el importe total gastado por esos clientes 
  esté entre 300 y 800. 
-------------------------------------------------------------------------------------------------*/  
SELECT f.nro_factura,
       c.cod_cliente,
       ape_cliente + ' ' + nom_cliente 'Cliente',
       MAX(pre_unitario * cantidad) 'Importe maximo',
       MIN(pre_unitario * cantidad) 'Importe minimo',
       SUM(cantidad * pre_unitario) 'Importe total'
  FROM facturas f, clientes c, detalle_facturas d
 WHERE f.nro_factura = d.nro_factura
   AND c.cod_cliente = f.cod_cliente
   AND YEAR(f.fecha) = YEAR(GETDATE())-1
 GROUP BY f.nro_factura, c.cod_cliente, ape_cliente + ' ' + nom_cliente
HAVING SUM(pre_unitario * cantidad) BETWEEN 300 AND 800;
 
/*------------------------------------------------------------------------------------------------
  4. Muestre la cantidad de ventas por vendedor y fecha; para los casos en esa cantidad de 
  ventas sea superior a 1.
-------------------------------------------------------------------------------------------------*/  
SELECT v.cod_vendedor,
       ape_vendedor + ' ' + nom_vendedor 'VENDEDOR',
       f.fecha,
       COUNT(*) 'Cantidad de ventas'
  FROM vendedores v, facturas f
 WHERE v.cod_vendedor = f.cod_vendedor
 GROUP BY v.cod_vendedor, ape_vendedor + ' ' + nom_vendedor, f.fecha
HAVING COUNT(*) > 1;

/*------------------------------------------------------------------------------------------------
  5. Desde la administración se solicita un reporte que muestre el precio promedio, el importe 
  total y el promedio del importe vendido por artículo que no comiencen con no comiencen con “c”, 
  que su cantidad total vendida sea 100 o más o que ese importe total vendido sea superior a 700. 
-------------------------------------------------------------------------------------------------*/  
SELECT a.cod_articulo,
       a.descripcion,
       AVG(d.pre_unitario) 'Precio promedio',
       SUM(cantidad * d.pre_unitario) 'Importe total',
       AVG(cantidad * d.pre_unitario) 'Promedio total'
  FROM articulos a, detalle_facturas d
 WHERE a.cod_articulo = d.cod_articulo
   AND a.descripcion NOT LIKE 'c%'
 GROUP BY a.cod_articulo, a.descripcion
HAVING SUM(cantidad) >= 100 
    OR SUM(cantidad * d.pre_unitario) > 700;
 
/*------------------------------------------------------------------------------------------------
  6. Muestre en un listado la cantidad total de artículos vendidos, el importe total y la fecha 
  de la primer y última venta por cada cliente, para lo números de factura que no sean los 
  siguientes: 2, 12, 20, 17, 30 y que el promedio de la cantidad vendida oscile entre 2 y 6. 
-------------------------------------------------------------------------------------------------*/   
SELECT c.cod_cliente,
       ape_cliente + ' ' + nom_cliente 'Cliente',
       SUM(cantidad) 'Cantidad total',
       SUM(cantidad * pre_unitario) 'Importe total',
       MIN(fecha) 'Primer venta',
       MAX(fecha) 'Ultima venta'
  FROM clientes c, facturas f, detalle_facturas d
 WHERE c.cod_cliente = f.cod_cliente
   AND f.nro_factura = d.nro_factura
   AND f.nro_factura notin(2, 12, 20, 17, 30)
 GROUP BY c.cod_cliente, ape_cliente + ' ' + nom_cliente
HAVING AVG(cantidad) BETWEEN 2 AND 6;

/*------------------------------------------------------------------------------------------------
  7. Emitir un listado que muestre la cantidad total de artículos vendidos, el importe total 
  vendido y el promedio del importe vendido por vendedor y por cliente; para los casos en que el 
  importe total vendido esté entre 200 y 600 y para códigos de cliente que oscilen entre 1 y 5.
-------------------------------------------------------------------------------------------------*/   
SELECT c.cod_cliente,
       ape_cliente + ' ' + nom_cliente 'CLIENTE',
       v.cod_vendedor,
       ape_vendedor + ' ' + nom_vendedor 'Vendedor',
       SUM(cantidad) 'Cantidad total',
       SUM(pre_unitario * cantidad) 'Importe total',
       AVG(cantidad * pre_unitario) 'Promedio total'
  FROM clientes c, detalle_facturas d, vendedores v, facturas f
 WHERE f.nro_factura = d.nro_factura
   AND f.cod_cliente = c.cod_cliente
   AND f.cod_vendedor = v.cod_vendedor
   AND c.cod_cliente BETWEEN 1 AND 5
 GROUP BY c.cod_cliente,
          ape_cliente + ' ' + nom_cliente,
          v.cod_vendedor,
          ape_vendedor + ' ' + nom_vendedor
HAVING SUM(pre_unitario * cantidad) BETWEEN 200 AND 600;

/*------------------------------------------------------------------------------------------------
  8. Se quiere saber el importe y el promedio total vendido por factura, para los casos en que la 
  cantidad total vendida sea superior a 50 y que el importe total sea superior a 100. 
  Ordene por importe en forma descendente. Rotule como FACTURA, IMPORTE TOTAL,PROMEDIO.
-------------------------------------------------------------------------------------------------*/   
SELECT nro_factura 'FACTURA',
       SUM(pre_unitario * cantidad) 'IMPORTE TOTAL',
       AVG(cantidad * pre_unitario) 'PROMEDIO'
  FROM detalle_facturas
 GROUP BY nro_factura
HAVING SUM(cantidad) > 50 AND SUM(pre_unitario * cantidad) > 100
 ORDER BY 2 DESC;
 
/*------------------------------------------------------------------------------------------------
  9. Se quiere saber la cantidad total vendida, el precio promedio y el importe total vendido por 
  fecha; para los casos en que el año de la venta sea uno de los siguientes 2008, 2010 o 2011 y 
  que ese importe total sea inferior a 200. Ordene por importe en forma descendente.
-------------------------------------------------------------------------------------------------*/   
SELECT f.fecha 'Fecha',
       SUM(cantidad) 'Cantidad total',
       AVG(pre_unitario) 'Precio Promedio',
       SUM(pre_unitario * cantidad) 'Importe total'
  FROM facturas f, detalle_facturas d
 WHERE f.nro_factura = d.nro_factura andyear(fecha) IN (2008, 2010, 2011)
 GROUP BY f.fecha
HAVING SUM(pre_unitario * cantidad) < 200
 ORDER BY 4 DESC;

/*------------------------------------------------------------------------------------------------
  10. Muestre la cantidad total vendida y el promedio total vendido por cliente y fecha; para los 
  casos en que el importe total vendido sea inferior a 150 y que el promedio de la cantidad 
  vendida sea inferior a 20. Rotule como CLIENTE, FECHA, CANTIDAD, IMPORTE PROMEDIO.
-------------------------------------------------------------------------------------------------*/   
SELECT c.cod_cliente,
       ape_cliente + ' ' + nom_cliente 'CLIENTE',
       f.fecha 'FECHA',
       SUM(cantidad) 'CANTIDAD',
       AVG(cantidad * pre_unitario) 'IMPORTE PROMEDIO'
  FROM clientes c, facturas f, detalle_facturas d
 WHERE f.cod_cliente = c.cod_cliente
   AND f.nro_factura = d.nro_factura
 GROUP BY c.cod_cliente, ape_cliente + ' ' + nom_cliente, f.fecha
HAVING SUM(pre_unitario * cantidad) < 150 AND AVG(cantidad) < 20

/*------------------------------------------------------------------------------------------------
  11. Liste la cantidad total y el promedio de ventas, el importe total y el promedio del importe 
  por vendedor por año, para las ventas realizadas anteriores 1/1/2008 y que el importe total 
  no supere los $ 850.
-------------------------------------------------------------------------------------------------*/   
SELECT v.cod_vendedor,
       ape_vendedor + ' ' + nom_vendedor 'Vendedor',
       YEAR(f.fecha) 'Año',
       SUM(cantidad) 'Cantidad total de vendida',
       AVG(cantidad) 'Promedio de cantidad vendida',
       SUM(pre_unitario * cantidad) 'Importe total',
       AVG(pre_unitario * cantidad) 'Promedio'
  FROM vendedores v, detalle_facturas d, facturas f
 WHERE v.cod_vendedor = f.cod_vendedor
   AND f.nro_factura = d.nro_factura
   AND f.fecha < '01/01/2008'
 GROUP BY v.cod_vendedor, ape_vendedor + ' ' + nom_vendedor, YEAR(f.fecha)
HAVING SUM(pre_unitario * cantidad) <= 850
