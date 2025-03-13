drop table prestamo;
drop SEQUENCE seq_prestamo;
drop table libro;
drop table empleado;
drop table sucursal;
drop table socio;
drop table autor;
drop table categoria;

-- 1 y 2.Crear tablas y restricciones:
create table categoria(
    id_categoria integer primary key,
    nombre varchar2(30) unique not null,
    descripcion varchar2(100)
);
create table autor(
    id_autor integer primary key,
    nombre varchar2(30) unique not null,
    apellido varchar2(30) not null,
    nacionalidad varchar2(30),
    fecha_nacimiento date not null
);
create table socio(
    id_socio integer primary key,
    nombre varchar2(30) not null,
    apellido varchar2(30) not null,
    direccion varchar2(100),
    telefono varchar2(15),
    fecha_registro date not null
);
create table sucursal(
    -- 3. Implementar columna auto incrementable:
    id_sucursal integer GENERATED always as identity primary key,
    nombre_sucursal varchar2(30) not null,
    direccion varchar2(100) not null
);
create table empleado(
    id_empleado integer primary key,
    nombre varchar2(30) not null,
    apellido varchar2(30) not null,
    cargo varchar2(30) not null,
    sueldo integer not null,
    id_sucursal integer not null,
    CONSTRAINT FK_sucursal foreign key(id_sucursal) REFERENCES sucursal(id_sucursal)
);
create table libro(
    id_libro integer primary key,
    titulo varchar2(100) not null check(length(titulo) >= 3),
    stock integer not null check(stock >= 0),
    precio integer not null,
    id_autor integer not null,
    id_categoria integer not null,
    CONSTRAINT FK_autor foreign key(id_autor) references autor(id_autor),
    CONSTRAINT FK_categoria foreign key(id_categoria) references categoria(id_categoria)
);
-- 4. Implementar uso de Objeto Secuencia:
create SEQUENCE seq_prestamo
start with 1001;
create table prestamo(
    id_prestamo integer primary key,
    fecha_prestamo date default sysdate not null,
    fecha_devolucion date,
    id_socio integer not null,
    id_libro integer not null,
    id_empleado integer not null,
    CONSTRAINT FK_socio foreign key(id_socio) references socio(id_socio),
    CONSTRAINT FK_libro foreign key(id_libro) references libro(id_libro),
    CONSTRAINT FK_empleado foreign key(id_empleado) references empleado(id_empleado)
);

-- 5. Poblar las tablas:
-- Categoria:
insert into categoria VALUES(1,'Misterio',null);
insert into categoria VALUES(2,'Thriller',null);
insert into categoria VALUES(3,'Romance',null);
insert into categoria VALUES(4,'Educativo',null);
insert into categoria VALUES(5,'Infantil',null);

-- Autor:
insert into autor values(12345678,'Pedro','Morales',null,'15/04/68');
insert into autor values(12345679,'Maria','Lopez',null,'30/07/76');
insert into autor values(12345671,'Marta','Gonzalez',null,'01/02/70');
insert into autor values(12345672,'Edgar','Allan Poe',null,'19/01/1809');
insert into autor values(12345673,'Luis','Ramirez',null,'06/12/89');

-- Socio:
INSERT INTO socio VALUES (1, 'Juan', 'Pérez', 'Av. Siempre Viva 123', '987654321', '01/10/23');
INSERT INTO socio VALUES (2, 'María', 'González', 'Calle Falsa 456', '912345678', '15/11/23');
INSERT INTO socio VALUES (3, 'Carlos', 'López', 'Pasaje Las Rosas 789', '923456789', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO socio VALUES (4, 'Ana', 'Torres', 'Camino del Sol 321', '934567890', TO_DATE('2024-02-20', 'YYYY-MM-DD'));
INSERT INTO socio VALUES (5, 'Lucía', 'Martínez', null, '945678901', TO_DATE('2024-03-10', 'YYYY-MM-DD'));

-- Sucursal:
insert into sucursal (nombre_sucursal,direccion) values('sucursal puente alto','1231231');
insert into sucursal (nombre_sucursal,direccion) values('sucursal providencia','1232342');
insert into sucursal (nombre_sucursal,direccion) values('sucursal santiago','1231324325sfsdf');
insert into sucursal (nombre_sucursal,direccion) values('sucursal copiapo','123122253r1');
insert into sucursal (nombre_sucursal,direccion) values('sucursal san bernardo','123145r331');

-- Empleado:
insert into empleado values(11222333,'Juan', 'Pérez','vendedor',650000,1);
insert into empleado values(11222444,'Juan', 'Pérez','administrador',1000000,1);

-- Libro:
insert into libro values(1, 'el libro', 14,20000,12345678,2);
insert into libro values(2, 'el librito', 50,30000,12345678,3);

-- Prestamo:
insert into prestamo values(seq_prestamo.nextval,default,null,3,1,11222333);
insert into prestamo values(seq_prestamo.nextval,default,null,5,2,11222444);

-- Consultas:
-- Socio:
SELECT 
    * 
FROM socio
where direccion != (null)
order by apellido;

-- Libro:
SELECT 
    l.id_libro,
    l.titulo "Titulo",  
    c.nombre "Categoría",
    a.nombre||' '||a.apellido "Autor",
    '$'||l.precio "Precio"
FROM libro l 
join categoria c on l.id_categoria = c.id_categoria 
join autor a on l.id_autor = a.id_autor
where precio BETWEEN 10000 and 50000
order by precio asc;