drop table cliente;
create table cliente(
    codigo integer GENERATED ALWAYS as identity primary key,
    nombre varchar2(30) not null check(length(nombre)>=3),
    apellido varchar2(30) default 'no registrado' not null,
    fecha_nac Date default sysdate,
    correo varchar2(50) UNIQUE not null,
    renta integer not null check(renta>700000)
);

insert into cliente(nombre,apellido,fecha_nac,correo,renta)
    values('Juan',default,TO_DATE('01/09/1999'),'j.soto@duoc.cl',710000);
insert into cliente(nombre,apellido,fecha_nac,correo,renta)
    values('Camila','Lara',default,'clara@duoc.cl',854000);
insert into cliente(nombre,apellido,fecha_nac,correo,renta)
    values('Lin','Yung',TO_DATE('20/05/2004'),'linyung@duoc.cl',1554000);
    
SELECT
    *
FROM cliente;

drop table producto;
drop SEQUENCE seq_producto;
create table producto(
    codigo integer primary key,
    nombre varchar2(30) not null check(length(nombre) > 0),
    descripcion varchar2(100) not null,
    fecha_registro date default sysdate not null,
    tipo varchar2(30) not null check(tipo in ('comestible','electrodomestico','vestimenta')),
    precio integer not null check(precio > 0),
    stock integer not null check(stock>0)
);

create sequence seq_producto
    start with 100
    increment by 10;
    
insert into producto values(SEQ_PRODUCTO.nextval,
                            'Lapiz azul',
                            'Bonito lapiz de tinta azul',
                            default,
                            'electrodomestico',
                            1500,
                            10);
insert into producto values(SEQ_PRODUCTO.nextval,
                            'Lapiz rojo',
                            'Bonito lapiz de tinta roja',
                            default,
                            'electrodomestico',
                            1500,
                            10);
insert into producto values(SEQ_PRODUCTO.nextval,
                            'Lapiz verde',
                            'Bonito lapiz de tinta verde',
                            default,
                            'electrodomestico',
                            1500,
                            10);

SELECT
    *
FROM producto;