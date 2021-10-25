/*

Procedimiento almacenado para la carga o inserción de los préstamos aprobados 
con toda la información correspondiente e igualmente este proceso deberá 
actualizar la información de préstamo en la tabla de sucursales.

*/

-- No se si hace falta convertir algunos campos a fech

CREATE OR REPLACE PROCEDURE insertPrestamo(
    p_id_cliente            IN prestamos.id_cliente%TYPE,
    p_cod_tipo_prestamo     IN prestamos.cod_tipo_prestamo%TYPE,
    p_monto_aprobado        IN prestamos.monto_aprobado%TYPE,
    p_fecha_pago            IN prestamos.fecha_pago%TYPE,
    p_no_sucursal IN prestamos.cod_sucursal%TYPE
)
IS
  v_cod_prestamo NUMBER := p_cod_tipo_prestamo;
  intSeqVal number(10);
  v_fecha date := SYSDATE;
  v_saldo number := p_monto_aprobado;
  v_monto_prestamo number := p_monto_aprobado;
  v_interes NUMBER;
  v_importe number := 0;
  v_interes_pagado number := 0;
  v_fecha_pago number := p_fecha_pago;
  v_letra_mensual number := 0;
BEGIN

--1
  select sec_no_prestamo.nextval into intSeqVal from dual;
  SELECT tasa_interes INTO v_interes FROM TIPOS_PRESTAMOS WHERE cod_prestamo = v_cod_prestamo;

--2  

INSERT INTO PRESTAMOS(
  no_prestamo,    
  id_cliente,
  cod_tipo_prestamo,    
  fecha_aprobado, 
  monto_aprobado,    
  letra_mensual,      
  importe_pago, 
  fecha_pago,
  tasa_interes, 
  saldo_actual, 
  interes_pagado,
  fecha_mod,
  cod_sucursal,
  usuario)
VALUES (intSeqVal,
    p_id_cliente,
    p_cod_tipo_prestamo,
    to_date(v_fecha,'DD-MM-YYY HH24:MI:SS'),
    p_monto_aprobado,
    v_letra_mensual, 
    v_importe, 
    v_fecha_pago, 
    v_interes,
    v_saldo, 
    v_interes_pagado,
    to_date(v_fecha,'DD-MM-YYY HH24:MI:SS'),
    p_no_sucursal,
    user
    );

--Actualizacion de la tabla relacion muchos a muchos de TIPO PRESTAMO Y SUCURSAL
 
UPDATE TIPOS_PRE_SUCURSAL SET MONTO_PRESTA = MONTO_PRESTA + v_monto_prestamo
    WHERE cod_sucursal = p_no_sucursal and cod_t_prestam = p_cod_tipo_prestamo; 

UPDATE SUCURSALES SET MONTO_PRESTAMO = MONTO_PRESTAMO + v_monto_prestamo
    WHERE cod_sucursal = p_no_sucursal; 



COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El cliente ya existe.');
END insertPrestamo;
/


