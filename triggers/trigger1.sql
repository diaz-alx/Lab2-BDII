/*
Triggers. Para las actualizaciones en la tabla de sucursales los montos de los 
ahorros.
*/


CREATE OR REPLACE TRIGGER AHORROS 
-- Inicio de la sección declarativa
  BEFORE INSERT OR UPDATE OF monto_ahorros
  ON AHORROS
  FOR EACH ROW


BEGIN
-- Inicio de la sección ejecutable
  UPDATE monto_ahorros 
    SET monto_ahorros = new_monto_ahorros

EXCEPTION
-- Inicio de la sección de excepciones

END AHORROS;