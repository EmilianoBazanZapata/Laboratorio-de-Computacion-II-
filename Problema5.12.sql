select COUNT(distinct f.nro_factura), max(f.fecha), sum(df.cantidad*df.pre_unitario)
	from facturas f
	join detalle_facturas df on f.nro_factura=df.nro_factura
	join clientes c on f.cod_cliente=c.cod_cliente
	where c.ape_cliente='Abarca'