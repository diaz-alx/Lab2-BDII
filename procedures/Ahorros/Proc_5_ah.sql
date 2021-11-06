/*

Llegamos a fin de mes y hay pagar los interés a la cuenta de ahorro
corriente. Deberá diseñar un cursor que consulte todos los ahorros corrientes de
forma controlada y calcule los interés que habrá que pagar mensualmente a estos
ahorros (saldo de ahorros por la tasade interes% ) este cálculo lo realizar una
función. El procedimiento deberá actualizar el saldo del ahorro y saldo de interés
de las cuentas.’ El interés es sumado al saldo de ahorro’.
*/


-- Función de calcular interés

CREATE OR REPLACE PROCEDURE calcularInteresDeCorriente
IS
  v_no_cuenta NUMBER;
  v_tipo_ahorro NUMBER := 2;
  v_saldo_ahorro NUMBER;
  v_saldo_interes NUMBER;


  CURSOR c_ahorros IS
    SELECT
        no_cuenta,
        tipo_ahorro, 
        saldo_ahorro, 
        saldo_interes
    FROM AHORROS
    WHERE
        tipo_ahorro = v_tipo_ahorro;
  BEGIN
  

  OPEN c_ahorros;
    LOOP 
    FETCH c_ahorros INTO
      v_no_cuenta,
      v_tipo_ahorro,
      v_saldo_ahorro,
      v_saldo_interes;
    EXIT 
    WHEN c_ahorros%NOTFOUND;

    -- IF to_char(CURRENT_DATE, 'dd') = '01' OR to_char(CURRENT_DATE, 'dd') = '15' THEN
    IF to_char(CURRENT_DATE, 'dd') = '05' THEN
    --IF v_tipo_ahorro = 2
    --THEN
    UPDATE AHORROS
    SET
    saldo_interes = (calcularInteresDelAhorro(v_tipo_ahorro,v_saldo_ahorro) - v_saldo_ahorro),
    saldo_ahorro = calcularInteresDelAhorro(v_tipo_ahorro,v_saldo_ahorro),
    fecha_mod = SYSDATE
    WHERE no_cuenta = v_no_cuenta;
    END IF;

    END LOOP;

  CLOSE c_ahorros;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('💣 Error: Los datos suministrados no existen');

  END calcularInteresDeCorriente;
/

EXECUTE calcularInteresDeCorriente;