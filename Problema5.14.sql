select sum(df.cantidad*df.pre_unitario), avg(df.cantidad*df.pre_unitario)
	from facturas f
	join detalle_facturas df on f.nro_factura=df.nro_factura
	where f.nro_factura not in (13,5,17,33,24)