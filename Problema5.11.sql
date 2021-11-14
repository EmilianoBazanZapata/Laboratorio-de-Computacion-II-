select sum(df.cantidad), sum(df.cantidad*df.pre_unitario)
	from facturas f
	join detalle_facturas df on f.nro_factura=df.nro_factura
	where f.fecha between '15/06/2011' and '15/06/2017'