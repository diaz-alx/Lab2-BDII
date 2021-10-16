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
END;
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
END;
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
END;
/

--TIPOS profesion
CREATE or REPLACE PROCEDURE Nuevo_tipoprofesion(
    p_profesion    IN profesiones.descripcion%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_profesion.nextval into intSeqVal from dual;
    INSERT into PROFESIONES(id_profesion,descripcion)
    VALUES (intSeqVal,p_profesion);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La profesion ya existe.');
END;
/

--Distritos
CREATE or REPLACE PROCEDURE Nuevo_distrito(
    p_profesion    IN profesiones.descripcion%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_profesion.nextval into intSeqVal from dual;
    INSERT into PROFESIONES(id_profesion,descripcion)
    VALUES (intSeqVal,p_profesion);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La profesion ya existe.');
END;
/

--Provincias
CREATE or REPLACE PROCEDURE Nuevo_tipoprofesion(
    p_profesion    IN profesiones.descripcion%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_profesion.nextval into intSeqVal from dual;
    INSERT into PROFESIONES(id_profesion,descripcion)
    VALUES (intSeqVal,p_profesion);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La profesion ya existe.');
END;
/

CREATE or REPLACE PROCEDURE insertNewColab(
    p_Nombre_Colab    IN colaboradores.nombre%TYPE,
    p_Apellido_Colab  IN colaboradores.apellido%TYPE,
    p_cedula_colab    IN colaboradores.cedula%TYPE,
    p_sexo_colab      IN COLABORADORES.SEXO%TYPE,
    p_fecha_nac       IN colaboradores.fecha_nacimiento%TYPE,
    p_Status_colab    IN colaboradores.status%TYPE,
    p_SalarioM_Colab  IN colaboradores.salario_mensual%TYPE)
IS
intSeqVal number(10);
v_fechaIn date;
BEGIN
    select SEC_ID_COLABORADOR.nextval into intSeqVal from dual;
    select SYSDATE into v_fechaIn from DUAL;
    INSERT into COLABORADORES (id_codcolaborador,nombre,apellido,cedula,sexo,
            fecha_nacimiento,fecha_ingreso,status,salario_mensual)
    VALUES (intSeqVal, p_Nombre_Colab, p_Apellido_Colab, p_cedula_colab, p_sexo_colab,
            to_date(p_fecha_nac,'DD-MON-YY'),v_fechaIn, p_Status_colab, p_SalarioM_Colab);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El usuario ya existe la tabla de colaboradores');
END;
/