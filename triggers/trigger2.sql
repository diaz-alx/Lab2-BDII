/*
Triggers Para las actualizaciones en la tabla de sucursales tipo de ahorros, los 
montos de los ahorros correspondientes.

*/


CREATE OR REPLACE TRIGGER TRIGGER_2 

-- Inicio de la sección declarativa
AFTER UPDATE OF saldo_ahorro
  ON AHORROS
  FOR EACH ROW

BEGIN
-- Inicio de la sección ejecutable
    IF to_char(CURRENT_DATE, 'dd') = '06' AND :NEW.tipo_ahorro = 2 
      THEN
      IF :NEW.saldo_interes > 0 THEN
       UPDATE TIPO_AH_SUC
        SET monto_ahorros = monto_ahorros + :NEW.saldo_interes
      WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL
      AND id_tipo_ahorro = :NEW.tipo_ahorro;
      ELSE
       UPDATE TIPO_AH_SUC
        SET monto_ahorros = monto_ahorros + :NEW.saldo_ahorro
      WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL
      AND id_tipo_ahorro = :NEW.tipo_ahorro;
      END IF;
    ELSE
      UPDATE TIPO_AH_SUC
        SET monto_ahorros = monto_ahorros + :NEW.saldo_ahorro
      WHERE COD_SUCURSAL = :NEW.COD_SUCURSAL
      AND id_tipo_ahorro = :NEW.tipo_ahorro;
    END IF;

EXCEPTION WHEN dup_val_on_index THEN
  null;

END TRIGGER_2;
/

drop trigger CARGATIPOAHORROSUC;
BEGIN
INSERT INTO TIPO_AH_SUC VALUES(1,1,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(1,2,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(1,3,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(2,1,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(2,2,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(2,3,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(3,1,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(3,2,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(3,3,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(4,1,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(4,2,0,SYSDATE);
INSERT INTO TIPO_AH_SUC VALUES(4,3,0,SYSDATE);
END;
/