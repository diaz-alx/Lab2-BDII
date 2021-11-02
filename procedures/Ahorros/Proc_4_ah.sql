/*
Procedimiento almacenado que actualice los depósitos o retiros de las cuentas de
ahorro correspondientes. Deberá implementar un cursor que busque el
depósitos/retiros insertados en la tabla uno a uno y los vaya actualizando en la
tabla de ahorros de cada cliente (proceso en lote o proceso en línea usted decide).
De la siguiente forma:
* Si el tipo de ahorro es navidad o escolar por cada deposito realizado debe
calcular el interés que corresponde montodeposito * tasade interes% que
calculo que lo debe realizar una función diseñada previamente. El
procedimiento debe actualizar el saldo de ahorro y el saldo interés de la
cuenta de ahorro de los clientes
* Si el tipo de ahorro es corriente simplemente se realizar la aplicación del
depósito o retiro a la cuenta de ahorro del cliente correspondiente. De las
únicas cuentas que se puede realizar retiros es de la cuenta de ahorro
corriente por lo tanto el procedimiento debe controlar esta situación.
*/



CREATE OR REPLACE FUNCTION calcularInteres(
    p_tipoInteres number,
    p_monto number
)
RETURN NUMBER IS
   V_interes_calculado NUMBER;
   v_monto NUMBER := p_monto;
   v_interes NUMBER;
   --v_exeption EXCEPTION;
BEGIN
    -- ASIGNA EL VALOR DEL INTERES EN BASE AL TIPO DE AHORRO
    IF p_tipoInteres = 1 THEN
    v_interes := 0.06;
    ELSIF p_tipoInteres = 2 THEN
    v_interes := 0.04;
    ELSIF p_tipoInteres = 3 THEN
    v_interes := 0.06;
    END IF;
   -- Interes calculado mediante el valor depositado y el tipo de interes
    v_interes_calculado := (v_monto * v_interes) + v_monto;
 
   RETURN v_interes_calculado;
    EXCEPTION
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El préstamo no ha sido encontrado.');

END calcularInteres;
/


CREATE OR REPLACE PROCEDURE actualizarAhorros
IS
    v_id_transac NUMBER;
    v_no_cuenta NUMBER;
    v_id_cliente NUMBER;
    v_tipo_ahorro NUMBER; 
    v_cod_sucursal NUMBER;
    v_fecha_transac date;
    v_tipo_transac NUMBER;
    v_monto NUMBER(15, 2) DEFAULT 0;
    v_status char(2) := 'PE'; -- SOLO SE PROCESARAN LOS PENDIENTES

CURSOR c_transacDepoReti IS
    SELECT
        id_transaccion,
        no_cuenta, 
        id_cliente, 
        tipo_ahorro,
        cod_sucursal,
        fecha_transac,
        tipo_transac,
        monto
    FROM transaDepoReti
    WHERE
        status = v_status;
BEGIN

OPEN c_transaDepoReti;
    LOOP
    FETCH c_transaDepoReti INTO
        v_id_transac,
        v_no_cuenta,
        v_id_cliente,
        v_tipo_ahorro,
        v_cod_sucursal,
        v_fecha_transac,
        v_tipo_transac,
        v_monto;
    EXIT
    WHEN c_transadeporeti%NOTFOUND;
    
    -- CONDICION DE TRANSACCION 1= DEPOSITO, 2=RETIRO

    IF  v_tipo_transac = 1 THEN
    UPDATE AHORROS
    SET 
    saldo_ahorro = calcularInteres(v_tipo_prestamo,saldo_actual) + v_monto_pago,
    saldo_interes = saldo_interes + v_saldo_ah,
    fecha_mod = SYSDATE
    WHERE
    no_cuenta = v_no_cuenta;

    ELSIF v_tipo_transac = 2 THEN
    UPDATE AHORROS
    SET 
    saldo_ahorro = calcularInteres(v_tipo_prestamo,saldo_actual) - v_monto_pago,
    saldo_interes = saldo_interes + v_saldo_ah
    fecha_mod = SYSDATE
    WHERE
    no_cuenta = v_no_cuenta;
    END IF;

    --ACTUALIZA EL ESTADO DEL DEPOSITO O RETIRO PARA QUE NO SE VUELVA A REPETIR
    UPDATE TRANSADEPORETI
    SET
    status = 'PR'
    WHERE
    id_transaccion = v_id_transac;

    END LOOP;
CLOSE c_transadeporeti;

END;
/
