select nro_factura, fecha, ape_vendedor+', '+nom_vendedor Vendedor
	from vendedores v, facturas f
	where f.cod_vendedor=v.cod_vendedor and f.cod_cliente between 2 and 6
	order by Vendedor desc,
			f.fecha desc