Select f.nro_factura, SUM(df.cantidad*df.pre_unitario) as 'Importe'
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
	group by f.nro_factura
	having SUM(df.cantidad*df.pre_unitario)>2500