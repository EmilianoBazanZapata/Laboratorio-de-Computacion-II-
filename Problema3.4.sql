select df.cod_articulo 'Código de Artículo', a.descripcion Descripción,
		 df.cantidad Cantidad, df.cantidad*df.pre_unitario 'Importe'
	from articulos a, detalle_facturas df
	where df.cod_articulo=a.cod_articulo
		and df.pre_unitario between 10 and 50