select distinct c.ape_cliente+', '+c.nom_cliente Cliente, v.ape_vendedor+', '+v.nom_vendedor Vendedor, a.descripcion Artículo
	from clientes c, vendedores v, facturas f, detalle_facturas df, articulos a
	where f.nro_factura=df.nro_factura
		and df.cod_articulo=a.cod_articulo
		and f.cod_cliente=c.cod_cliente
		and f.cod_vendedor=f.cod_vendedor
		and year(f.fecha)=YEAR(getdate())-1
		and v.fec_nac<DATEADD(year,-3,getdate())