select distinct a.descripcion Descripción, df.cantidad Cantidad, df.cantidad*df.pre_unitario Importe
	from articulos a, facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
		and df.cod_articulo=a.cod_articulo
		and f.nro_factura not between 17 and 136
	order by descripcion,
		cantidad	