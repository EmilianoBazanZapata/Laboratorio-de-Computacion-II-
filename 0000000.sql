SELECT cod_cliente 'Código',nom_cliente +' '+ ape_cliente 'Cliente'
  FROM clientes c
 WHERE 9 < (SELECT COUNT(*) 
              FROM facturas f
             WHERE YEAR(fecha) = YEAR(GETDATE())-1)

SELECT cod_cliente 'Código',nom_cliente +' '+ ape_cliente 'Cliente'
  FROM clientes c
 WHERE 9 < (SELECT COUNT(*) 
              FROM facturas f
             WHERE YEAR(fecha) = YEAR(GETDATE())-1
				and f.cod_cliente=c.cod_cliente)

SELECT c.cod_cliente 'Código',COUNT(*) Cantidad
	FROM clientes c,facturas f,detalle_facturas df
	where c.cod_cliente=f.cod_cliente and f.nro_factura=df.nro_factura
		and YEAR(f.fecha)=YEAR(GETDATE()-1)
	group by c.cod_cliente