select sum(df.cantidad*df.pre_unitario) Total, sum(df.cantidad) 'Cant Art',COUNT(*) 'Cant Items',  max(df.pre_unitario) M�ximo, min(df.pre_unitario) M�nimo
	from detalle_facturas df
	where df.nro_factura=236
	