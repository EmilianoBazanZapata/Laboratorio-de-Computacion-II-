select YEAR(f.fecha) 'A�o', MONTH(f.fecha) 'Month',DAY(f.fecha) 'D�a',COUNT(*) 'Facturas'
	from facturas f
	where MONTH(f.fecha) not in (1,7,12)
	group by DAY(f.fecha),MONTH(f.fecha),YEAR(f.fecha)
	order by 4 desc,1,2,3
	