/*------------------------------------------------------------------------------------------------
  9. Emitir un listado de los art�culos que vendieron los vendedores Ledesma, Mariela y L�pez, 
  Alejandro. 
-------------------------------------------------------------------------------------------------*/
select distinct a.cod_articulo C�digo,a.descripcion Art�culo,v.ape_vendedor+', '+v.nom_vendedor Vendedor
	from articulos a
	join detalle_facturas df
		on a.cod_articulo=df.cod_articulo
	join facturas f
		on df.nro_factura=f.nro_factura
	join vendedores v
		on f.cod_vendedor=v.cod_vendedor
	where v.ape_vendedor in ('Ledesma','L�pez')
		and v.nom_vendedor in ('Mariela','Alejandro')
	order by Vendedor,C�digo
	
SELECT a.cod_articulo, descripcion, nom_vendedor + ', ' + ape_vendedor
  FROM articulos a
  JOIN detalle_facturas d
    ON a.cod_articulo = d.cod_articulo
  JOIN facturas f
    ON f.nro_factura = d.nro_factura
  JOIN vendedores v
    ON v.cod_vendedor = f.cod_vendedor
 WHERE (v.ape_vendedor = 'Ledesma' AND v.nom_vendedor = 'Mariela')
    OR (v.ape_vendedor = 'L�pez' AND v.nom_vendedor = 'Alejandro')