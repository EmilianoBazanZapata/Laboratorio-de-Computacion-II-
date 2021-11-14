/*------------------------------------------------------------------------------------------------
  Guia de Ejercicios SUBCONSULTAS WHERE
-------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------
 1. Emitir un listado de los artículos que no fueron vendidos este año. En ese listado solo 
 incluir aquellos cuyo precio unitario del artículo oscile entre 20 y 50.
-------------------------------------------------------------------------------------------------*/
-- Resuelto utilizando NOT EXISTS
SELECT cod_articulo 'Código', descripcion, pre_unitario 'Precio'
  FROM articulos a
 WHERE NOT EXISTS (SELECT cod_articulo
                     FROM facturas f
                     JOIN detalle_facturas d
                       ON d.nro_factura = f.nro_factura
                    WHERE YEAR(fecha) = YEAR(getdate())
                      AND a.cod_articulo = cod_articulo
        -- a.cod_articulo es referencia externa
        -- al d.cod_articulo no le hace falta ponerle el "d."
        )
   AND pre_unitario BETWEEN 20 AND 50;

-- Resuelto utilizando NOT IN
SELECT cod_articulo 'Código', descripcion, pre_unitario 'Precio'
  FROM articulos a
 WHERE cod_articulo NOT IN (SELECT cod_articulo
                              FROM facturas f
                              JOIN detalle_facturas d
                                ON d.nro_factura = f.nro_factura
                             WHERE YEAR(fecha) = YEAR(getdate()))
   AND pre_unitario BETWEEN 20 AND 50;

/*------------------------------------------------------------------------------------------------
  2. Genere un reporte con los clientes que vinieron más de 2 veces el año pasado. 
-------------------------------------------------------------------------------------------------*/
SELECT cod_cliente 'Código', nom_cliente + ' ' + ape_cliente 'Cliente'
  FROM clientes c
 WHERE 2 < (SELECT COUNT(*)
              FROM facturas
             WHERE YEAR(fecha) = YEAR(getdate()) - 1
               AND cod_cliente = c.cod_cliente);
-- c.cod_cliente es referencia externa porque es un campo de la tabla clientes que está siendo 
-- llamado desde la subconsulta y pertenece a la consulta principal    

/*------------------------------------------------------------------------------------------------
  3. Se quiere saber qué clientes no vinieron entre el 12/12/2007 y el 13/7/2010.
 -------------------------------------------------------------------------------------------------*/
--Resuelto utilizando NOT IN
SELECT cod_cliente 'Código', nom_cliente + ' ' + ape_cliente 'Cliente'
  FROM clientes c
 WHERE cod_cliente NOT IN (SELECT cod_cliente
                             FROM facturas
                            WHERE fecha BETWEEN '12/12/2007' AND '13/7/2010');

--Resuelto utilizando NOT EXISTS
SELECT cod_cliente 'Código', nom_cliente + ' ' + ape_cliente 'Cliente'
  FROM clientes c
 WHERE NOT EXISTS (SELECT cod_cliente
                     FROM facturas f
                    WHERE fecha BETWEEN '12/12/2007' AND '13/7/2010'
                      AND c.cod_cliente = f.cod_cliente);

/*------------------------------------------------------------------------------------------------
  4. Liste los datos de las facturas de los clientes que solo vienen a comprar en febrero es decir
  que todas las veces que vino a comprar haya sido en el mes de febrero (y no otro mes).
 -------------------------------------------------------------------------------------------------*/
SELECT nro_factura,
       fecha,
       c.cod_cliente 'Código',
       nom_cliente + ' ' + ape_cliente 'Cliente'
  FROM facturas f
  JOIN clientes c
    ON f.cod_cliente = c.cod_cliente
 WHERE 2 = ALL (SELECT MONTH(fecha) 
                  FROM facturas 
                 WHERE c.cod_cliente = cod_cliente);
-- Esta subconsulta lista todos los números de meses que vino cada cliente listado en la consulta 
-- principal el test del WHERE va a comprobar que todos los meses listados en la subconsulta sean 
-- iguales a 2

/*------------------------------------------------------------------------------------------------
  5. Muestre los datos de las facturas para los casos en que por año se hayan hecho menos 
  de 9 facturas.
 -------------------------------------------------------------------------------------------------*/
SELECT nro_factura, fecha
  FROM facturas f
 WHERE 9 > (SELECT COUNT(*)
              FROM facturas f1
             WHERE YEAR(f.fecha) = YEAR(f1.fecha));

/*------------------------------------------------------------------------------------------------
  6. Emita un reporte con las facturas cuyo importe total haya sido superior a 300 (incluya en el 
  reporte los datos de los artículos vendidos y los importes).
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
    ON a.cod_articulo = d.cod_articulo
 WHERE 300 < (SELECT SUM(cantidad * pre_unitario)
                FROM detalle_facturas d1
               WHERE d1.nro_factura = f.nro_factura);

/*------------------------------------------------------------------------------------------------
  7. Se quiere saber qué vendedores nunca atendieron a estos clientes: 1 y 6. Muestre solamente el
  nombre del vendedor.
 -------------------------------------------------------------------------------------------------*/
SELECT cod_vendedor 'código', ape_vendedor + ' ' + nom_vendedor 'Nombre'
  FROM vendedores
 WHERE cod_vendedor NOT IN (SELECT cod_vendedor 
                              FROM facturas 
                             WHERE cod_cliente IN (1, 6));

/*------------------------------------------------------------------------------------------------
  8. Listar los datos de los artículos que superaron el promedio del Importe de ventas de $ 200.
 -------------------------------------------------------------------------------------------------*/
SELECT cod_articulo, descripcion, pre_unitario
  FROM articulos a
 WHERE 200 < (SELECT AVG(pre_unitario * cantidad)
                FROM detalle_facturas d
               WHERE a.cod_articulo = d.cod_articulo)
 ORDER BY cod_articulo;

/*------------------------------------------------------------------------------------------------
  9. Que artículos nunca se vendieron? Tenga además en cuenta que su nombre comience con letras
  que van de la “d” a la “p”. Muestre solamente la descripción de artículo.
 -------------------------------------------------------------------------------------------------*/
-- Resuelto con NOT IN
SELECT descripcion
  FROM articulos
 WHERE cod_articulo NOT IN (SELECT cod_articulo 
                              FROM detalle_facturas)
   AND descripcion LIKE '[d-p]%';

-- Resuelto con NOT EXISTS  
SELECT descripcion
  FROM articulos a
 WHERE NOT EXISTS (SELECT cod_articulo
                     FROM detalle_facturas
                    WHERE a.cod_articulo = cod_articulo)
   AND descripcion LIKE '[d-p]%';

/*------------------------------------------------------------------------------------------------
  10. Liste número de factura, fecha y cliente para los casos en que ese cliente haya sido 
  atendido alguna vez por el vendedor de código 3.
 -------------------------------------------------------------------------------------------------*/
SELECT nro_factura, fecha, nom_cliente + ' ' + ape_cliente Cliente
  FROM facturas f
  JOIN clientes c
    ON c.cod_cliente = f.cod_cliente
 WHERE 3 = ANY (SELECT cod_vendedor
                  FROM facturas f1
                 WHERE c.cod_cliente = f1.cod_cliente);
update facturas set cod_vendedor =3
where nro_factura=544

select distinct cod_cliente, cod_vendedor
from facturas
where cod_vendedor=3
order by cod_cliente
/*------------------------------------------------------------------------------------------------
  11. Listar número de factura, fecha, artículo, cantidad e importe para los casos en que todas 
  las cantidades (de unidades vendidas de cada artículo) de esa factura sean superiores a 40.
 -------------------------------------------------------------------------------------------------*/
SELECT f.nro_factura,
       fecha,
       descripcion,
       cantidad,
       cantidad * d.pre_unitario 'Importe'
  FROM facturas f
  JOIN detalle_facturas d
    ON f.nro_factura = d.nro_factura
  JOIN articulos a
    ON a.cod_articulo = d.cod_articulo
 WHERE 40 < ALL (SELECT cantidad
                   FROM detalle_facturas
                  WHERE f.nro_factura = nro_factura);

/*------------------------------------------------------------------------------------------------
  12. Emitir un listado que muestre número de factura, fecha, artículo, cantidad e importe; para 
  los casos en que la cantidad total de unidades vendidas sean superior a 80.
 -------------------------------------------------------------------------------------------------*/
SELECT f.nro_factura,
       fecha,
       descripcion,
       cantidad,
       cantidad * d.pre_unitario 'Importe'
  FROM facturas f
  JOIN detalle_facturas d
    ON f.nro_factura = d.nro_factura
  JOIN articulos a
    ON a.cod_articulo = d.cod_articulo
 WHERE 80 < (SELECT SUM(cantidad)
               FROM detalle_facturas
              WHERE f.nro_factura = nro_factura);

/*------------------------------------------------------------------------------------------------
  13. Liste número de factura, fecha, cliente, artículo e importe para los casos en que alguno de 
  los importes de esa factura sean menores a 100.
 -------------------------------------------------------------------------------------------------*/
SELECT f.nro_factura,
       fecha,
       nom_cliente + ' ' + ape_cliente Cliente,
       descripcion,
       cantidad * d.pre_unitario 'Importe'
  FROM facturas f
  JOIN detalle_facturas d
    ON f.nro_factura = d.nro_factura
  JOIN articulos a
    ON a.cod_articulo = d.cod_articulo
  JOIN clientes c
    ON c.cod_cliente = f.cod_cliente
 WHERE 100 > ANY (SELECT cantidad * pre_unitario
                    FROM detalle_facturas
                   WHERE f.nro_factura = nro_factura);
