select sum(df.cantidad) Cant, sum(df.cantidad*df.pre_unitario) Total, AVG(df.cantidad*df.pre_unitario) Prom
	from facturas f, detalle_facturas df, vendedores v
	where f.nro_factura=df.nro_factura
		and f.cod_vendedor=v.cod_vendedor
		and v.nom_vendedor like '[d-l]%'