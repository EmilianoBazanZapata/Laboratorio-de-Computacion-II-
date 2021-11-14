select f.fecha, f.cod_cliente, SUM(df.cantidad), AVG(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df, clientes c
	where f.nro_factura=df.nro_factura and c.cod_cliente=f.cod_cliente
		and f.cod_vendedor>2
	group by f.fecha, f.cod_cliente
	order by f.fecha, f.cod_cliente