/*
Triggers. Para las actualizaciones en la tabla de sucursales los montos de los 
ahorros.
*/


CREATE OR REPLACE TRIGGER CARGATIPOAHORROSUC 
-- Inicio de la sección declarativa
  AFTER INSERT OR DELETE
  ON TIPOS_AHORROS
  FOR EACH ROW

BEGIN
  IF INSERTING THEN 
    INSERT INTO TIPO_AH_SUC(
      cod_sucursal,
      id_tipo_ahorro)
      SELECT :new.cod_sucursal , :new.id_tipo_ahorro
      FROM dual
      WHERE NOT EXISTS(
        SELECT * FROM SUCURSALES
        WHERE (COD_SUCURSAL = :new.COD_SUCURSAL) 
      );
    
  END IF;
EXCEPTION WHEN dup_val_on_index THEN
  null;

END CARGATIPOAHORROSUC;
/

