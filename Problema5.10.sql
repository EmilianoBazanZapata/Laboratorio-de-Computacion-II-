select min(f.fecha), sum(df.cantidad), sum(df.cantidad*df.pre_unitario)
	from facturas f
	join detalle_facturas df on df.nro_factura=f.nro_factura
	join articulos a on a.cod_articulo=df.cod_articulo
	where a.descripcion like 'c%'