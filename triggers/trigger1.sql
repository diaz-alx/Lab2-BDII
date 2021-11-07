/*
Triggers. Para las actualizaciones en la tabla de sucursales los montos de los 
ahorros.
*/



DROP trigger CARGATIPOAHORROSUC;


--Este sirve para cuando se hace un depósito en corriente cuando es día de pago
UPDATE AHORROS
  SET saldo_interes = 0
  WHERE tipo_ahorro = 2;

CREATE OR REPLACE TRIGGER CARGATIPOAHORROSUC 

-- Inicio de la sección declarativa
AFTER UPDATE OF saldo_ahorro
  ON AHORROS
  FOR EACH ROW

BEGIN
-- Inicio de la sección ejecutable
    IF to_char(CURRENT_DATE, 'dd') = '06' AND :NEW.tipo_ahorro = 2 
      THEN
      IF :NEW.saldo_interes > 0 THEN
       UPDATE SUCURSALES
        SET monto_ahorros = monto_ahorros + :NEW.saldo_interes
      WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
      ELSE
       UPDATE SUCURSALES
        SET monto_ahorros = monto_ahorros + :NEW.saldo_ahorro
      WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
      END IF;
    ELSE
      UPDATE SUCURSALES
        SET monto_ahorros = monto_ahorros + :NEW.saldo_ahorro
      WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
    END IF;

EXCEPTION WHEN dup_val_on_index THEN
  null;

END CARGATIPOAHORROSUC;
/

/*
CREATE OR REPLACE TRIGGER CARGATIPOAHORROSUC 
-- Inicio de la sección declarativa
  AFTER UPDATE OF saldo_ahorro
  ON AHORROS
  FOR EACH ROW

BEGIN
      IF to_char(CURRENT_DATE, 'dd') = '06' AND :NEW.tipo_ahorro = 2 
      THEN
        IF :NEW.saldo_interes > 0 
        THEN            
            UPDATE SUCURSALES
              SET monto_ahorros = monto_ahorros + :NEW.saldo_interes
            WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
          ELSE
           UPDATE SUCURSALES
              SET 
                monto_ahorros = monto_ahorros + :NEW.saldo_ahorro,
            WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
        END IF;
      ELSE
        UPDATE SUCURSALES
          SET monto_ahorros = monto_ahorros + :NEW.saldo_ahorro
        WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL;
      END IF;
          
EXCEPTION WHEN dup_val_on_index THEN
  null;

END CARGATIPOAHORROSUC;
/
*/

drop trigger CARGATIPOAHORROSUC;