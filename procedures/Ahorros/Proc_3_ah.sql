/*
Procedimiento almacenado para la carga o inserción de los préstamos aprobados 
con toda la información correspondiente e igualmente este proceso deberá 
actualizar la información de préstamo en la tabla de sucursales.
*/

CREATE OR REPLACE PROCEDURE insertTransaDeporeti (
  p_id_cliente IN transaDepoReti.id_cliente%TYPE,
  p_no_cuenta IN transaDepoReti.no_cuenta%TYPE, 
  p_tipo_ahorro IN transaDepoReti.tipo_ahorro%TYPE,
  p_cod_sucursal IN transaDepoReti.cod_sucursal%TYPE,
  p_tipo_transac IN transaDepoReti.tipo_transac%TYPE,
  p_monto IN transaDepoReti.monto%TYPE
)
IS
  intSeqVal number(10);
  --v_fecha_ap date := SYSDATE;
  --v_usuario VARCHAR2(45) := USER;
  v_status CHAR(2) := 'PE';
  v_monto NUMBER(15,2) := p_monto;
  --v_exception VARCHAR2(250) := EXCEPTION;
BEGIN
  select sec_transacdeporeti.nextval into intSeqVal from dual;

-- CONDICION DE TRANSACCION 1= DEPOSITO, 2=RETIRO solo de cuenta corriente se puede retirar.

IF p_tipo_ahorro = 2 AND (p_tipo_transac = 1 OR  p_tipo_transac =2 ) THEN
  INSERT INTO transaDepoReti
  VALUES(
    intSeqVal,
    p_no_cuenta,
    p_id_cliente,
    p_tipo_ahorro,
    p_cod_sucursal,
    --to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    SYSDATE,
    p_tipo_transac,
    v_monto,
    --to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    SYSDATE,
    v_status,
    user
  );

ELSIF (p_tipo_ahorro = 1 OR p_tipo_ahorro = 3) AND p_tipo_transac = 1 THEN
  INSERT INTO transaDepoReti
  VALUES(
    intSeqVal,
    p_no_cuenta,
    p_id_cliente,
    p_tipo_ahorro,
    p_cod_sucursal,
    --to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    SYSDATE,
    p_tipo_transac,
    v_monto,
    --to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    SYSDATE,
    v_status,
    user
  );
ELSE
  DBMS_OUTPUT.PUT_LINE('💣 Error: El tiempo de retiro no puede realizarse en este momento. Verifique su tipo de cuenta.');



END IF;
COMMIT;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La transacción no existe.');
END insertTransaDeporeti;
/