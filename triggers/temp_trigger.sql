
CREATE OR REPLACE TRIGGER INSERT_AUDITORIA
AFTER INSERT OR UPDATE 
ON AHORROS
FOR EACH ROW
DECLARE
l_tipo_transac NUMBER := CASE 
WHEN :new.saldo_ahorro > :old.saldo_ahorro THEN 1
ELSE 2 END;

BEGIN
IF INSERTING THEN

INSERT INTO AUDITORIA(ID_AUDITORIA,NO_CUENTA,ID_CLIENTE,id_tipo_ahorro,TIPO_OPERACION,TIPO_TRANSAC,TABLA,saldo_anterior,monto_deposito,saldo_final,USUARIO,fecha_transaccion)
VALUES(sec_cod_aut.nextval,:NEW.NO_CUENTA,:NEW.id_cliente,:NEW.tipo_ahorro,'I',1,'AHORROS',:new.saldo_ahorro,:new.saldo_ahorro,:new.saldo_ahorro,USER,SYSDATE);
END IF;

IF UPDATING THEN
IF l_tipo_transac = 1 THEN
INSERT INTO AUDITORIA(ID_AUDITORIA,NO_CUENTA,ID_CLIENTE,id_tipo_ahorro,TIPO_OPERACION,TIPO_TRANSAC,TABLA,saldo_anterior,monto_deposito,saldo_final,USUARIO,fecha_transaccion)
VALUES(sec_cod_aut.nextval,:NEW.NO_CUENTA,:NEW.id_cliente,:NEW.tipo_ahorro,'U',l_tipo_transac,'AHORROS',:old.saldo_ahorro,:new.saldo_ahorro + :old.saldo_ahorro,:new.saldo_ahorro,USER,SYSDATE);
ELSE
INSERT INTO AUDITORIA(ID_AUDITORIA,NO_CUENTA,ID_CLIENTE,id_tipo_ahorro,TIPO_OPERACION,TIPO_TRANSAC,TABLA,saldo_anterior,monto_deposito,SALDO_FINAL,USUARIO,fecha_transaccion)
VALUES (sec_cod_aut.nextval,:NEW.NO_CUENTA,:NEW.id_cliente,:NEW.tipo_ahorro,'U',l_tipo_transac,'AHORROS',:OLD.SALDO_AHORRO,:new.saldo_ahorro - :old.saldo_ahorro,:new.saldo_ahorro ,USER,SYSDATE);
END IF;
END IF;

END INSERT_AUDITORIA;
/


drop trigger INSERT_AUDITORIA;
