select c.ape_cliente+', '+nom_cliente Cliente, a.descripcion Artículo, df.cantidad*df.pre_unitario Importe, F.fecha
	from clientes c, facturas f, detalle_facturas df, articulos a
	where f.nro_factura=df.nro_factura
		and df.cod_articulo=a.cod_articulo
		and f.cod_cliente=c.cod_cliente
		and YEAR(f.fecha)=YEAR(getdate())
		and month(f.fecha)=1
	order by Cliente,
		Artículo