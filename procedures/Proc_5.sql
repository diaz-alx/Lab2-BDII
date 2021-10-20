/*

Procedimiento almacenado que actualice el pago recibo a los préstamos 
correspondientes. Deberá implementar un cursor que busque los pagos insertados 
uno a uno y los vaya actualizando en la tabla de préstamos y en la tabla sucursales.

-- Hecho
1. Para aplicar el pago este debe rebajarlo del saldo prestamos ( 1000-
20)=980.00. Pero debe tomar en cuenta lo siguiente el préstamo paga 
interés y este se calcula sobre el saldo del préstamo (saldo del préstamo * 
tasa de interés%) el pago interés es mensual (1000 * 1%) = 50.00

2. El cálculo del interés lo realiza una Función que es invocada desde
un procedimiento.

3. El interés se cobra primero y de quedar alguna porción del monto pagado
por el cliente se aplica al saldo del préstamo.

4. La tabla de sucursales solo almacena los montos prestados por la empresa 
financiera en función de esto, aplicar las actualizaciones.

*/


-- Función de calcular interés
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



--CREATE OR REPLACE PROCEDURE actualizarPagos(p_acutalizar CHAR(2)) 
--IS
DECLARE
    v_id_cliente NUMBER;
    v_tipo_prestamo NUMBER; 
    v_cod_sucursal NUMBER :=1;
    v_monto_pago NUMBER(15, 2) DEFAULT 0;
    v_status char(2) := 'P';

CURSOR c_transacpagos IS
    SELECT 
    id_cliente, 
    tipo_prestamo,
    monto_pago
    FROM TRANSACPAGOS
    WHERE
    status = v_status;
BEGIN

OPEN c_transacpagos;
    LOOP
    FETCH c_transacpagos INTO
       v_id_cliente,
       v_tipo_prestamo,
       v_monto_pago;
    EXIT
    WHEN c_transacpagos%NOTFOUND;
    
    UPDATE PRESTAMOS
    SET 
    saldo_actual = calcularInteres(v_tipo_prestamo,saldo_actual) - v_monto_pago,
    importe_pago = importe_pago + v_monto_pago,
    interes_pagado = interes_pagado + (calcularInteres(v_tipo_prestamo,saldo_actual) - SALDO_ACTUAL)
    WHERE
    id_cliente = v_id_cliente
    AND
    cod_tipo_prestamo = v_tipo_prestamo;

    UPDATE TIPOS_PRE_SUCURSAL
    SET MONTO_PRESTA = MONTO_PRESTA - v_monto_pago
    WHERE
    cod_sucursal = v_cod_sucursal
    AND
    cod_t_prestam = v_tipo_prestamo;

    UPDATE SUCURSALES
    SET MONTO_PRESTAMO = MONTO_PRESTAMO - v_monto_pago               
    WHERE
    cod_sucursal = v_cod_sucursal;                                   
    END LOOP;
CLOSE c_transacpagos;

END;
/


/*
-- Función de disminuir préstamo
CREATE OR REPLACE FUNCTION disminuirPrestamo(
-- TODO Falta colocar de donde saca eso, p_mont_mensual p_monto_interes y p_monto_a_pagar
    p_monto_mensual IN PRESTAMOS.monto_aprobado%TYPE,
    p_monto_interes IN PRESTAMOS.interes_pagado%TYPE,
    p_monto_a_pagar IN PRESTAMOS.importe_pago%TYPE,
)
RETURN NUMBER IS
   V_monto_actual NUMBER;
   v_monto_mensual NUMBER := p_monto_mensual;
   v_monto_a_pagar NUMBER := p_monto_a_pagar;
   v_monto_interes NUMBER := p_monto_interes;
;
   BEGIN

   -- Interes calculado mediante el préstamo e interes
   IF v_monto_a_pagar - v_monto_interes  >= 0
   V_monto_actual = v_monto_a_pagar - (v_monto_interes + v_monto_mensual)   
   ELSE
    V_monto_actual = v_monto_a_pagar - v_monto_interes

    RETURN V_monto_actual
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El monto insertado no ha sido calculado.');


   END disminuirPrestamo;
/
*/
