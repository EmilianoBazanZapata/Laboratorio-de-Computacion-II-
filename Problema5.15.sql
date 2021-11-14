select sum(df.cantidad*df.pre_unitario) 'Total', 'Año pasado'
		from facturas f, detalle_facturas df
		where f.nro_factura=df.nro_factura
			and year(f.fecha)=YEAR(getdate())-1
	union
select sum(df.cantidad*df.pre_unitario) 'Total', 'Mes pasado'
		from facturas f, detalle_facturas df
		where f.nro_factura=df.nro_factura
			and month(f.fecha)=month(dateadd(day,-30,getdate()))
	union
select sum(df.cantidad*pre_unitario) 'Total', 'Este Mes'
		from facturas f, detalle_facturas df
		where f.nro_factura=df.nro_factura
		AND MONTH(f.fecha)=MONTH(GETDATE())
	union
select sum(df.cantidad*pre_unitario) 'Total', 'Hoy'
		from facturas f, detalle_facturas df
		where f.nro_factura=df.nro_factura
		AND f.fecha=GETDATE()