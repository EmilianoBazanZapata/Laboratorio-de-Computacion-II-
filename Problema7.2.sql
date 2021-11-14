select f.cod_vendedor, SUM(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df,vendedores v
	where f.nro_factura=df.nro_factura and f.cod_vendedor=v.cod_vendedor
		and YEAR(f.fecha)='2017'
	group by f.cod_vendedor
	having SUM(df.cantidad*df.pre_unitario)<17000
	