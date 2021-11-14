select f.cod_cliente 'Cliente', MIN(f.fecha) 'Primer Venta',
		 MAX(f.fecha) 'Ultima Venta', SUM(df.cantidad*df.pre_unitario) 'Importe'
	from facturas f, detalle_facturas df, clientes c
	where f.nro_factura=df.nro_factura and f.cod_cliente=c.cod_cliente
	group by f.cod_cliente
	order by f.cod_cliente