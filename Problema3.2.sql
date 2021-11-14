select nro_factura, fecha, ape_cliente+', '+nom_cliente Cliente, ape_vendedor+', '+nom_vendedor Vendedor
	from facturas f, clientes c, vendedores v
	where f.cod_cliente=c.cod_cliente
		and f.cod_vendedor=v.cod_vendedor
		and fecha between '01/02/2008' and '01/03/2010'
		and c.ape_cliente not like '%C%'