/*------------------------------------------------------------------------------------------------
  9. Emitir un listado de los artículos que vendieron los vendedores Ledesma, Mariela y López, 
  Alejandro. 
-------------------------------------------------------------------------------------------------*/
select distinct a.cod_articulo Código,a.descripcion Artículo,v.ape_vendedor+', '+v.nom_vendedor Vendedor
	from articulos a
	join detalle_facturas df
		on a.cod_articulo=df.cod_articulo
	join facturas f
		on df.nro_factura=f.nro_factura
	join vendedores v
		on f.cod_vendedor=v.cod_vendedor
	where v.ape_vendedor in ('Ledesma','López')
		and v.nom_vendedor in ('Mariela','Alejandro')
	order by Vendedor,Código
	
SELECT a.cod_articulo, descripcion, nom_vendedor + ', ' + ape_vendedor
  FROM articulos a
  JOIN detalle_facturas d
    ON a.cod_articulo = d.cod_articulo
  JOIN facturas f
    ON f.nro_factura = d.nro_factura
  JOIN vendedores v
    ON v.cod_vendedor = f.cod_vendedor
 WHERE (v.ape_vendedor = 'Ledesma' AND v.nom_vendedor = 'Mariela')
    OR (v.ape_vendedor = 'López' AND v.nom_vendedor = 'Alejandro')