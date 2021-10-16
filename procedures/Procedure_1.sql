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