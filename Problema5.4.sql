select sum(df.cantidad*df.pre_unitario),(count(distinct df.nro_factura)),sum(df.cantidad*df.pre_unitario)/(count(distinct df.nro_factura))

	from detalle_facturas df, facturas f
	where Year(f.fecha)=year(GETDATE())-1
		and f.nro_factura=df.nro_factura