/*------------------------------------------------------------------------------------------------
  Guia de Ejercicios UNION
-------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------
  1. Se quiere saber qué vendedores y clientes hay en la empresa; para los casos en que su teléfono
  y dirección de e-mail sean conocidos. Se deberá visualizar el código, nombre y si se trata de un 
  cliente o de un vendedor. Ordene por la columna tercera y segunda. 
-------------------------------------------------------------------------------------------------*/
ELECT cod_cliente, nom_cliente, 'Cliente'
  FROM clientes
 WHERE nro_tel is not null
   AND [e-mail] is not null
UNION
SELECT cod_vendedor, nom_vendedor, 'Vendedor'
  FROM vendedores
 WHERE nro_tel is not null
   AND [e-mail] is not null
 ORDER BY 2, 3;
 
/*------------------------------------------------------------------------------------------------
	2. Emitir un listado donde se muestren qué artículos, clientes y vendedores hay en la empresa. 
  Determine los campos a mostrar y su ordenamiento.
-------------------------------------------------------------------------------------------------*/
SELECT cod_cliente Codigo, nom_cliente Nombre, 'Cliente'
  FROM clientes
UNION
SELECT cod_articulo, descripcion, 'Articulo'
  FROM articulos
UNION
SELECT cod_vendedor, nom_vendedor, 'Vendedor'
  FROM vendedores
 ORDER BY 1;

/*------------------------------------------------------------------------------------------------
	3. En un mismo listado mostrar todos los artículos que hay en la empresa y los artículos que 
  han sido vendidos. Determine Ud. las columnas a mostrar. 
-------------------------------------------------------------------------------------------------*/
SELECT articulos.cod_articulo, descripcion, 'Vendido'
  FROM articulos, detalle_facturas
 WHERE articulos.cod_articulo = detalle_facturas.cod_articulo
UNION
SELECT cod_articulo, descripcion, 'No Vendido'
  FROM articulos
 ORDER BY 1;

/*-----------------------------------------------------------------------------------------------
	4. Se quiere saber las direcciones (incluido el barrio) tanto de clientes como de vendedores. 
  Para el caso de los vendedores, códigos entre 3 y 12. En ambos casos las direcciones deberán ser 
  conocidas. Rotule como NOMBRE, DIRECCION, BARRIO, INTEGRANTE (en donde indicará si es cliente o 
  vendedor). Ordenado por la primera y la última columna. 
-------------------------------------------------------------------------------------------------*/
SELECT nom_cliente Nombre,
       calle + ' ' + CONVERT(VARCHAR, altura) Direccion,
       barrio Barrio,
       'Cliente' Integrante
  FROM clientes, barrios
 WHERE clientes.cod_barrio = barrios.cod_barrio
   AND calle is not null
   AND altura is not null
UNION
SELECT nom_vendedor Nombre,
       calle + ' ' + CONVERT(VARCHAR, altura) Direccion,
       barrio Barrio,
       'Vendedor' Integrante
  FROM vendedores, barrios
 WHERE vendedores.cod_barrio = barrios.cod_barrio
   AND calle is not null
   AND altura is not null
   AND vendedores.cod_vendedor BETWEEN 3 AND 12;

/*------------------------------------------------------------------------------------------------
	5. Se quiere saber qué clientes hay en la empresa y listar además los clientes que han comparado 
  entre el 1/12/2010 y el 1/03/2012. Muestre el código, sin duplicarlos. 
-------------------------------------------------------------------------------------------------*/
SELECT cod_cliente, 'No compro'
  FROM clientes
UNION
SELECT clientes.cod_cliente, clientes.nom_cliente, 'Compro'
  FROM clientes, facturas
 WHERE clientes.cod_cliente = facturas.cod_cliente
   AND facturas.fecha BETWEEN '01/12/2010' AND '01/02/2012'

/*------------------------------------------------------------------------------------------------
	6. Ídem al ejercicio anterior, sólo que además del código, identifique de donde obtiene la 
  información (de qué tabla se obtienen los datos). 
-------------------------------------------------------------------------------------------------*/
SELECT cod_cliente, nom_cliente, 'Cliente' Tabla
  FROM clientes
UNION
SELECT clientes.cod_cliente, clientes.nom_cliente, 'Detalle_Facturas'
  FROM clientes, facturas
 WHERE clientes.cod_cliente = facturas.cod_cliente
   AND facturas.fecha BETWEEN '01/12/2010' AND '01/02/2012';

/*------------------------------------------------------------------------------------------------
	7. Se quiere saber qué clientes hay en la empresa y quiénes han comprado; para el primer caso 
  para nombres que empiecen con letras que van de la “c” a la “l” y para el segundo para facturas 
  que oscilen entre 10 y 23. Muestre el código (no elimine los que se repiten). 
-------------------------------------------------------------------------------------------------*/
SELECT cod_cliente Codigo, nom_cliente, 'Cliente' Tabla
  FROM clientes
 WHERE nom_cliente LIKE '[c-l]%'
UNION ALL
SELECT clientes.cod_cliente, clientes.nom_cliente, 'Compro'
  FROM clientes, facturas
 WHERE clientes.cod_cliente = facturas.cod_cliente
   AND facturas.nro_factura BETWEEN 10 AND 23
 ORDER BY 1;

/*------------------------------------------------------------------------------------------------
	8. Listar todos los artículos que están a la venta cuyo precio unitario oscile entre 10 y 50; 
  también se quieren listar los artículos que fueron comprados por los clientes cuyos apellidos 
  comiencen con “M” o con “P”.
-------------------------------------------------------------------------------------------------*/
SELECT cod_articulo, descripcion, 'Venta'
  FROM articulos
 WHERE articulos.pre_unitario BETWEEN 10 AND 50
UNION
SELECT articulos.cod_articulo, descripcion, 'Vendido'
  FROM articulos, detalle_facturas, facturas, clientes
 WHERE facturas.nro_factura = detalle_facturas.nro_factura
   AND clientes.cod_cliente = facturas.cod_cliente
   AND articulos.cod_articulo = detalle_facturas.cod_articulo
   AND clientes.ape_cliente LIKE '[M,P]%';
