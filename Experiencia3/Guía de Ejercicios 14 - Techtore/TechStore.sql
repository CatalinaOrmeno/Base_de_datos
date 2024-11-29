-- Eliminar tablas:
drop sequence seq_venta;
drop table detalle;
drop table venta;
drop table sucursal;
drop table comuna;
drop table producto;
drop table region;
drop table cliente;
drop table vendedor;

-- Crear tablas:
create table vendedor(
    rut_vendedor integer primary key,
    nombre varchar2(30) not null,
    appaterno varchar2(30) not null,
    apmaterno varchar2(30) not null,
    sueldo integer not null
);
create table cliente(
    rut_cliente integer primary key,
    nombre varchar2(30) not null,
    appaterno varchar2(30) not null,
    apmaterno varchar2(30) not null,
    fecha_nacimiento Date not null
);
create table region(
    codigo_region integer primary key,
    nombre_region varchar2(30) unique not null
);
create table producto(
    codigo_producto integer primary key,
    nombre_producto varchar2(50) not null,
    stock integer not null check(stock > 0),
    precio integer not null
);
create table comuna(
    codigo_comuna integer primary key,
    nombre_comuna varchar2(30) unique not null,
    codigo_region integer not null
);
create table sucursal(
    codigo_sucursal integer generated always as identity primary key,-- el código se genera automaticamente de 1 en 1.
    nombre_sucursal varchar2(30) not null,
    codigo_comuna integer not null
);
-- Crear la sequencia para las ventas:
create sequence seq_venta
start with 4001
increment by 1;
create table venta(
    codigo_venta integer primary key,
    fecha_venta date default sysdate not null,
    total integer not null,
    codigo_sucursal integer not null,
    rut_cliente integer not null,
    rut_vendedor integer not null
);
create table detalle(
    codigo_venta integer not null,
    codigo_producto integer not null
);

-- Definir claves foraneas:
-- Región y comuna:
alter table comuna
add CONSTRAINT FK_region
foreign key (codigo_region)
references region(codigo_region)
;
-- Comuna y sucursal:
alter table sucursal
add constraint FK_comuna
foreign key (codigo_comuna)
references comuna(codigo_comuna)
;
-- Sucursal y venta:
alter table venta
add constraint FK_sucursal
foreign key (codigo_sucursal)
references sucursal(codigo_sucursal)
;
-- Vendedor y venta:
alter table venta
add constraint FK_vendedor
foreign key (rut_vendedor)
references vendedor(rut_vendedor)
;
-- Cliente y venta:
alter table venta
add constraint FK_cliente
foreign key (rut_cliente)
references cliente(rut_cliente)
;
-- Venta y detalle:
alter table detalle
add constraint FK_venta
foreign key (codigo_venta)
references venta(codigo_venta)
;
-- Producto y detalle:
alter table detalle
add constraint FK_producto
foreign key (codigo_producto)
references producto(codigo_producto)
;
-- Definir clave primaria de detalle:
alter table detalle
add constraint PK_detalle
primary key(codigo_venta,codigo_producto)
;

-- Poblar las listas:
-- Tabla region
INSERT INTO region (codigo_region, nombre_region) VALUES (1, 'Metropolitana');
INSERT INTO region (codigo_region, nombre_region) VALUES (2, 'Valparaíso');
INSERT INTO region (codigo_region, nombre_region) VALUES (3, 'Biobío');
INSERT INTO region (codigo_region, nombre_region) VALUES (4, 'Araucanía');
INSERT INTO region (codigo_region, nombre_region) VALUES (5, 'Atacama');

-- Tabla comuna
INSERT INTO comuna (codigo_comuna, nombre_comuna, codigo_region) VALUES (101, 'Santiago', 1);
INSERT INTO comuna (codigo_comuna, nombre_comuna, codigo_region) VALUES (102, 'Providencia', 1);
INSERT INTO comuna (codigo_comuna, nombre_comuna, codigo_region) VALUES (201, 'Viña del Mar', 2);
INSERT INTO comuna (codigo_comuna, nombre_comuna, codigo_region) VALUES (301, 'Concepción', 3);
INSERT INTO comuna (codigo_comuna, nombre_comuna, codigo_region) VALUES (401, 'Temuco', 4);

-- Tabla producto
INSERT INTO producto (codigo_producto, nombre_producto, stock, precio) 
VALUES (3001, 'Laptop', 20, 500000);
INSERT INTO producto (codigo_producto, nombre_producto, stock, precio) 
VALUES (3002, 'Smartphone', 50, 200000);
INSERT INTO producto (codigo_producto, nombre_producto, stock, precio) 
VALUES (3003, 'Monitor', 30, 150000);
INSERT INTO producto (codigo_producto, nombre_producto, stock, precio) 
VALUES (3004, 'Teclado', 100, 20000);
INSERT INTO producto (codigo_producto, nombre_producto, stock, precio) 
VALUES (3005, 'Mouse', 120, 15000);

-- Tabla sucursal:
insert into sucursal(nombre_sucursal,codigo_comuna) VALUES ('Sucursal Centro',101);
insert into sucursal(nombre_sucursal,codigo_comuna) VALUES ('Sucursal Providencia',102);
insert into sucursal(nombre_sucursal,codigo_comuna) VALUES ('Sucursal Viña',201);
insert into sucursal(nombre_sucursal,codigo_comuna) VALUES ('Sucursal Concepción',301);
insert into sucursal(nombre_sucursal,codigo_comuna) VALUES ('Sucursal Temuco',401);

-- Tabla cliente:
insert into cliente values(1001,'Juan','Pérez','López','15/06/85');
insert into cliente values(1002,'María','González','Figueroa','22/08/90');
insert into cliente values(1003,'Pedro','Soto','Martínez','03/12/80');
insert into cliente values(1004,'Ana','Ramírez','Torres','10/05/95');
insert into cliente values(1005,'Carlos','López','Vargas','18/02/00');

-- Tabla vendedor:
insert into vendedor values(2001,'Javier','Morales','Rojas',800000);
insert into vendedor values(2002,'Paula','Castillo','Navarro',850000);
insert into vendedor values(2003,'Sofía','Méndez','Silva',900000);
insert into vendedor values(2004,'Ricardo','Fernández','Cruz',750000);
insert into vendedor values(2005,'Lucía','Vega','Araya',880000);

-- Tabla venta:
insert into venta values(seq_venta.nextval,'01/11/24',720000,1,1001,2001);
insert into venta values(seq_venta.nextval,'02/11/24',200000,2,1002,2002);
insert into venta values(seq_venta.nextval,'03/11/24',150000,3,1003,2003);
insert into venta values(seq_venta.nextval,'04/11/24',20000,4,1004,2004);
insert into venta values(seq_venta.nextval,'05/11/24',15000,5,1005,2005);

-- Tabla detalle:
insert into detalle values(4001,3001);
insert into detalle values(4002,3002);
insert into detalle values(4003,3003);
insert into detalle values(4004,3004);
insert into detalle values(4005,3005);

-- Generar consultas:
-- 1:
SELECT * 
FROM vendedor 
where sueldo > 800000
order by sueldo desc;

-- 2:
SELECT * 
FROM venta
where fecha_venta like '%&Ingrese_año_de_consulta'
order by codigo_venta;

-- 3:
SELECT * 
FROM producto
where stock between 10 and 50
order by stock asc;

-- 4:
SELECT 
    nombre||' '||appaterno||' '||apmaterno "Nombre completo"
FROM cliente
where rut_cliente = &Ingrese_el_rut_del_cliente;

-- 5:
SELECT * 
FROM cliente
where fecha_nacimiento like '%/12/%'
order by fecha_nacimiento asc;