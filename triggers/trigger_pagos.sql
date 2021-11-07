CREATE OR REPLACE TRIGGER acutalizarTransac
  BEFORE INSERT 
  ON TRANSADEPORETI
  FOR EACH ROW

BEGIN
   actualizarAhorros;
END acutalizarTransac;
/
