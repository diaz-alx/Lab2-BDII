--TIPOS AHORRO
CREATE OR REPLACE PROCEDURE Nuevo_tipoAhorro(
    p_ahorro_descripcion  IN tipos_ahorros.descripcion%TYPE,
    p_ahorro_tasa_interes  IN tipos_ahorros.tasa_interes%TYPE
    )
IS
intSeqVal number(10);
BEGIN
    select sec_tipo_aho.nextval into intSeqVal from dual;
    INSERT into tipos_ahorros (id_tipo_ahorro, descripcion, tasa_interes)
    VALUES (intSeqVal, p_ahorro_descripcion, p_ahorro_tasa_interes);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de ahorro ya existe.');
END Nuevo_tipoAhorro;
/


