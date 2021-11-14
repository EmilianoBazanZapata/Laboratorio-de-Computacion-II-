Select c.cod_cliente C�digo, c.ape_cliente+', '+c.nom_cliente Nombre, 'Cliente'
		from clientes c
	union
select v.cod_vendedor C�digo, v.ape_vendedor+', '+v.nom_vendedor Nombre, 'Vendedor'
		from vendedores v
	union
select a.cod_articulo C�digo, a.descripcion Nombre, 'Art�culo'
		from articulos a
	order by 3,2