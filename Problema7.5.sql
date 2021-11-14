select f.cod_vendedor,DAY(f.fecha),COUNT(*)
	from facturas f
	group by f.cod_vendedor,DAY(f.fecha)
	having COUNT(*)>=2	