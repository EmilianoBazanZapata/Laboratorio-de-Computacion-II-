Select distinct a.descripcion Art�culo, df.pre_unitario 'Precio Venta', Year(f.fecha) A�o
	from facturas f, detalle_facturas df, articulos a
	where f.nro_factura=df.nro_factura
		and df.cod_articulo=a.cod_articulo
		and YEAR(f.fecha)=2015
		and df.pre_unitario<10
	order by Art�culo,
			'Precio Venta'