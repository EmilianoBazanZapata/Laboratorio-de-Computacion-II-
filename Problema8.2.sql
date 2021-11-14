select *
	from facturas f
	join detalle_facturas df
		on f.nro_factura=df.nro_factura
	join articulos a
		on df.cod_articulo=a.cod_articulo
	where
		MONTH(f.fecha)=MONTH(GETDATE())-3 and YEAR(f.fecha)=YEAR(GETDATE())
		
SELECT f.nro_factura,
       fecha,
       descripcion,
       cantidad,
       d.pre_unitario,
       cantidad * d.pre_unitario 'Importe'
  FROM facturas f
  JOIN detalle_facturas d
    ON f.nro_factura = d.nro_factura
  JOIN articulos a
    ON d.cod_articulo = a.cod_articulo
 WHERE MONTH(fecha) = MONTH(GETDATE()) - 1