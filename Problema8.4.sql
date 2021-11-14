select a.descripcion,df.cantidad,df.pre_unitario
	from facturas f
	join detalle_facturas df
		on df.nro_factura=f.nro_factura
	right join articulos a
		on df.cod_articulo=a.cod_articulo
		
SELECT descripcion, 
       cantidad, 
       d.pre_unitario * cantidad 'Importe'
  FROM articulos a
  LEFT JOIN detalle_facturas d
    ON a.cod_articulo = d.cod_articulo
	