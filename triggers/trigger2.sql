/*
Triggers Para las actualizaciones en la tabla de sucursales tipo de ahorros, los 
montos de los ahorros correspondientes.

*/


CREATE OR REPLACE TRIGGER AHORROS_CORRESPONDIENTES 

-- Inicio de la sección declarativa
AFTER UPDATE OF saldo_ahorro
  ON AHORROS
  FOR EACH ROW

BEGIN
-- Inicio de la sección ejecutable
    IF to_char(CURRENT_DATE, 'dd') = '06' AND :NEW.tipo_ahorro = 2 
      THEN
       UPDATE TIPO_AH_SUC
        SET monto_ahorros = monto_ahorros + :NEW.saldo_interes
      WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
      ELSE
       UPDATE SUCURSALES
        SET monto_ahorros = monto_ahorros + :NEW.saldo_ahorro
      WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
    END IF;

EXCEPTION WHEN dup_val_on_index THEN
  null;
-- Inicio de la sección de excepciones


END AHORROS_CORRESPONDIENTES;