select f.cod_vendedor
		--,AVG(df.cantidad*df.pre_unitario)
	from facturas f,detalle_facturas df
	where f.nro_factura=df.nro_factura
	AND MONTH(f.fecha)=MONTH(GETDATE())-1
	group by f.cod_vendedor
	--having AVG(df.cantidad*df.pre_unitario)>700
