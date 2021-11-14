/*------------------------------------------------------------------------------------------------
  Guia de Ejercicios CONSULTAS CON COMPOSICION JOIN
-------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------
  1. Genere un reporte con los datos de la facturaci�n (datos de las facturas incluidos los del 
  vendedor y cliente) de los a�os 2006, 2007, 2009 y 2012. 
-------------------------------------------------------------------------------------------------*/
SELECT nro_factura,
       fecha,
       nom_vendedor + ', ' + ape_vendedor,
       ape_cliente + ', ' + nom_cliente
  FROM clientes c
  JOIN facturas f
    ON f.cod_cliente = c.cod_cliente
  JOIN vendedores v
    ON f.cod_vendedor = v.cod_vendedor
 WHERE YEAR(fecha) IN (2006, 2007, 2009, 2012);

/*------------------------------------------------------------------------------------------------
  2. Liste los datos de la facturaci�n, de los art�culos y de la venta de las facturas 
  correspondientes al mes pasado. 
-------------------------------------------------------------------------------------------------*/
SELECT f.nro_factura,
       fecha,
       descripcion,
       cantidad,
       d.pre_unitario,
       cantidad * d.pre_unitario 'Importe'
  FROM facturas f
  JOIN detalle_facturas d
    ON f.nro_factura = d.nro_factura
  JOIN articulos a
    ON d.cod_articulo = a.cod_articulo
 WHERE MONTH(fecha) = MONTH(GETDATE()) - 1;
   
/*------------------------------------------------------------------------------------------------
  3. Emita un listado con los datos del vendedor y las ventas que ha realizado en lo que va 
  del a�o. Muestre los vendedores aun as� no tengan ventas registradas en el a�o solicitado. 
-------------------------------------------------------------------------------------------------*/
SELECT v.cod_vendedor,
       nom_vendedor + ', ' + ape_vendedor,
       fecha,
       nro_factura
  FROM vendedores v
  LEFT JOIN facturas f
    ON v.cod_vendedor = f.cod_vendedor
   AND YEAR(fecha) = 2012;
   
/*------------------------------------------------------------------------------------------------
  4. Liste descripci�n, cantidad e importe; aun para aquellos art�culos que no registran ventas. 
-------------------------------------------------------------------------------------------------*/
SELECT descripcion, 
       cantidad, 
       d.pre_unitario * cantidad 'Importe'
  FROM articulos a
  LEFT JOIN detalle_facturas d
    ON a.cod_articulo = d.cod_articulo;
    
/*------------------------------------------------------------------------------------------------
  5. Genere un reporte con los datos de la facturaci�n (datos de las facturas incluidos los del 
  vendedor y cliente) y de la venta (incluido el importe); para las ventas de febrero y marzo de 
  los a�os 2006 y 2007 y siempre que el art�culo empiece con letras que van de la �a� a la �m�. 
  Ordene por fecha, cliente y art�culo. 
-------------------------------------------------------------------------------------------------*/
SELECT f.nro_factura,
       fecha,
       nom_vendedor + ', ' + ape_vendedor,
       ape_cliente + ', ' + nom_cliente Cliente,
       descripcion,
       cantidad,
       cantidad * d.pre_unitario
  FROM facturas f
  JOIN vendedores v
    ON f.cod_vendedor = v.cod_vendedor
  JOIN clientes c
    ON f.cod_cliente = c.cod_cliente
  JOIN detalle_facturas d
    ON f.nro_factura = d.nro_factura
  JOIN articulos a
    ON a.cod_articulo = d.cod_articulo
 WHERE YEAR(fecha) IN (2006, 2007)
   AND MONTH(fecha) IN (2, 3)
   AND descripcion LIKE '[a-m]%'
 ORDER BY fecha, ape_cliente + ', ' + nom_cliente, descripcion;
 
/*------------------------------------------------------------------------------------------------
  6. Liste c�digo de cliente, nombre, fecha y factura para las ventas del a�o 2007. Muestre los 
  clientes hayan comprado o no en ese a�o. 
-------------------------------------------------------------------------------------------------*/
SELECT c.cod_cliente,
       ape_cliente + ', ' + nom_cliente Cliente,
       fecha,
       nro_factura
  FROM clientes c
  LEFT JOIN facturas f
    ON f.cod_cliente = c.cod_cliente
 WHERE YEAR(fecha) = 2007;

/*------------------------------------------------------------------------------------------------
  7. Se quiere saber los art�culos que compro la cliente Elvira L�pez en lo que va del a�o. 
  Liste art�culo, observaciones e importe. 
-------------------------------------------------------------------------------------------------*/
SELECT descripcion, observaciones, d.pre_unitario * cantidad 'Importe'
  FROM articulos a
  JOIN detalle_facturas d
    ON a.cod_articulo = d.cod_articulo
  JOIN facturas f
    ON f.nro_factura = d.nro_factura
  JOIN clientes c
    ON c.cod_cliente = f.cod_cliente
 WHERE YEAR(fecha) = YEAR(GETDATE())
   AND c.ape_cliente = 'L�pez'
   AND c.nom_cliente = 'Elvira';
   
/*------------------------------------------------------------------------------------------------
  8. Se quiere saber los art�culos que compraron los clientes cuyos apellidos empiezan con �p�. 
  Liste cliente, articulo, cantidad e importe. Ordene por cliente y art�culo, este en forma 
  descendente. Rotule como CLIENTE, ARTICULO, CANTIDAD, IMPORTE. 
-------------------------------------------------------------------------------------------------*/
SELECT ape_cliente + ', ' + nom_cliente 'CLIENTE',
       descripcion 'ARTICULO',
       cantidad 'CANTIDAD',
       cantidad * d.pre_unitario 'IMPORTE'
  FROM articulos a
  JOIN detalle_facturas d
    ON a.cod_articulo = d.cod_articulo
  JOIN facturas f
    ON f.nro_factura = d.nro_factura
  JOIN clientes c
    ON c.cod_cliente = f.cod_cliente
 WHERE ape_cliente + ', ' + nom_cliente LIKE 'p%'
 ORDER BY ape_cliente + ', ' + nom_cliente, descripcion DESC;

/*------------------------------------------------------------------------------------------------
  9. Emitir un listado de los art�culos que vendieron los vendedores Ledesma, Mariela y L�pez, 
  Alejandro. 
-------------------------------------------------------------------------------------------------*/
SELECT a.cod_articulo, descripcion, nom_vendedor + ', ' + ape_vendedor
  FROM articulos a
  JOIN detalle_facturas d
    ON a.cod_articulo = d.cod_articulo
  JOIN facturas f
    ON f.nro_factura = d.nro_factura
  JOIN vendedores v
    ON v.cod_vendedor = f.cod_vendedor
 WHERE (v.ape_vendedor = 'Ledesma' AND v.nom_vendedor = 'Mariela')
    OR (v.ape_vendedor = 'L�pez' AND v.nom_vendedor = 'Alejandro');

/*------------------------------------------------------------------------------------------------
  10. Listar todos los clientes (incluidos los que nunca compraron) y los a�os de compra. 
  No muestre registros repetidos.
-------------------------------------------------------------------------------------------------*/
SELECT distinct ape_cliente + ', ' + nom_cliente Cliente, YEAR(fecha) 'A�o'
  FROM clientes c
  LEFT JOIN facturas f
    ON c.cod_cliente = f.cod_cliente;

