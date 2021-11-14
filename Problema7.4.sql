select c.cod_cliente, MAX(df.cantidad*df.pre_unitario), MIN(df.cantidad*df.pre_unitario), 
		SUM(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df, clientes c
	where f.nro_factura=df.nro_factura and f.cod_cliente=c.cod_cliente
		and YEAR(f.fecha)=YEAR(GETDATE())-1
	group by c.cod_cliente
	having SUM(df.cantidad*df.pre_unitario) between 3000 and 8000