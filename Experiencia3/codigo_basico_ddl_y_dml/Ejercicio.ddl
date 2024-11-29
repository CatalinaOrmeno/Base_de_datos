-- Eliminacion de tablas
DROP TABLE EMPLEADO_EMPRESA;
DROP TABLE REGISTRO_ASISTENCIA;
DROP TABLE COMUNA;
DROP TABLE EMPLEADO;
DROP TABLE PROVINCIA;
DROP TABLE MES;
DROP TABLE EMPRESA;
DROP TABLE ESTADO_CIVIL;
DROP TABLE REGION;

-- Creación de tablas
create table MES(
id_mes integer PRIMARY key,
descripcion varchar2(100) not null
);

create table REGISTRO_ASISTENCIA(
MES_id integer not null,
EMPLEADO_id integer not null,
id_registro_asistencia integer primary key,
dia integer not null,
anio integer not null
);

create table EMPLEADO(
COMUNA_id integer not null,
id_empleado integer primary key,
rut varchar2(30) not null,
nombre varchar2(30) not null,
apellido_p varchar2(30) not null,
apellido_m varchar2(30) not null,
fecha_nac Date not null,
sueldo integer not null,
ESTADO_CIVIL_id integer not null);

create table ESTADO_CIVIL(
id_estado_civil integer PRIMARY key,
descripcion varchar2(30) not null
);

create table REGION(
id_region integer PRIMARY key,
descripcion varchar2(100) not null
);

create table PROVINCIA(
id_provincia integer PRIMARY key,
descripcion varchar2(100) not null,
REGION_id integer not null
);

create table COMUNA(
id_comuna integer PRIMARY key,
descripcion varchar2(100) not null,
PROVINCIA_id integer not null
);

create table EMPRESA(
id_empresa integer PRIMARY key,
descripcion varchar2(100) not null,
fecha_creacion Date not null
);

create table EMPLEADO_EMPRESA(
EMPRESA_id integer not null,
EMPLEADO_id integer not null
);

-- Marcar claves foraneas
-- RegistroAsistencia y Mes:
alter table REGISTRO_ASISTENCIA
    add constraint FK_mes
    foreign key (MES_id)
    references MES(id_mes);

-- RegistroAsistencia y Empleado:
alter table REGISTRO_ASISTENCIA
    add constraint FK_empleado
    foreign key (EMPLEADO_id)
    references EMPLEADO(id_empleado);

-- Empleado y EstadoCivil:
alter table EMPLEADO
    add constraint FK_estado_civil
    foreign key (ESTADO_CIVIL_id)
    references ESTADO_CIVIL(id_estado_civil);

-- Empleado y Comuna:
alter table EMPLEADO
    add constraint FK_comuna
    foreign key (COMUNA_id)
    references COMUNA(id_comuna);

-- Provincia y Region:
alter table PROVINCIA
    add constraint FK_region
    foreign key (REGION_id)
    references REGION(id_region);

-- Comuna y Provincia:
alter table COMUNA
    add constraint FK_provincia
    foreign key (PROVINCIA_id)
    references PROVINCIA(id_provincia);

-- Empleado_empresa y Empleado:
alter table EMPLEADO_EMPRESA
    add constraint FK_empleado_2
    foreign key (EMPLEADO_id)
    references EMPLEADO(id_empleado);

-- Empleado_empresa y Empleado:
alter table EMPLEADO_EMPRESA
    add constraint FK_empresa
    foreign key (EMPRESA_id)
    references EMPRESA(id_empresa);

-- Agregar clave primaria de EMPLEADO_EMPRESA:
alter table EMPLEADO_EMPRESA
    add constraint PK_empleado_empresa
    primary key (EMPRESA_id,EMPLEADO_id);