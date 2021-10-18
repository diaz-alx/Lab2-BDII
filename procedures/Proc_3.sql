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
    p_cuotas NUMBER;
    p_no_sucursal number;
)
IS
  v_cod_prestamo NUMBER := p_cod_tipo_prestamo;
  intSeqVal number(10);
  v_fecha date := SYSDATE;
  v_saldo := p_monto_aprobado;
  v_interes NUMBER;
  v_importe number := 0;
BEGIN
  select sec_no_prestamo.nextval into intSeqVal from dual;
  SELECT tasa_interes INTO v_interes FROM TIPOS_PRESTAMOS WHERE cod_prestamo = v_cod_prestamo;
UPDATE TIPO
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
  saldo_acual, 
  interes_pagado);
VALUES (intSeqVal,
    p_no_prestamo,
    p_id_cliente,
    p_cod_tipo_prestamo,
    v_fecha,
    p_monto_aprobado,
    p_letra_mensual, 
    v_importe, 
    p_fecha_pago, 
    v_interes,
    saldo, 
    p_interes_pagado);

UPDATE 
COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El cliente ya existe.');
END insertPrestamo;
/


EXECUTE insertPrestamo(4,4421, TO_DATE('04-05-2021','DD-MM-YYYY'), 60000, 740, 180,TO_DATE('04-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(2,3653, TO_DATE('05-05-2021','DD-MM-YYYY'), 1500, 100, 15,TO_DATE('05-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(3,1604, TO_DATE('06-05-2021','DD-MM-YYYY'), 12000, 1333, 9,TO_DATE('06-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(2,2400, TO_DATE('07-05-2021','DD-MM-YYYY'), 6000, 500, 12,TO_DATE('07-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(5,1557, TO_DATE('08-05-2021','DD-MM-YYYY'), 2000, 200, 10,TO_DATE('08-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(3,1801, TO_DATE('09-05-2021','DD-MM-YYYY'), 120000, 625, 192,TO_DATE('09-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(4,2987, TO_DATE('10-05-2021','DD-MM-YYYY'), 5000, 1000, 5,TO_DATE('10-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(4,2350, TO_DATE('11-05-2021','DD-MM-YYYY'), 3000, 272, 11,TO_DATE('11-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(4,1522, TO_DATE('12-05-2021','DD-MM-YYYY'), 3500, 437.5, 8,TO_DATE('12-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(4,3756, TO_DATE('13-05-2021','DD-MM-YYYY'), 8000, 400, 20,TO_DATE('13-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(4,3849, TO_DATE('14-05-2021','DD-MM-YYYY'), 2500, 416, 6,TO_DATE('14-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(2,4071, TO_DATE('15-05-2021','DD-MM-YYYY'), 1000, 166, 6,TO_DATE('15-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(1,1187, TO_DATE('16-05-2021','DD-MM-YYYY'), 9000, 1125, 8,TO_DATE('16-06-2021','DD-MM-YYYY'), 0.25  );
EXECUTE insertPrestamo(2,2789, TO_DATE('17-05-2021','DD-MM-YYYY'), 80000, 444, 180,TO_DATE('17-06-2021','DD-MM-YYYY'), 0.25  );

