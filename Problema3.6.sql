select f.nro_factura, c.ape_cliente+', '+c.nom_cliente Cliente, b.barrio Barrio, v.ape_vendedor+', '+v.nom_vendedor Vendedor,
		f.fecha 
	from facturas f, clientes c, vendedores v, barrios b
	where f.cod_cliente = c.cod_cliente
		and f.cod_vendedor = v.cod_vendedor
		and c.cod_barrio = b.cod_barrio
		and f.nro_factura in (12, 18, 1, 3, 35, 26, 29)
	order by f.nro_factura