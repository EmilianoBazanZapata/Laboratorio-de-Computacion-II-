Select c.cod_cliente Código, c.ape_cliente+', '+c.nom_cliente Nombre, 'Cliente'
		from clientes c
		where c.[e-mail] is not null
			and c.nro_tel is not null
	union
select v.cod_vendedor Código, v.ape_vendedor+', '+v.nom_vendedor Nombre, 'Vendedor'
		from vendedores v
		where v.nro_tel is not null
			and v.[e-mail] is not null
	order by 3,2