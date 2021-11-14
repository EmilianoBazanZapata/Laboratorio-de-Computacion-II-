select distinct a.cod_articulo 'Código Artículo',descripcion Descripción
	from facturas f, detalle_facturas df, articulos a
	where f.nro_factura=df.nro_factura
		and df.cod_articulo=a.cod_articulo
		and year(f.fecha)=YEAR(GETDATE())