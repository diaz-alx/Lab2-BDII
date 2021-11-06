/*
Triggers. Para las actualizaciones en la tabla de sucursales los montos de los 
ahorros.
*/


CREATE OR REPLACE TRIGGER CARGATIPOAHORROSUC 
-- Inicio de la sección declarativa
  AFTER UPDATE OF saldo_ahorro
  ON AHORROS
  FOR EACH ROW

BEGIN
      IF to_char(CURRENT_DATE, 'dd') = '06' AND :NEW.tipo_ahorro = 2 
      THEN
       UPDATE SUCURSALES
        SET monto_ahorros = monto_ahorros + :NEW.saldo_interes
        WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
      ELSE
       UPDATE SUCURSALES
        SET monto_ahorros = monto_ahorros + :NEW.saldo_ahorro
      WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
      END IF;
 
EXCEPTION WHEN dup_val_on_index THEN
  null;

END CARGATIPOAHORROSUC;
/

drop trigger CARGATIPOAHORROSUC;



UPDATE TIPOS_PRE_SUCURSAL SET MONTO_PRESTA = MONTO_PRESTA + v_monto_prestamo
    WHERE cod_sucursal = p_no_sucursal and cod_t_prestam = p_cod_tipo_prestamo; 

UPDATE SUCURSALES SET MONTO_PRESTAMO = MONTO_PRESTAMO + v_monto_prestamo
    WHERE cod_sucursal = p_no_sucursal; 