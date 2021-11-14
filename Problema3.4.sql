select df.cod_articulo 'C�digo de Art�culo', a.descripcion Descripci�n,
		 df.cantidad Cantidad, df.cantidad*df.pre_unitario 'Importe'
	from articulos a, detalle_facturas df
	where df.cod_articulo=a.cod_articulo
		and df.pre_unitario between 10 and 50