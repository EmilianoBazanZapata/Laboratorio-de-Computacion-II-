select f.cod_cliente,SUM(df.cantidad),SUM(df.cantidad*df.pre_unitario),AVG(df.cantidad)
		,MIN(f.fecha),MAX(f.fecha)
	from facturas f,detalle_facturas df
	where f.nro_factura=df.nro_factura
		and f.nro_factura not in (2,12,20,17,30)
	group by f.cod_cliente
	having AVG(df.cantidad) between 2 and 6
		