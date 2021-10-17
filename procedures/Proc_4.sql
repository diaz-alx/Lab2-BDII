/*
Procedimiento almacenado para la carga o inserción de los pagos recibidos de los 
clientes que se almacena en la tabla transacpagos. Por lo menos uno para cada 
tipo de préstamos.
*/

-- quiza haga falta hacer cambios de fechas con to_date(fecha_transac, 'DD-MON-YY')

CREATE OR REPLACE PROCEDURE insertPagos(
 p_id_transaccion   IN transacpagos.id_transaccion %TYPE,   
    p_id_cliente      IN transacpagos.id_cliente %TYPE,
    p_tipo_prestamo    IN transacpagos.tipo_prestamo %TYPE, 
    p_cod_sucursal     IN transacpagos.cod_sucursal %TYPE, 
    p_fecha_transac    IN transacpagos.fecha_transac %TYPE, 
    p_monto_pago       IN transacpagos.monto_pago %TYPE, 
    p_fecha_inserccion IN transacpagos.fecha_inserccion %TYPE, 
    p_usuario          IN transacpagos.usuario %TYPE  
)
IS
  intSeqVal number(10);
BEGIN
  select sec_id_transac.nextval into intSeqVal from dual;
INSERT INTO transacpagos(
    id_transaccion,     
    id_cliente,      
    tipo_prestamo,    
    cod_sucursal,     
    fecha_transac,    
    monto_pago,       
    fecha_inserccion, 
    usuario         
);
VALUES(
  intSeqVal,
  id_transaccion,     
  id_cliente,      
  tipo_prestamo,    
  cod_sucursal,     
  fecha_transac,    
  monto_pago,       
  fecha_inserccion, 
  usuario);
COMMIT;

EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El cliente ya existe.');
END insertPagos;
/

-- TODO Hace falta colocar los insert para los pagos