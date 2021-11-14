select c.ape_cliente+', '+c.nom_cliente Cliente, a.descripcion Descripción,f.nro_factura Factura,
		f.fecha Fecha, df.cantidad Cantidad, df.cantidad*df.pre_unitario Importe 
	from facturas f, clientes c, articulos a, detalle_facturas df
	where f.nro_factura=df.nro_factura
		and df.cod_articulo=a.cod_articulo
		and f.cod_cliente=c.cod_cliente
		and c.ape_cliente like '[i-s]%'
		and a.descripcion like'[i-s]%'