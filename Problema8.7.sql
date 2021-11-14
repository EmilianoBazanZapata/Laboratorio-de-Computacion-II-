select a.descripcion,a.observaciones,df.cantidad*df.pre_unitario
	from articulos a
	join detalle_facturas df
		on a.cod_articulo=df.cod_articulo
	join facturas f
		on df.nro_factura=f.nro_factura
		and YEAR(f.fecha)=YEAR(GETDATE())
	join clientes c
		on f.cod_cliente=c.cod_cliente
		and c.ape_cliente='Morales'
		and c.nom_cliente='Pilar'
		
SELECT descripcion, observaciones, d.pre_unitario * cantidad 'Importe'
  FROM articulos a
  JOIN detalle_facturas d
    ON a.cod_articulo = d.cod_articulo
  JOIN facturas f
    ON f.nro_factura = d.nro_factura
  JOIN clientes c
    ON c.cod_cliente = f.cod_cliente
 WHERE YEAR(fecha) = YEAR(GETDATE())
   AND c.ape_cliente = 'Morales'
   AND c.nom_cliente = 'Pilar'
		