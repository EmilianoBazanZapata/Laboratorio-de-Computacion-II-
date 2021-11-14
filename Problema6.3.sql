select YEAR(f.fecha) 'Año', SUM(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
	group by YEAR(f.fecha)
	order by 1
	
select YEAR(f.fecha) 'Año', month(f.fecha) 'Mes', SUM(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
	group by YEAR(f.fecha), MONTH(f.fecha)
	order by 1,2
	
select YEAR(f.fecha) 'Año', month(f.fecha) 'Mes', day(f.fecha) 'Día',SUM(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
	group by YEAR(f.fecha), MONTH(f.fecha), DAY(f.fecha)
	order by 1,2,3