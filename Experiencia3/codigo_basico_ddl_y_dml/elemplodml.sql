-- eliminar tablas:
drop table EMPLEADO;
drop table DEPARTAMENTO;

-- crear tablas:
create table DEPARTAMENTO(
    codigo integer primary key,
    nombre varchar2(30) not null
);

create table EMPLEADO(
    rut integer primary key,
    nombre varchar2(30) not null,
    apellido varchar2(30) not null,
    sueldo integer not null,
    DEPARTAMENTO_codigo integer not null,
    fecha_contrato Date not null
);

-- marcar claves foraneas:
alter table EMPLEADO
add CONSTRAINT FK_DEPARTAMENTO
foreign key (DEPARTAMENTO_codigo)
references DEPARTAMENTO(codigo);

-- DML:
-- (INSERT)Insertar datos en las tablas:
INSERT into DEPARTAMENTO VALUES(10,'Recursos humanos');
INSERT into DEPARTAMENTO VALUES(20,'Finanzas');
INSERT into DEPARTAMENTO VALUES(30,'Ti');
INSERT into DEPARTAMENTO VALUES(40,'Prevencion de riesgos');
INSERT into DEPARTAMENTO VALUES(50,'Logística');

insert into EMPLEADO VALUES(112223334,'Pedro','Lara',1000000,20,SYSDATE);
insert into EMPLEADO VALUES(112223335,'Camila','Flores',6000000,50,TO_DATE('01/02/2022'));
insert into EMPLEADO VALUES(112223336,'Javiera','Gonzales',450000,20,TO_DATE('10/09/2023'));
insert into EMPLEADO VALUES(112223337,'Camilo','Soto',1200000,30,sysdate);
insert into EMPLEADO VALUES(112223338,'Ana','Perez',1300000,30,to_date('15/11/2023'));

-- (SELECT)Mostrar datos de la tabla:
select * from empleado;
select * from empleado where departamento_codigo = 30;
select * from empleado where sueldo < 1000000;
select * from empleado where sueldo > 1200000 and departamento_codigo = 30;

-- Mostrar los datos de forma personalizada:
select 
    initcap(nombre||' '||apellido) "Nombre completo",
    '$'||sueldo "Sueldo antiguo",
    '$'||sueldo * 1.1 "Sueldo aumentado"
from empleado;

-- (DELETE)Eliminar datos de la tabla:
delete from empleado where rut = 112223335;

-- (UPTADE)Actualizar datos de la tabla:
update empleado set sueldo =600000 where rut = 112223335;

-- TCL:
commit;-- Sirve para guardar los cambios a la base de datos, es irrevercible.
SAVEPOINT A1;-- Crea un punto de guardado.
rollback to A1;-- Vuelve a un punto de guardado.