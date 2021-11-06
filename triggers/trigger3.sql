/*
Triggers. Para inserciones en la tabla de auditoria.
*/

/*
CREATE TABLE AUDITORIA (
    id_auditoria NUMBER NOT NULL,
    id_transaccion NUMBER NOT NULL,
    id_cliente NUMBER NOT NULL,
    id_tipo_ahorro NUMBER NOT NULL,
    tipo_operacion CHAR NOT NULL,
    tipo_transac NUMBER NOT NULL,
    tabla VARCHAR2(25),
    saldo_anterior NUMBER (15, 2),
    monto_deposito NUMBER (15, 2),
    saldo_final NUMBER (15, 2),
    usuario VARCHAR2(42),
    CONSTRAINT tipo_operacion_ck CHECK ( tipo_operacion IN ('I', 'U', 'D')),
    CONSTRAINT auditoria_tipo_transac_ck CHECK ( tipo_transac IN(1, 2)),
    CONSTRAINT auditoria_pk PRIMARY KEY (id_auditoria),
    CONSTRAINT auditoria_transaDepoReti_fk FOREIGN KEY (id_transaccion)
        REFERENCES transaDepoReti (id_transaccion),
    CONSTRAINT auditoria_cliente_fk FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),
    CONSTRAINT auditoria_tipo_ahorro_fk FOREIGN KEY (id_tipo_ahorro)
        REFERENCES tipos_ahorros (id_tipo_ahorro)
);


*/

CREATE OR REPLACE TRIGGER AUDITORIA 
-- Inicio de la sección declarativa
AFTER UPDATE OF saldo_ahorro
  ON AHORROS
  FOR EACH ROW

BEGIN
-- Inicio de la sección ejecutable
  


EXCEPTION
-- Inicio de la sección de excepciones

END AUDITORIA;