Select c.cod_cliente Código, c.ape_cliente+', '+c.nom_cliente Nombre, 'Cliente'
		from clientes c
	union
select v.cod_vendedor Código, v.ape_vendedor+', '+v.nom_vendedor Nombre, 'Vendedor'
		from vendedores v
	union
select a.cod_articulo Código, a.descripcion Nombre, 'Artículo'
		from articulos a
	order by 3,2