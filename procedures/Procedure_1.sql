--TIPOS CORREOS
CREATE or REPLACE PROCEDURE Nuevo_tipoCorreo(
    p_Correo    IN tipos_correos.descripcion%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_correo.nextval into intSeqVal from dual;
    INSERT into TIPOS_CORREOS (cod_correo,descripcion)
    VALUES (intSeqVal,p_Correo);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de correo ya existe.');
END Nuevo_tipoCorreo;
/

--TIPOS PRESTAMOS
CREATE or REPLACE PROCEDURE Nuevo_tipoPrestamo(
    p_prestam    IN tipos_prestamos.nombre_prestamo%TYPE,
    p_interes    IN TIPOS_PRESTAMOS.TASA_INTERES%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_prestamo.nextval into intSeqVal from dual;
    INSERT into TIPOS_PRESTAMOS (cod_prestamo,nombre_prestamo,tasa_interes)
    VALUES (intSeqVal,p_prestam,p_tasa_interes);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de prestamo ya existe.');
END Nuevo_tipoPrestamo;
/

--TIPOS telefonos
CREATE or REPLACE PROCEDURE Nuevo_tipotelefonos(
    p_telefonos    IN tipos_telefonos.descripcion%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_telefono.nextval into intSeqVal from dual;
    INSERT into TIPOS_TELEFONOS (cod_telefono,descripcion)
    VALUES (intSeqVal,p_telefonos);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de telefono ya existe.');
END Nuevo_tipotelefonos;
/

--TIPOS profesion
CREATE or REPLACE PROCEDURE Nuevo_tipoprofesion(
    p_profesion    IN profesiones.descripcion%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_id_profesion.nextval into intSeqVal from dual;
    INSERT into PROFESIONES(id_profesion,descripcion)
    VALUES (intSeqVal,p_profesion);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La profesion ya existe.');
END Nuevo_tipoprofesion;
/

--Distritos
CREATE or REPLACE PROCEDURE NuevoDistrito(
    p_distrito    IN distritos.nombre%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_distrito.nextval into intSeqVal from dual;
    INSERT into DISTRITOS(cod_distrito,nombre)
    VALUES (intSeqVal,p_distrito);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El distrito ya existe.');
END NuevoDistrito;
/

--Provincias
CREATE or REPLACE PROCEDURE NuevaProvincia(
    p_provincia    IN provincias.nombre%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_provincia.nextval into intSeqVal from dual;
    INSERT into PROVINCIAS(cod_provincia,nombre)
    VALUES (intSeqVal,p_provincia);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La provincia ya existe.');
END NuevaProvincia;
/

--sucursales
CREATE or REPLACE PROCEDURE NuevaSucursal(
    p_sucursal    IN SUCURSALES.nombre%TYPE,
    p_monto_pre   IN SUCURSALES.MONTO_PRESTAMO%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_sucursal.nextval into intSeqVal from dual;
    INSERT into SUCURSALES(COD_SUCURSAL,nombre,MONTO_PRESTAMO)
    VALUES (intSeqVal,p_sucursal,p_monto_pre);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La sucursal ya existe.');
END NuevaSucursal;
/
