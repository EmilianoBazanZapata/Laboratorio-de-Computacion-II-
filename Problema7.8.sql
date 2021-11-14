select f.cod_vendedor, f.cod_cliente,SUM(df.cantidad),SUM(df.cantidad*df.pre_unitario)
		,AVG(df.cantidad*df.pre_unitario)
	from facturas f,detalle_facturas df,clientes c,vendedores v
	where f.nro_factura=df.nro_factura and f.cod_cliente=c.cod_cliente and f.cod_vendedor=v.cod_vendedor
		and c.cod_cliente between 1 and 5
	group by f.cod_vendedor, f.cod_cliente
	having SUM(df.cantidad*df.pre_unitario) between 200 and 600