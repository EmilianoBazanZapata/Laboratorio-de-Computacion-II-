select f.nro_factura, SUM(df.cantidad),SUM(df.cantidad*df.pre_unitario),AVG(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
		and f.fecha not between '13/02/2007' and '13/07/2010'
	group by f.nro_factura
	order by f.nro_factura