select COUNT(distinct df.nro_factura)
	from detalle_facturas df
	join facturas f on df.nro_factura=f.nro_factura
	where f.cod_vendedor=3