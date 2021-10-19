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


/*
-- Implementación del cursor

CURSOR Pagos IS
    SELECT  %

    FROM PRESTAMOS
*/

-- Función de calcular interés
CREATE OR REPLACE FUNCTION calcularInteres(
    p_prestamo PRESTAMOS.monto_aprobado%TYPE,
    p_interes PRESTAMOS.tasa_interes%TYPE,
)
RETURN NUMBER IS
   V_interes_calculado NUMBER;
   v_prestamo NUMBER := p_prestamo;
   v_interes NUMBER := p_interes;
   BEGIN

   -- Interes calculado mediante el préstamo e interes
   V_interes_calculado := (v_prestamo * v_interes) ;
 
   RETURN V_interes_calculado;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El préstamo no ha sido encontrado.');

   END calcularInteres;
/

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
   IF v_monto_a_pagar - (v_monto_interes + v_monto_mensual) >= 0
   V_monto_actual = v_monto_a_pagar - (v_monto_interes + v_monto_mensual)   
   ELSE
    V_monto_actual = v_monto_a_pagar - v_monto_interes

    RETURN V_monto_actual
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El monto insertado no ha sido calculado.');


   END disminuirPrestamo;
/



CREATE OR REPLACE PROCEDURE insertUpdate(
    p_monto_prestamo IN SUCURSALES.monto_prestamo%TYPE;
    p_saldo_actual IN PRESTAMOS.saldo_actual&TYPE;
)
BEGIN

    -- Aqui se implementaría el cursor
    CURSOR Pagos IS
    SELECT saldo_actual, monto_prestamo
    UPDATE

    FROM p PRESTAMOS, s SUCURSALES

    -- Aqui iria la logica del update

    

END;
/

--1

--2

--1

--1

--1


--1

/*

-- BLOQUE ANÓNIMO: CALCULO DE NOMINA --
DECLARE
   -- Se declaran las variables de los colaboradores
   v_Id_Colab                      colaboradores.id_codcolaborador%TYPE;
   v_SalarioM_Colab                colaboradores.salario_mensual%TYPE;
   v_Status_colab                  colaboradores.status%TYPE := 'A';
   v_intSeqVal NUMBER;
   
   CURSOR c_Salarios IS
   SELECT id_codcolaborador,
   salario_mensual
   FROM COLABORADORES
   WHERE status = v_Status_colab;
 
BEGIN
   -- Este código se emplea los días quince y treinta de cada mes.
   -- Si se quiere probar el código, cambiar los valores a el día en la que usted se encuentra
   -- Por ejemplo: Si usted lo prueba el 6 de octubre, colocar 06 en el date
   -- Ejem: IF to_char(CURRENT_DATE, 'dd') = '06' OR to_char(CURRENT_DATE, 'dd') = '30' THEN
   IF to_char(CURRENT_DATE, 'dd') = '10' OR to_char(CURRENT_DATE, 'dd') = '30' THEN
       OPEN c_Salarios;
       LOOP
       FETCH c_Salarios INTO
       v_Id_Colab,
       v_SalarioM_Colab;
       EXIT
       WHEN c_salarios%NOTFOUND;
       select SEC_ID_SALARIO.nextval into v_intSeqVal from dual;
       INSERT INTO salario_quincenal (
           id_salario,id_codcolaborador, fecha_pago, salario_quincenal,
           seguro_social, seguro_educativo, salario_neto)
       VALUES (
           v_intSeqVal,
           v_Id_Colab,
           SYSDATE(),
           Cal_salarioQuincenal(v_SalarioM_Colab),
           Cal_seguroEducativo(v_SalarioM_Colab),
           Cal_seguroSocial(v_SalarioM_Colab),
           Cal_salarioNeto(v_SalarioM_Colab)
       );
       
       END LOOP;
       CLOSE c_Salarios;
   ELSE
       DBMS_OUTPUT.PUT_LINE('💣 Error: Hoy no es día de pago.');
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: Este ID no existe.');
END;
/

*/