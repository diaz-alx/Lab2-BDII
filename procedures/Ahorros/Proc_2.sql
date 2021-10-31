/*
Procedimiento almacenado para la carga o inserción de los clientes con toda la 
información correspondiente. Este procedimiento debe invocar una Función que 
calcule la edad de los clientes.
*/

CREATE OR REPLACE FUNCTION calcularEdadCliente(p_fecha date)
RETURN NUMBER IS 
v_clienteEdad number(3);
v_fecha date := p_fecha;
BEGIN
  -- Necesitamos eso en años
  v_clienteEdad := (SYSDATE - v_fecha) / 365;

  RETURN v_clienteEdad;
  
  EXCEPTION
   WHEN ZERO_DIVIDE THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de correo ya existe.');
END calcularEdadCliente;
/


CREATE OR REPLACE PROCEDURE insertCliente(
    p_cedula    IN clientes.cedula%TYPE,
    p_Nombre    IN clientes.nombre1%TYPE,
    p_Apellido  IN clientes.apellido1%TYPE,
    p_fecha     IN clientes.fecha_nac%TYPE,
    p_sexo      IN clientes.SEXO%TYPE,
    p_profesion IN clientes.cod_profesion%TYPE,
    p_direccion IN clientes.direccion%TYPE,
    p_sucursal  IN clientes.cod_sucursal%TYPE) 

IS 
    intSeqVal number(10);
    v_edad number(3) := calcularEdadCliente(p_fecha);
BEGIN
    select SEC_ID_cliente.nextval into intSeqVal from dual;
INSERT into CLIENTES (id_cliente,
    cedula,
    nombre1,
    apellido1,
    fecha_nac,
    edad,
    sexo,
    cod_profesion,
    direccion,
    cod_sucursal)
VALUES (intSeqVal,
    p_cedula,
    p_nombre,
    p_apellido,
    to_date(p_fecha,'DD-MM-YYYY'),
    v_edad,
    p_sexo,
    p_profesion,
    p_direccion,
    p_sucursal);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El cliente ya existe.');
END insertCliente;
/
