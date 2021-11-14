select sum(df.cantidad*df.pre_unitario), avg(df.cantidad*df.pre_unitario)
	from facturas f
	join detalle_facturas df on df.nro_factura=f.nro_factura
	join clientes c on c.cod_cliente=f.cod_cliente
	where c.[e-mail] is not null