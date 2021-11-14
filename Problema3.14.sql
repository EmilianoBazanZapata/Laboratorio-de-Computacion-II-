select v.ape_vendedor+', '+nom_vendedor Vendedor, f.fecha Fecha, c.ape_cliente,c.nom_cliente
	from facturas f, clientes c, vendedores v
	where f.cod_cliente=c.cod_cliente
		and f.cod_vendedor=v.cod_vendedor
		and YEAR(f.fecha)<=YEAR(GETDATE())-2
		--and f.fecha<=dateadd(year,-2,GETDATE())
		and (c.ape_cliente like 'c%' or c.nom_cliente like 'c%')
		