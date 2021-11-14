select *
	from facturas f
	join clientes c
		on f.cod_cliente=c.cod_cliente
	join vendedores v
		on f.cod_vendedor=v.cod_vendedor
	join detalle_facturas df
		on f.nro_factura=df.nro_factura 
	join articulos a
		on df.cod_articulo=a.cod_articulo and a.descripcion like '[a-m]%'
	where (MONTH(f.fecha)='02' or MONTH(f.fecha)='03') and (YEAR(f.fecha)='2006' or YEAR(f.fecha)='2007')
	order by f.fecha, c.cod_cliente, a.cod_articulo
	
SELECT f.nro_factura,
       fecha,
       nom_vendedor + ', ' + ape_vendedor,
       ape_cliente + ', ' + nom_cliente Cliente,
       descripcion,
       cantidad,
       cantidad * d.pre_unitario
  FROM facturas f
  JOIN vendedores v
    ON f.cod_vendedor = v.cod_vendedor
  JOIN clientes c
    ON f.cod_cliente = c.cod_cliente
  JOIN detalle_facturas d
    ON f.nro_factura = d.nro_factura
  JOIN articulos a
    ON a.cod_articulo = d.cod_articulo
 WHERE YEAR(fecha) IN (2006, 2007)
   AND MONTH(fecha) IN (2, 3)
   AND descripcion LIKE '[a-m]%'
 ORDER BY fecha, ape_cliente + ', ' + nom_cliente, descripcion