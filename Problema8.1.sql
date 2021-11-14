select *
	from facturas f
	join vendedores v
		on f.cod_vendedor=v.cod_vendedor
	join clientes c
		on f.cod_cliente=c.cod_cliente
	where year(f.fecha) in ('2006','2007','2009','2012')
	
SELECT nro_factura,
       fecha,
       nom_vendedor + ', ' + ape_vendedor,
       ape_cliente + ', ' + nom_cliente
  FROM clientes c
  JOIN facturas f
    ON f.cod_cliente = c.cod_cliente
  JOIN vendedores v
    ON f.cod_vendedor = v.cod_vendedor
 WHERE YEAR(fecha) IN (2006, 2007, 2009, 2012)