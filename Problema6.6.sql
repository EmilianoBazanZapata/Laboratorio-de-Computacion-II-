select f.fecha 'Fecha',df.cod_articulo 'Artículo', AVG(df.cantidad*df.pre_unitario) 'Promedio',
		SUM(df.cantidad) 'Cantidad'
	from facturas f, detalle_facturas df, articulos a
	where f.nro_factura=df.nro_factura and df.cod_articulo=a.cod_articulo
		and f.cod_cliente<3
	group by f.fecha, df.cod_articulo
	order by f.fecha, df.cod_articulo