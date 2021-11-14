select df.nro_factura Factura, sum(df.cantidad) Cant, COUNT(*) Items, SUM(df.cantidad*df.pre_unitario) Importe
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
		and YEAR(f.fecha)=YEAR(getdate())
	group by df.nro_factura