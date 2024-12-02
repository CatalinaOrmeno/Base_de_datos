drop table prestamo;
drop table autor;
drop table libro;

create table libro(
    ISBN varchar2(15) primary key,
    titulo varchar2(30) not null,
    editorial varchar2(50) not null,
    ejemplares_disponibles integer not null,
    fecha_publicacion date not null,
    genero varchar2(15) not null
);
create table autor(
    rut integer primary key,
    nombre varchar2(30) not null,
    nacionalidad varchar2(30) not null
);
create table prestamo(
    fecha_prestamo date not null,
    fecha_devolucion date not null,
    aplica_multa varchar2(2) not null,
    total_multa integer not null
);