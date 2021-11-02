/*
Procedimiento almacenado para la carga o inserción de los pagos recibidos de los 
clientes que se almacena en la tabla transacpagos. Por lo menos uno para cada 
tipo de préstamos.
*/


CREATE OR REPLACE PROCEDURE insertPagos(  
    p_id_cliente      IN transacpagos.id_cliente %TYPE,
    p_tipo_prestamo    IN transacpagos.tipo_prestamo %TYPE, 
    --p_cod_sucursal     IN transacpagos.cod_sucursal %TYPE,
    p_monto_pago       IN transacpagos.monto_pago %TYPE
)
IS
  intSeqVal number(10);
  v_status char(2);
  --v_cod_sucursal number; 
BEGIN 
  select sec_id_transac.nextval into intSeqVal from dual;

IF to_char(CURRENT_DATE, 'dd') = '1' OR to_char(CURRENT_DATE, 'dd') = '30' THEN
v_status := 'P';
ELSE 
v_status := 'NP';
END IF; 
INSERT INTO transacpagos(
    id_transaccion,     
    id_cliente,      
    tipo_prestamo,    
    cod_sucursal,     
    fecha_transac,    
    monto_pago,       
    fecha_inserccion, 
    usuario,
    status         
)
VALUES(
  intSeqVal,    
  p_id_cliente,      
  p_tipo_prestamo, 
  (SELECT cod_sucursal FROM PRESTAMOS
  WHERE 
  id_cliente = p_id_cliente
  AND 
  cod_tipo_prestamo = p_tipo_prestamo),    
  SYSDATE,    
  p_monto_pago,       
  SYSDATE, 
  USER,
  v_status);
COMMIT;

EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El cliente ya existe.');
END insertPagos;
/

-- TODO Hace falta colocar los insert para los pagos