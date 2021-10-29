--INTERES
CREATE OR REPLACE FUNCTION calcularInteres(
    p_tipoInteres number,
    p_saldoActual number
)
RETURN NUMBER IS
   V_interes_calculado NUMBER;
   v_saldo NUMBER := p_saldoActual;
   v_interes NUMBER;
   --v_exeption EXCEPTION;
BEGIN
    -- ASIGNA EL VALOR DEL INTERES EN BASE AL TIPO DE PRESTAMO
    IF p_tipoInteres = 1 THEN
    v_interes := 0.05;
    ELSIF p_tipoInteres = 2 THEN
    v_interes := 0.06;
    ELSIF p_tipoInteres = 3 THEN
    v_interes := 0.02;
    ELSIF p_tipoInteres = 4 THEN
    v_interes := 0.03;
    ELSIF p_tipoInteres = 5 THEN
    v_interes := 0.04;
    END IF;
   -- Interes calculado mediante el préstamo e interes
    v_interes_calculado := (v_saldo * v_interes) + v_saldo;
 
   RETURN v_interes_calculado;
    EXCEPTION
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El préstamo no ha sido encontrado.');

END calcularInteres;
/