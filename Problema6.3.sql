select YEAR(f.fecha) 'A�o', SUM(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
	group by YEAR(f.fecha)
	order by 1
	
select YEAR(f.fecha) 'A�o', month(f.fecha) 'Mes', SUM(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
	group by YEAR(f.fecha), MONTH(f.fecha)
	order by 1,2
	
select YEAR(f.fecha) 'A�o', month(f.fecha) 'Mes', day(f.fecha) 'D�a',SUM(df.cantidad*df.pre_unitario)
	from facturas f, detalle_facturas df
	where f.nro_factura=df.nro_factura
	group by YEAR(f.fecha), MONTH(f.fecha), DAY(f.fecha)
	order by 1,2,3