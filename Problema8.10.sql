/*------------------------------------------------------------------------------------------------
  10. Listar todos los clientes (incluidos los que nunca compraron) y los años de compra. 
  No muestre registros repetidos.
-------------------------------------------------------------------------------------------------*/
select distinct c.ape_cliente+', '+c.nom_cliente Cliente,YEAR(f.fecha) Año
	from clientes c
	left join facturas f
		on c.cod_cliente=f.cod_cliente




SELECT distinct ape_cliente + ', ' + nom_cliente Cliente, YEAR(fecha) 'Año'
  FROM clientes c
  LEFT JOIN facturas f
    ON c.cod_cliente = f.cod_cliente