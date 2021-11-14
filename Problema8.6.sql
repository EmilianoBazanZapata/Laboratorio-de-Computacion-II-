Select c.cod_cliente,c.ape_cliente+', '+c.nom_cliente, f.fecha,f.nro_factura
	from clientes c
	left join facturas f
		on f.cod_cliente=c.cod_cliente and year(f.fecha)=2007
	
SELECT c.cod_cliente,
       ape_cliente + ', ' + nom_cliente Cliente,
       fecha,
       nro_factura
  FROM clientes c
  LEFT JOIN facturas f
    ON f.cod_cliente = c.cod_cliente
 WHERE YEAR(fecha) = 2007
 
 Select c.cod_cliente,c.ape_cliente+', '+c.nom_cliente, f.fecha,f.nro_factura
	from facturas f
	join clientes c
		on f.cod_cliente=c.cod_cliente
	where year(f.fecha)=2007