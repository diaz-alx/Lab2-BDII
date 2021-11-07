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

CREATE SEQUENCE sec_cod_aut
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

*/

CREATE OR REPLACE TRIGGER AUDITORIA 
-- Inicio de la sección declarativa
AFTER INSERT OF ID_TRANSACCION
  ON TRANSADEPORETI
  FOR EACH ROW

BEGIN
-- Inicio de la sección ejecutable
  id_auditoria 
    id_transaccion 
    id_cliente 
    id_tipo_ahorro 
    tipo_operacion 
    tipo_transac 
    tabla 
    saldo_anterior
    monto_deposito
    saldo_final
    usuario
    UPDATE AUDITORIA
        SET 
        id_transaccion = :NEW.id_transaccion,
        id_cliente = :NEW.id_cliente,
        id_tipo_ahorro = :NEW.id_tipo_ahorro,
        tipo_transac = :NEW.tipo_transac,
        monto_deposito = :NEW.monto
        usuario = :NEW.usuario
        WHERE id_auditoria = :NEW.id_auditoria;
        


    
EXCEPTION
-- Inicio de la sección de excepciones

END AUDITORIA;


/* 
CREATE TABLE transaDepoReti (
    id_transaccion NUMBER NOT NULL,
    no_cuenta NUMBER NOT NULL,
    id_cliente NUMBER NOT NULL,
    tipo_ahorro NUMBER NOT NULL,
    cod_sucursal NUMBER NOT NULL,
    fecha_transac DATE,
    tipo_transac NUMBER,
    monto NUMBER(15, 2) DEFAULT 0,
    fecha_inserccion DATE,
    status CHAR(2) NOT NULL,
    usuario VARCHAR2(45),


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
    CONSTRAINT tipo_operacion_c
    
     */