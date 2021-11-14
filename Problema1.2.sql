select * from vendedores 
		where descripcion like '%Rivadavia%'
--2.1
update articulos
	set stock_minimo=null,
		observaciones='Regla - escuadra y transportador',
		pre_unitario=20.50
		where cod_articulo=29
--2.2
update articulos
	set	descripcion='Repuesto Rivadavia cuadriculado',
		observaciones='48 hojas'
	where descripcion='Respuesto Rivadavia'
--2.3
update vendedores
	set	[e-mail]='jmonti@gmail.com',
		fec_nac='1970-10-10'
	where ape_vendedor='Monti' and nom_vendedor='Juan'
--2.4
update vendedores
	set	nro_tel=4522221,
		calle='Av. Velez Sarsfield',
		altura=125,
		cod_barrio=1
	where ape_vendedor='Sena' and nom_vendedor='Rosa'
--2.5
update articulos
	set	pre_unitario=pre_unitario*1.15
	where pre_unitario<20
--2.6
update articulos
	set pre_unitario=pre_unitario*1.1
	where pre_unitario between 20 and 30	