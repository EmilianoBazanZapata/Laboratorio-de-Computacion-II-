select f.cod_cliente, df.cod_articulo, SUM(df.cantidad*df.pre_unitario) 'Importe Total', 
		SUM(df.cantidad) ' Cantidad Total', AVG(df.pre_unitario) 'Precio Promedio'
	from facturas f, detalle_facturas df, articulos a, clientes c
	where f.nro_factura=df.nro_factura and df.cod_articulo=a.cod_articulo and f.cod_cliente=c.cod_cliente
		and c.nom_cliente like '[a-m]%'
	group by f.cod_cliente, df.cod_articulo
	order by f.cod_cliente, 'Precio Promedio' desc, df.cod_articulo