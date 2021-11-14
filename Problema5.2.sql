select sum(df.cantidad*df.pre_unitario) Total, sum(df.cantidad) 'Cant Art',COUNT(*) 'Cant Items',  max(df.pre_unitario) Máximo, min(df.pre_unitario) Mínimo
	from detalle_facturas df
	where df.nro_factura=236
	