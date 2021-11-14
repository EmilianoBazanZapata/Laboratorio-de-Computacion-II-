select a.cod_articulo Código, a.descripcion Artículo, 'Existencia'
		from articulos a
		where a.pre_unitario between 10 and 50
	union
select df.cod_articulo Código, a.descripcion Artículo, 'Venta'
		from detalle_facturas df, facturas f, clientes c, articulos a
		where df.nro_factura=f.nro_factura
			and f.cod_cliente=c.cod_cliente
			and df.cod_articulo=a.cod_articulo
			and c.ape_cliente like '[lm]%'