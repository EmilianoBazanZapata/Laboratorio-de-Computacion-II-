select c.ape_cliente+', '+c.nom_cliente Nombre, c.calle Dirección, b.barrio Barrio, 'Ciente'
		from clientes c, barrios b
		where c.cod_barrio=b.cod_barrio
			and c.calle is not null
	union
select v.ape_vendedor+', '+v.nom_vendedor Nombre, v.calle Dirección, b.barrio Barrio, 'Vendedor'
		from vendedores v, barrios b
		where v.cod_barrio=b.cod_barrio
			and v.calle is not null
			and v.cod_vendedor between 3 and 12
	order by 1,4