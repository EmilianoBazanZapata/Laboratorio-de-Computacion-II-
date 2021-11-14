select f.cod_vendedor,f.cod_cliente,SUM(df.cantidad*df.pre_unitario)
	from facturas f,detalle_facturas df,vendedores v,clientes c
	where f.nro_factura=df.nro_factura and f.cod_cliente=c.cod_cliente
		and f.cod_vendedor=v.cod_vendedor
		and YEAR(f.fecha)=YEAR(GETDATE())-1
	group by f.cod_vendedor,f.cod_cliente
	having count(*)<5