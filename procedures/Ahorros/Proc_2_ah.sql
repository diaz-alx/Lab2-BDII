/*
Procedimiento almacenado para la apertura o inserción de los ahorros aprobados
con toda la información correspondiente..
*/


CREATE OR REPLACE PROCEDURE insertAhorro(
    p_id_cliente            IN ahorros.id_cliente%TYPE,
    p_tipo_ahorro     IN ahorros.tipo_ahorro%TYPE,
    p_cod_sucursal        IN ahorros.cod_sucursal%TYPE,
    p_depo_mensual          IN ahorros.deposito_mensual%TYPE,
    p_fecha_deposito            IN ahorros.fecha_deposito%TYPE,
    p_fecha_retiro        IN ahorros.fecha_retiro%TYPE
)
IS
  v_tipo_ahorro NUMBER := p_tipo_ahorro;
  intSeqVal number(10);
  v_fecha_ap date := SYSDATE;
  v_saldo_ah number := 0;
  v_interes NUMBER := 0;
  v_saldoInteres NUMBER := 0;
  v_fecha_deposito number := p_fecha_deposito;
  v_fecha_retiro NUMBER := p_fecha_retiro;
  
BEGIN

  select sec_no_cuenta.nextval into intSeqVal from dual;
  SELECT tasa_interes INTO v_interes FROM TIPOS_AHORROS WHERE id_tipo_ahorro = v_tipo_ahorro;

INSERT INTO AHORROS

VALUES (
    intSeqVal,
    p_id_cliente,
    p_tipo_ahorro,
    p_cod_sucursal,
    to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    v_interes,
    p_depo_mensual,
    v_saldo_ah,
    v_saldoInteres,
    user,
    v_fecha_deposito,
    v_fecha_retiro,
    to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS')
    );

COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El numero de cuenta ya existe.');
END insertAhorro;
/


--PARAMETROS id_cliente, tipo_ahorro, cod_sucursal, monto deposito, fecha deposito=dia, fecha retiro=dia 
EXECUTE insertAhorro(2,1,22,10,15,10);

EXECUTE insertAhorro(2,
1,
22,
10,
15,
10);