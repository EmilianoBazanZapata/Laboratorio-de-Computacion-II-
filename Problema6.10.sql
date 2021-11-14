select f.cod_vendedor, f.cod_cliente, COUNT(distinct f.nro_factura) 'Ventas',  min(f.fecha),max(f.fecha)
	from facturas f, clientes c, vendedores v
	where f.cod_cliente=c.cod_cliente and f.cod_vendedor=v.cod_vendedor
		and f.nro_factura between 5 and 30
	group by f.cod_cliente, f.cod_vendedor
	order by f.cod_vendedor,Ventas desc,f.cod_cliente