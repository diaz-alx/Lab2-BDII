
CREATE OR REPLACE TRIGGER TRIGGER_3
  AFTER INSERT OR UPDATE ON AHORROS
    FOR EACH ROW

DECLARE
-- v_saldoanterior number;
v_monto_deposito number;
v_monto_retiro number;
v_saldo_final number;
v_tipo_operacion CHAR;
v_tipo_transac number;

BEGIN

  --PARA DEPOSITO O RETIRO
IF INSERTING THEN
  v_tipo_transac := 1;
  v_tipo_operacion := 'I';

  INSERT INTO AUDITORIA(
      ID_AUDITORIA,
      ID_CLIENTE,
      id_tipo_ahorro,
      TIPO_OPERACION,
      TIPO_TRANSAC,
      TABLA,
      saldo_anterior,
      monto_deposito,
      SALDO_FINAL,
      USUARIO)
  VALUES(
      nextval.sec_cod_aut,
      :NEW.id_cliente, 
      :NEW.tipo_ahorro, 
      v_tipo_operacion, 
      v_tipo_transac,
      table_name,
      :NEW.SALDO_AHORRO,
      :NEW.SALDO_AHORRO,
      :NEW.SALDO_AHORRO,
      :NEW.USUARIO
      );
END IF;

/*
IF (UPDATING) THEN
v_tipo_operacion := 'U';

    IF :new.saldo_ahorro > :old.saldo_ahorro THEN
        -- SI EL SALDO AUMENTA ES DEPOSITO
        v_tipo_transac := 1;
        v_monto_deposito := :new.saldo_ahorro - :old.saldo_ahorro;
        v_saldo_final := :old.saldo_ahorro + v_monto_deposito;
    ELSE
        -- SI EL SALDO DISMINUYE ES RETIRO v_tipo_transac := 2;
        v_tipo_transac := 2;
        v_monto_retiro :=  :new.saldo_ahorro - :old.saldo_ahorro;
        v_saldo_final := :old.saldo_ahorro - v_monto_retiro; 
    END IF;
 
        INSERT INTO AUDITORIA(
            ID_AUDITORIA,
            ID_CLIENTE,
            id_tipo_ahorro,
            TIPO_OPERACION,
            TIPO_TRANSAC,
            TABLA,
            saldo_anterior,
            monto_deposito,
            SALDO_FINAL,
            USUARIO)
         VALUES (
            nextval.sec_cod_aut,
            :NEW.id_cliente, 
            :NEW.tipo_ahorro, 
            v_tipo_operacion, 
            v_tipo_transac,
            table_name,
            :OLD.SALDO_AHORRO,
            v_monto_retiro,
            v_saldo_final,
            :NEW.USUARIO
            );
END IF;
*/
END TRIGGER_3;
/

DROP TRIGGER TRIGGER_3;

-- Secuencia
CREATE SEQUENCE sec_cod_aut
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;


/*

   id_auditoria NUMBER NOT NULL,
    id_cliente NUMBER NOT NULL,
    id_tipo_ahorro NUMBER NOT NULL,
    tipo_operacion CHAR NOT NULL,
    tipo_transac NUMBER NOT NULL,
    tabla VARCHAR2(25),
    saldo_anterior NUMBER (15, 2),
    monto_deposito NUMBER (15, 2),
    saldo_final NUMBER (15, 2),
    usuario VARCHAR2(42),

*/