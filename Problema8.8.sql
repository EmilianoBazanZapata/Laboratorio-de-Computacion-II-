select c.ape_cliente+', '+c.nom_cliente Cliente,a.descripcion Artículo,df.cantidad Cantidad,df.cantidad*df.pre_unitario Importe
	from articulos a
	join detalle_facturas df
		on a.cod_articulo=df.cod_articulo
	join facturas f
		on df.nro_factura=f.nro_factura
	join clientes c
		on f.cod_cliente=c.cod_cliente
		and ape_cliente like '[p]%'
	order by c.ape_cliente+', '+c.nom_cliente,a.descripcion desc
	
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