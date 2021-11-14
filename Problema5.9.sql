select sum(df.cantidad) Cant, sum(df.cantidad*df.pre_unitario) Total, AVG(df.cantidad*df.pre_unitario) Prom
	from facturas f, detalle_facturas df, clientes c
	where f.nro_factura=df.nro_factura
		and f.cod_cliente=c.cod_cliente
		and c.ape_cliente='Paez'
		and c.nom_cliente='Roque'
		
select *
	from facturas f, detalle_facturas df, clientes c
	where f.nro_factura=df.nro_factura
		and f.cod_cliente=c.cod_cliente
		and c.ape_cliente='Paez'
		and c.nom_cliente='Roque'