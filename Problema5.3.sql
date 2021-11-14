select sum(df.cantidad*df.pre_unitario) 'Total'
	from detalle_facturas df, facturas f
	where df.nro_factura=f.nro_factura
		and year(f.fecha)=year(getdate())-1
		
		
select sum(df.cantidad*df.pre_unitario) 'Total'
	from detalle_facturas df
	join facturas f on df.nro_factura=f.nro_factura
	where year(f.fecha)=year(getdate())-1