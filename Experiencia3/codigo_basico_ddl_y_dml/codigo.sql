SAVEPOINT desdecero;

--Select:
-- 1:
select 
    NOMBRE_EMP "Nombre",
    APPATERNO_EMP||' '||APMATERNO_EMP "Apellidos",
    '$'||SUELDO_EMP "Sueldo"
from empleado;
-- 2:
select 
    NOMBRE_cli ||' '||APPATERNO_cli||' '||APMATERNO_cli "Nombre completo",
    DIRECCION_CLI "Dirección"
from cliente;
-- 3:
select 
    NOMBRE_cli "Nombre",
    RENTA_CLI "Renta mensual"
from cliente where RENTA_CLI > 1500000;
-- 4:
SELECT
    DIRECCION_PROPIEDAD "Dirección",
    VALOR_ARRIENDO "Valor arriendo"
FROM propiedad where ID_TIPO_PROPIEDAD = 'B';
-- 5:
select 
    NOMBRE_EMP "Nombre",
    APPATERNO_EMP||' '||APMATERNO_EMP "Apellidos"
from empleado where SUELDO_EMP > 1000000;
SELECT
    *
FROM comuna;
-- Insert:
-- 1:
insert into cliente VALUES(11222345,'4','Paterno','Materno','Nombre','Dirección #1234',1,123456789,null,1200000);
-- 2:
INSERT into propietario values(11222345,'4','Paterno','Materno','Nombre','Dirección #1234',1,123456789,null,93);
insert into propiedad VALUES(1028,'direccion #789',200,4,2,5000000,100000,'G',81,11222345,11636534);
-- 3:
INSERT into estado_civil values(6,'Unión libre');

-- Update:
-- 1:
update propiedad set valor_arriendo = valor_arriendo * 1.1
where id_tipo_propiedad = 'D';
-- 2:
update cliente set direccion_cli = 'Direccion nueva #999'
where numrut_cli = 11222345;
-- 3:
update empleado set sueldo_emp = sueldo_emp * 1.05
where sueldo_emp < 1000000;
-- 4:
update propietario set id_estcivil = 4
where id_estcivil = 3;

ROLLBACK desdecero;