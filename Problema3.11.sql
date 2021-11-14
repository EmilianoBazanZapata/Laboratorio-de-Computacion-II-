select v.ape_vendedor+', '+v.nom_vendedor Vendedor, f.fecha Fecha, f.nro_factura Factura,
		df.cantidad*df.pre_unitario Importe
	from facturas f, detalle_facturas df, vendedores v
	where f.nro_factura=df.nro_factura
		and f.cod_vendedor=v.cod_vendedor
		and df.pre_unitario between 50 and 100
		and v.ape_vendedor not like '[lm]%'
	order by v.ape_vendedor ,
		f.fecha,
		importe