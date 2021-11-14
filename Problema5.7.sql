select sum(df.cantidad) 'Cant Vendidas', COUNT(distinct df.cod_articulo) 'Art. Distintos',
		sum(df.cantidad*df.pre_unitario) 
	from detalle_facturas df
	join facturas f on f.nro_factura=df.nro_factura
	where df.nro_factura=450
	
select *
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
		and f.nro_factura=450