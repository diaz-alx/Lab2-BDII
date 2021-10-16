/*
Procedimiento almacenado para la carga o inserción de los clientes con toda la 
información correspondiente. Este procedimiento debe invocar una Función que 
calcule la edad de los clientes.
*/

CREATE OR REPLACE FUNCTION calcularEdadCliente( P_fecha date)
RETURN NUMBER IS 
clienteEdad number(3)
BEGIN
  -- Necesitamos eso en años
  clienteEdad = (SYSDATE - p_fecha) / 365;

  RETURN clienteEdad;
  
  EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de correo ya existe.');
END;
/


CREATE OR REPLACE PROCEDURE insertCliente(
    p_Nombre    IN clientes.nombre1%TYPE,
    p_Apellido  IN clientes.apellido1%TYPE,
    p_cedula    IN clientes.cedula%TYPE,
    p_sexo      IN Clientes.SEXO%TYPE,
    p_fecha     IN clientes.fecha_nac%TYPE,
    p_Sexo      IN clientes.sexo%TYPE,
    p_calle     IN clientes.calle%TYPE,
    p_profesion IN clientes.cod_profesion%TYPE,
    p_provincia IN clientes.cod_provincia%TYPE,
    p_sucursal  IN clientes.cod_sucursal%TYPE,
) IS 
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
    cod_provincia,
    calle,
    cod_sucursal)
VALUES (intSeqVal,
    p_cedula,
    p_nombre,
    p_apellido,
    to_date(p_fecha,'DD-MON-YY'),
    v_edad,
    p_sexo,
    p_profesion,
    p_provincia,
    p_calle,
    p_sucursal);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de correo ya existe.');
END;

/

--PARAMETROS: 'lacedula','nombre','apellido','fecha','sexo(M,F)',profesion,provincia,'calle',sucursal
-- Execute insertCliente('lacedula','nombre','apellido','fecha','sexo(M,F)',profesion,provincia,'calle',sucursal);

Execute insertCliente(8977, '800-99-123','JUAN','ZELAYA', TO_DATE('16-01-1995','DD-MM-YYYY'),'M',10,8,'La Locería calle 5 ');
Execute insertCliente(9010, '800-99-124','KREVITH','SHAW', TO_DATE('20-08-1981','DD-MM-YYYY'),'M',20,8,'La Gloria, Bethania, cl 19cN, ca 37');
Execute insertCliente(9067, '800-99-125','BORIS','FLORES', TO_DATE('15-09-1992','DD-MM-YYYY'),'M',30,8,'Plaza Camino de Cruces El Dorado');
Execute insertCliente(9173, '800-99-126','SERGIO','ROJAS', TO_DATE('25-05-1993','DD-MM-YYYY'),'M',40,8,'San francisco calle 70');
Execute insertCliente(9208, '800-99-127','RANDALL','WAYNE', TO_DATE('13-04-1998','DD-MM-YYYY'),'M',50,8,'Obarrio, Calle 56 Este, Edificio Enid,');
Execute insertCliente(9235, '800-99-128','JORGE','MOLINA', TO_DATE('17-07-1987','DD-MM-YYYY'),'M',60,8,'PH Edison Corporate Center Piso 8.');
Execute insertCliente(9248, '800-99-129','SEBASTIAN','GONZALEZ', TO_DATE('27-12-1991','DD-MM-YYYY'),'M',70,8,'Calle 109 Este, entrada de Chanis');
Execute insertCliente(9251, '800-99-130','ANTONIO','FALLAS', TO_DATE('12-06-1957','DD-MM-YYYY'),'M',80,8,'Calle D El Cangrejo y Eusebio A Morales.');
Execute insertCliente(9274, '800-99-131','JOSE','FALLAS', TO_DATE('09-02-2000','DD-MM-YYYY'),'M',90,8,'Calle Williamson Place, La Boca, Ancón');
Execute insertCliente(9333, '800-99-132','PATRICIA','CENTENO', TO_DATE('16-01-1995','DD-MM-YYYY'),'F',100,8,'Calle 53 El Cangrejo');


