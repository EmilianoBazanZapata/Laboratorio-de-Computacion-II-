Select distinct a.descripcion Art�culo, df.pre_unitario 'Precio Venta', a.pre_unitario 'Precio Actual'
	from facturas f, detalle_facturas df, articulos a
	where f.nro_factura=df.nro_factura
		and df.cod_articulo=a.cod_articulo
		and year(f.fecha)=2010
	order by Art�culo,
			'Precio Venta'