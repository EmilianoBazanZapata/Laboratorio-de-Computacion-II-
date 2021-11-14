select v.ape_vendedor+', '+nom_vendedor Vendedor, c.ape_cliente+', '+c.nom_cliente Cliente,
		a.cod_articulo, a.descripcion, a.stock_minimo, a.pre_unitario, a.observaciones Artículo,
		f.nro_factura, f.fecha, df.cantidad, df.pre_unitario, df.cantidad*df.pre_unitario Importe 
	from facturas f, detalle_facturas df,clientes c, vendedores v, articulos a
	where f.nro_factura = df.nro_factura
		and df.cod_articulo = a.cod_articulo
		and f.cod_cliente = c.cod_cliente
		and f.cod_vendedor = v.cod_vendedor
		and c.nro_tel is null
		and c.[e-mail] is null
		and df.cantidad*df.pre_unitario>250
	order by v.cod_vendedor,
			c.cod_cliente,
			a.cod_articulo