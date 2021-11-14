select a.cod_articulo,AVG(df.pre_unitario),SUM(df.cantidad*df.pre_unitario),AVG(df.cantidad*df.pre_unitario)
		,sum(df.cantidad)
	from facturas f, detalle_facturas df, articulos a
	where f.nro_factura=df.nro_factura and df.cod_articulo=a.cod_articulo
	 and a.descripcion not like 'c%'
	group by a.cod_articulo
	having SUM(df.cantidad)>=100 or SUM(df.cantidad*df.pre_unitario)>700