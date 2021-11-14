select *
	from vendedores v
	left join facturas f
		on f.cod_vendedor=v.cod_vendedor and YEAR(f.fecha)=YEAR(GETDATE())
		
SELECT v.cod_vendedor,
       nom_vendedor + ', ' + ape_vendedor,
       fecha,
       nro_factura
  FROM vendedores v
  LEFT JOIN facturas f
    ON v.cod_vendedor = f.cod_vendedor
   AND YEAR(fecha) = 2019