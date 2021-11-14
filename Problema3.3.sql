select f.nro_factura Factura, fecha Fecha, df.cod_articulo'Código Atículo', descripcion Descripción, df.cantidad*df.pre_unitario Importe
	from facturas f, detalle_facturas df, articulos a
	where f.nro_factura=df.nro_factura and df.cod_articulo=a.cod_articulo
		and YEAR(fecha)in (2009, 2010, 2012)
		and descripcion not like 'R%'
	order by f.nro_factura asc,
			importe desc