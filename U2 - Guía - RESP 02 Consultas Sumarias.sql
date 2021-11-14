/*------------------------------------------------------------------------------------------------
  Guia de Ejercicios CONSULTAS SUMARIAS
-------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------
  1. Se quiere saber la cantidad de clientes que hay en la empresa
-------------------------------------------------------------------------------------------------*/
SELECT COUNT(*) 'Cant. de Clientes' 
  FROM clientes;

/*------------------------------------------------------------------------------------------------
  2. Se quiere saber que cantidad de vendedores hay en la empresa.
-------------------------------------------------------------------------------------------------*/
SELECT COUNT(*) 'Cant. de Vendedores' 
  FROM vendedores;

/*------------------------------------------------------------------------------------------------
  3. Se quiere saber el promedio de la cantidad total de articulos vendidos.
-------------------------------------------------------------------------------------------------*/
SELECT AVG(cantidad) 'Promedio' 
  FROM detalle_facturas;

/*------------------------------------------------------------------------------------------------
  4. Se quiere saber la cantidad de ventas que hizo el vendedor de codigo 3.
-------------------------------------------------------------------------------------------------*/
SELECT COUNT(*) 'Cantidad de Ventas' 
  FROM facturas 
 WHERE cod_vendedor = 3;

/*------------------------------------------------------------------------------------------------
  5. ¿Cual fue la fecha de la primera y ultima venta que se realizo en este negocio?.
-------------------------------------------------------------------------------------------------*/
SELECT MAX(fecha) 'Ultima Venta', 
       MIN(fecha) 'Primer Venta' 
  FROM facturas;

/*------------------------------------------------------------------------------------------------
  6.  Se quiere saber cual fue la maxima y la minima cantidad que se vendio para el articulo 8.
-------------------------------------------------------------------------------------------------*/
SELECT MAX(cantidad) Maxima, 
       MIN(cantidad) Minima
  FROM detalle_facturas
 WHERE cod_articulo = 8;

/*------------------------------------------------------------------------------------------------
  7. Mostrar la siguiente información respecto a la factura nro.: 450: cantidad total de unidades 
  vendidas, la cantidad de artículos diferentes vendidos y el importe total.
-------------------------------------------------------------------------------------------------*/
SELECT SUM(cantidad) 'Cant.total de un. vendidas',
       COUNT(*) 'Cant. art. diferentes',
       SUM(cantidad * pre_unitario) 'Importe Total'
  FROM detalle_facturas
 WHERE nro_factura = 450;

SELECT cantidad, cantidad * pre_unitario
  FROM detalle_facturas
 WHERE nro_factura = 450;
 
/*------------------------------------------------------------------------------------------------
  8. ¿Cuál fue el cantidad total de unidades vendidas, importe total y el importe promedio para 
  vendedores cuyo nombres comienzan con letras que van de la “d” a la “l”?
-------------------------------------------------------------------------------------------------*/
SELECT SUM(d.cantidad) 'Cant. Total vendida',
       SUM(cantidad * d.pre_Unitario) 'Importe Total',
       AVG(d.pre_unitario * cantidad) 'Importe Promedio'
  FROM detalle_facturas d, facturas f, vendedores v
 WHERE d.nro_factura = f.nro_factura
   AND f.cod_vendedor = v.cod_vendedor
   AND nom_vendedor LIKE '[d-l]%';

/*------------------------------------------------------------------------------------------------
  9. Obtener el promedio y el monto vendido de toda la facturación de este negocio. Mostrar además 
  la cantidad de unidades vendidas y el promedio de las unidades vendidas.
-------------------------------------------------------------------------------------------------*/
SELECT AVG(Cantidad * pre_unitario) 'Promedio del monto',
       SUM(Cantidad * pre_unitario) 'Monto Vendido',
       COUNT(Cantidad) 'Cant.Vendida',
       AVG(cantidad) 'Promedio de Cant.'
  FROM detalle_facturas;
  
/*------------------------------------------------------------------------------------------------
  10.	Se quiere saber el importe total vendido, el promedio del importe vendido y la cantidad 
  total de artículos vendidos para el cliente Roque Paez. 
-------------------------------------------------------------------------------------------------*/
SELECT SUM(cantidad * pre_unitario) 'Importe Total',
       AVG(Cantidad * pre_unitario) 'Importe Promedio',
       SUM(Cantidad) 'Cant. total'
  FROM detalle_facturas d, facturas f, clientes c
 WHERE d.nro_factura = f.nro_factura
   AND f.cod_cliente = c.cod_cliente
   AND c.ape_cliente = 'Paez'
   AND c.nom_cliente = 'Roque';

/*------------------------------------------------------------------------------------------------
  11.	Mostrar la fecha de la primera venta, la cantidad total vendida y el importe total vendido 
  para los artículos que empiecen con “C”. 
-------------------------------------------------------------------------------------------------*/
SELECT MIN(fecha) '1er. Venta',
       SUM(cantidad) 'Cant Vendida',
       SUM(Cantidad * d.pre_unitario) 'Importe Total'
  FROM detalle_facturas d, facturas f, articulos a
 WHERE d.nro_factura = f.nro_factura
   AND d.cod_articulo = a.cod_articulo
   AND descripcion LIKE 'C%';

/*------------------------------------------------------------------------------------------------
  12.	Se quiere saber la cantidad total de artículos vendidos y el importe total vendido para el 
  periodo del 15/06/2008 al 15/06/2011. 
-------------------------------------------------------------------------------------------------*/
SELECT SUM(cantidad) 'Cant. Vendida',
       SUM(cantidad * pre_unitario) 'Importe Total'
  FROM detalle_facturas d, facturas f
 WHERE d.nro_factura = f.nro_factura
   AND fecha BETWEEN '15/06/2008' AND '15/06/2011';

/*------------------------------------------------------------------------------------------------
  13.	Se quiere saber la cantidad de veces y la última vez que vino el cliente de apellido Abarca 
  y cuánto gastó en total. 
-------------------------------------------------------------------------------------------------*/
SELECT COUNT(*) 'Cant de veces que vino', MAX(fecha) 'Ultima vez que vino'
  FROM facturas f, clientes c
 WHERE ape_cliente = 'abarca'
   AND c.cod_cliente = f.cod_cliente;

SELECT SUM(Cantidad * pre_unitario) 'Gasto Total'
  FROM detalle_facturas d, facturas f, clientes c
 WHERE d.nro_factura = f.nro_factura
   AND f.cod_cliente = c.cod_cliente
   AND ape_cliente = 'abarca';

/*------------------------------------------------------------------------------------------------
  14.	Mostrar el importe total y el promedio del importe para los clientes cuya dirección de mail 
  es conocida.
-------------------------------------------------------------------------------------------------*/
SELECT SUM(cantidad * pre_unitario) 'Importe Total',
       AVG(cantidad * pre_unitario) 'Promedio del Importe'
  FROM detalle_facturas d, facturas f, clientes c
 WHERE d.nro_factura = f.nro_factura
   AND c.cod_cliente = f.cod_cliente
   AND c.[e-mail] is not null;

/*------------------------------------------------------------------------------------------------
  15.	Obtener la siguiente información: el importe total vendido y el importe promedio vendido 
  para números de factura que no sean los siguientes: 13, 5, 17, 33, 24. 
-------------------------------------------------------------------------------------------------*/
SELECT SUM(cantidad * pre_unitario) 'Importe Total',
       AVG(cantidad * pre_unitario) 'Promedio'
  FROM detalle_facturas
 WHERE nro_factura not in (13, 5, 17, 33, 24);

/*------------------------------------------------------------------------------------------------
  16.	El encargado del negocio quiere saber cuánto fue la facturación del año pasado. Por otro 
  lado cuánto es la facturación del mes pasado, la de este mes y la de hoy. 
-------------------------------------------------------------------------------------------------*/
-- Año Pasado
SELECT SUM(cantidad * pre_unitario) Total
  FROM detalle_facturas d, facturas f
 WHERE YEAR(fecha) = YEAR(getdate()) - 1
   AND d.nro_factura = f.nro_factura;

-- Mes pasado. se puede resolver de 2 formas 
-- Opcion A:
SELECT SUM(cantidad * pre_unitario), 'Mes Pasado'
  FROM detalle_facturas d, facturas f
 WHERE d.nro_factura = f.nro_factura
   AND YEAR(fecha) = YEAR(DATEADD(MONTH, -1, GETDATE()))
   AND MONTH(fecha) = MONTH(DATEADD(MONTH, -1, GETDATE()));

-- Opcion B:
SELECT SUM(cantidad * pre_unitario), 'Mes Pasado'
  FROM detalle_facturas d, facturas f
 WHERE d.nro_factura = f.nro_factura
   AND DATEDIFF(MONTH, fecha, getdate()) = 1;

SELECT SUM(cantidad * pre_unitario), 'Mes Actual'
  FROM detalle_facturas, facturas
 WHERE MONTH(fecha) = MONTH(getdate())
   AND YEAR(fecha) = YEAR(getdate())
   AND d.nro_factura = f.nro_factura;

SELECT SUM(cantidad * pre_unitario), 'Hoy'
  FROM detalle_facturas, facturas
 WHERE fecha = getdate()
   AND d.nro_factura = f.nro_factura;

/*------------------------------------------------------------------------------------------------
  17.	Se quiere saber la cantidad de ventas, la cantidad total vendida y el importe promedio 
  vendido para una factura determinada por ejemplo la nro. 512.
-------------------------------------------------------------------------------------------------*/
SELECT COUNT(*) 'Cantidad de ventas',
       SUM(Cantidad * pre_unitario) 'Importe Total',
       AVG(cantidad * pre_unitario) Promedio
  FROM detalle_facturas
 WHERE nro_factura = 512;




