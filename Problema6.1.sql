select df.cod_articulo, sum(df.cantidad*df.pre_unitario)
	from detalle_facturas df
	group by df.cod_articulo