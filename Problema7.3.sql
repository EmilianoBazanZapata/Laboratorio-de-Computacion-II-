select f.cod_vendedor, MIN(f.fecha), SUM(df.cantidad), SUM(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df, vendedores v
	where f.nro_factura=df.nro_factura and f.cod_vendedor=v.cod_vendedor
	group by f.cod_vendedor
	--having avg(df.cantidad*df.pre_unitario)<=56