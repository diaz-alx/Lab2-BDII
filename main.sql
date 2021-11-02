set serveroutput on;

------------ 1- TABLAS PRINCIPALES----------------------

CREATE TABLE tipos_correos (
    cod_correo  NUMBER NOT NULL,
    descripcion VARCHAR2(100),
    CONSTRAINT correo_u UNIQUE ( descripcion ),
    CONSTRAINT tipos_correos_pk PRIMARY KEY ( cod_correo )
);

CREATE TABLE tipos_prestamos (
    cod_prestamo    NUMBER NOT NULL,
    nombre_prestamo VARCHAR2(100) NOT NULL,
    tasa_interes    NUMBER(2, 2) DEFAULT 0,
    CONSTRAINT t_prestam_u UNIQUE ( nombre_prestamo ),
    CONSTRAINT tipos_prestamos_pk PRIMARY KEY ( cod_prestamo )
);

CREATE TABLE tipos_telefonos (
    cod_telefono NUMBER NOT NULL,
    descripcion  VARCHAR2(100),
    CONSTRAINT telefonos_u UNIQUE ( descripcion ),
    CONSTRAINT tipos_telefonos_pk PRIMARY KEY ( cod_telefono )
);

CREATE TABLE profesiones (
    id_profesion NUMBER NOT NULL,
    descripcion  VARCHAR2(100),
    CONSTRAINT profesion_u UNIQUE ( descripcion ),
    CONSTRAINT profesion_pk PRIMARY KEY ( id_profesion )
);

CREATE TABLE distritos (
    cod_distrito NUMBER NOT NULL,
    nombre       VARCHAR2(100),
    CONSTRAINT distrito_u UNIQUE ( NOMBRE ),
    CONSTRAINT distritos_pk PRIMARY KEY ( cod_distrito )
);


CREATE TABLE provincias (
    cod_provincia NUMBER NOT NULL,
    nombre        VARCHAR2(100),
    CONSTRAINT provincia_u UNIQUE ( nombre ),
    CONSTRAINT provincias_pk PRIMARY KEY ( cod_provincia )
);

CREATE TABLE provincias_distritos (
    cod_provincia NUMBER NOT NULL,
    cod_distrito  NUMBER NOT NULL,
    CONSTRAINT provincias_distritos_pk PRIMARY KEY ( cod_provincia,cod_distrito ),
    CONSTRAINT distritos_fk FOREIGN KEY ( cod_distrito )
        REFERENCES distritos ( cod_distrito ),
    CONSTRAINT provincias_fk FOREIGN KEY ( cod_provincia )
        REFERENCES provincias ( cod_provincia )
);

CREATE TABLE sucursales (
    cod_sucursal   NUMBER NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    monto_prestamo NUMBER(15, 2) DEFAULT 0,
    CONSTRAINT sucursales_pk PRIMARY KEY ( cod_sucursal ),
    CONSTRAINT sucursales_un UNIQUE ( nombre )
);

CREATE TABLE clientes (
    id_cliente    NUMBER NOT NULL,
    cedula        VARCHAR2(10) NOT NULL,
    nombre1       VARCHAR2(100) not NULL,
    apellido1     VARCHAR2(100) not NULL,
    fecha_nac     DATE not NULL,
    edad          NUMBER(3),
    sexo          CHAR NOT NULL,
    cod_profesion NUMBER NOT NULL,
    direccion     VARCHAR2(250) not NULL,
    cod_sucursal  NUMBER NOT NULL,
    constraint c_sexo CHECK (sexo in ('F','M')),
    CONSTRAINT clientes_un UNIQUE ( cedula ),
    CONSTRAINT clientes_pk PRIMARY KEY ( id_cliente ),
    CONSTRAINT clientes_profesion_fk FOREIGN KEY ( cod_profesion )
        REFERENCES profesiones ( id_profesion ),
    CONSTRAINT clientes_sucursales_fk FOREIGN KEY ( cod_sucursal )
        REFERENCES sucursales ( cod_sucursal )
);


CREATE TABLE clientes_correos (
    id_cliente NUMBER NOT NULL,
    id_correo  NUMBER NOT NULL,
    correo     VARCHAR2(100),
    CONSTRAINT clientes_correos_pk PRIMARY KEY ( id_cliente,id_correo ),
    CONSTRAINT clientes_fk FOREIGN KEY ( id_cliente )
        REFERENCES clientes ( id_cliente ),
    CONSTRAINT tipos_correos_fk FOREIGN KEY ( id_correo )
        REFERENCES tipos_correos ( cod_correo )
);



CREATE TABLE clientes_telefonos (
    id_cliente  NUMBER NOT NULL,
    id_telefono NUMBER NOT NULL,
    telefono    VARCHAR2(10),
    CONSTRAINT clientes_telefonos_pk PRIMARY KEY ( id_cliente,id_telefono ),
    CONSTRAINT clientes_telefonos_fk FOREIGN KEY ( id_cliente )
        REFERENCES clientes ( id_cliente ),
    CONSTRAINT clientes_tipos_telefonos_fk FOREIGN KEY ( id_telefono )
        REFERENCES tipos_telefonos ( cod_telefono )
);

CREATE TABLE tipos_pre_sucursal (
    cod_sucursal  NUMBER NOT NULL,
    cod_t_prestam NUMBER NOT NULL,
    monto_presta NUMBER NOT NULL,
    fecha_mod      DATE,
    CONSTRAINT tipos_pre_sucursal_pk PRIMARY KEY ( cod_sucursal,cod_t_prestam ),
    CONSTRAINT tipos_prestamos_fk FOREIGN KEY ( cod_t_prestam )
        REFERENCES tipos_prestamos ( cod_prestamo ),
CONSTRAINT tipos_sucursales_fk FOREIGN KEY ( cod_sucursal )
        REFERENCES sucursales ( cod_sucursal )
);


CREATE TABLE prestamos (
    no_prestamo       NUMBER NOT NULL,
    id_cliente        NUMBER NOT NULL,
    cod_tipo_prestamo NUMBER NOT NULL,
    fecha_aprobado    DATE,
    monto_aprobado    NUMBER(15,2) DEFAULT 0,
    letra_mensual      NUMBER(15,2) DEFAULT 0,
    importe_pago      NUMBER(15,2) DEFAULT 0,
    fecha_pago        number(2),
    tasa_interes      NUMBER(2, 2) DEFAULT 0,
    saldo_actual       NUMBER(15, 2) DEFAULT 0,
    interes_pagado    NUMBER(15, 2) DEFAULT 0,
    fecha_mod         date,
    cod_sucursal      number,
    usuario           varchar2(50),
    CONSTRAINT prestamos_pk PRIMARY KEY ( id_cliente,cod_tipo_prestamo ),
    CONSTRAINT prestamos_clientes_fk FOREIGN KEY ( id_cliente )
        REFERENCES clientes ( id_cliente ),
    CONSTRAINT tipos_presta_fk FOREIGN KEY ( cod_tipo_prestamo )
        REFERENCES tipos_prestamos ( cod_prestamo )
);


CREATE TABLE transacpagos (
    id_transaccion   NUMBER NOT NULL,
    id_cliente     NUMBER NOT NULL,
    tipo_prestamo    NUMBER NOT NULL,
    cod_sucursal       NUMBER NOT NULL,
    fecha_transac    DATE,
    monto_pago       NUMBER(15, 2) DEFAULT 0,
    fecha_inserccion DATE,
    usuario          VARCHAR2(45),
    status             char(2),
    -- PENDIENTE, PROCESADO, NO PAGADO -- VERIFICAR MAS ESTADO
    CONSTRAINT status_check CHECK(status in ('PE','PR', 'NP')),
    CONSTRAINT transacpagos_pk PRIMARY KEY ( id_transaccion ),
    CONSTRAINT transacpagos_prestamos_fk FOREIGN KEY ( id_cliente,tipo_prestamo )
        REFERENCES prestamos ( id_cliente,cod_tipo_prestamo ),
    CONSTRAINT transac_sucursales_fk FOREIGN KEY ( cod_sucursal )
        REFERENCES sucursales ( cod_sucursal )
);


------------ 2- VISTA DE LOS PRESTAMOS----------------------

CREATE VIEW VIEW_PRESTAMOS
AS 
select pe.NO_PRESTAMO as "NO. PRESTAMO",c.CEDULA as "CEDULA",
c.NOMBRE1 as "NOMBRE",
	 c.APELLIDO1 as "APELLIDO",
	 tp.NOMBRE_PRESTAMO as "TIPO DEPRESTAMO",
	 pe.MONTO_APROBADO as "MONTO APROBADO",
	 pe.LETRA_MENSUAL as "LETRA MENSUAL",
	 p.DESCRIPCION as "PROFESION" 
 from	 PROFESIONES p,
	 PRESTAMOS pe,
	 TIPOS_PRESTAMOS tp,
	 CLIENTES c
     where c.id_cliente = pe.id_cliente 
     and pe.COD_TIPO_PRESTAMO = tp.COD_PRESTAMO 
     and c.COD_PROFESION = p.ID_PROFESION
order by c.CEDULA ASC;


---------------- 3 -- LAS SEQUENCIAS ---------------------

--SECUENCIAS DE ID DE TABLAS Correo--
CREATE SEQUENCE sec_cod_correo
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--SECUENCIAS DE ID DE TABLAS Prestamo--
CREATE SEQUENCE sec_cod_prestamo
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--SECUENCIAS DE ID DE TABLAS TELEFONO--
CREATE SEQUENCE sec_cod_telefono
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--SECUENCIAS DE ID DE TABLAS Profesion--
CREATE SEQUENCE sec_id_profesion
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--SECUENCIAS DE ID DE TABLAS Distrito--
CREATE SEQUENCE sec_cod_distrito
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--SECUENCIAS DE ID DE TABLAS Provincia--
CREATE SEQUENCE sec_cod_provincia
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--SECUENCIAS DE ID DE TABLAS Sucursales--
CREATE SEQUENCE sec_cod_sucursal
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--SECUENCIAS DE ID DE TABLAS Clientes--
CREATE SEQUENCE sec_id_cliente
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--ECUENCIAS DE ID DE TABLAS Prestamo--
CREATE SEQUENCE sec_no_prestamo
INCREMENT BY 100
START WITH 100
MAXVALUE 99999
MINVALUE 100;

--SECUENCIAS DE ID DE TABLAS Transacciones--
CREATE SEQUENCE sec_id_transac
INCREMENT BY 100
START WITH 100
MAXVALUE 99999
MINVALUE 100;

------------ 4- FUNCIONES ----------------------

--EDAD
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

--INTERES
CREATE OR REPLACE FUNCTION calcularInteres(
    p_tipoInteres number,
    p_saldoActual number
)
RETURN NUMBER IS
   V_interes_calculado NUMBER;
   v_saldo NUMBER := p_saldoActual;
   v_interes NUMBER;
   --v_exeption EXCEPTION;
BEGIN
    -- ASIGNA EL VALOR DEL INTERES EN BASE AL TIPO DE PRESTAMO
    IF p_tipoInteres = 1 THEN
    v_interes := 0.05;
    ELSIF p_tipoInteres = 2 THEN
    v_interes := 0.06;
    ELSIF p_tipoInteres = 3 THEN
    v_interes := 0.02;
    ELSIF p_tipoInteres = 4 THEN
    v_interes := 0.03;
    ELSIF p_tipoInteres = 5 THEN
    v_interes := 0.04;
    END IF;
   -- Interes calculado mediante el préstamo e interes
    v_interes_calculado := (v_saldo * v_interes) + v_saldo;
 
   RETURN v_interes_calculado;
    EXCEPTION
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El préstamo no ha sido encontrado.');

END calcularInteres;
/

------------ 5- PROCEDIMIENTOS ALMACENADOS ----------------------

--PROCEDIMIENTO_1
--TIPOS CORREOS
CREATE or REPLACE PROCEDURE Nuevo_tipoCorreo(
    p_Correo    IN tipos_correos.descripcion%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_correo.nextval into intSeqVal from dual;
    INSERT into TIPOS_CORREOS (cod_correo,descripcion)
    VALUES (intSeqVal,p_Correo);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de correo ya existe.');
END Nuevo_tipoCorreo;
/

--TIPOS PRESTAMOS
CREATE or REPLACE PROCEDURE Nuevo_tipoPrestamo(
    p_prestam    IN tipos_prestamos.nombre_prestamo%TYPE,
    p_interes    IN TIPOS_PRESTAMOS.TASA_INTERES%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_prestamo.nextval into intSeqVal from dual;
    INSERT into TIPOS_PRESTAMOS (cod_prestamo,nombre_prestamo,tasa_interes)
    VALUES (intSeqVal,p_prestam,p_interes);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de prestamo ya existe.');
END Nuevo_tipoPrestamo;
/

--TIPOS telefonos
CREATE or REPLACE PROCEDURE Nuevo_tipotelefonos(
    p_telefonos    IN tipos_telefonos.descripcion%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_telefono.nextval into intSeqVal from dual;
    INSERT into TIPOS_TELEFONOS (cod_telefono,descripcion)
    VALUES (intSeqVal,p_telefonos);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de telefono ya existe.');
END Nuevo_tipotelefonos;
/

--TIPOS profesion
CREATE or REPLACE PROCEDURE Nuevo_tipoprofesion(
    p_profesion    IN profesiones.descripcion%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_id_profesion.nextval into intSeqVal from dual;
    INSERT into PROFESIONES(id_profesion,descripcion)
    VALUES (intSeqVal,p_profesion);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La profesion ya existe.');
END Nuevo_tipoprofesion;
/

--Distritos
CREATE or REPLACE PROCEDURE NuevoDistrito(
    p_distrito    IN distritos.nombre%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_distrito.nextval into intSeqVal from dual;
    INSERT into DISTRITOS(cod_distrito,nombre)
    VALUES (intSeqVal,p_distrito);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El distrito ya existe.');
END NuevoDistrito;
/

--Provincias
CREATE or REPLACE PROCEDURE NuevaProvincia(
    p_provincia    IN provincias.nombre%TYPE)
IS
intSeqVal number(10);
BEGIN
    select sec_cod_provincia.nextval into intSeqVal from dual;
    INSERT into PROVINCIAS(cod_provincia,nombre)
    VALUES (intSeqVal,p_provincia);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La provincia ya existe.');
END NuevaProvincia;
/

--sucursales
CREATE or REPLACE PROCEDURE NuevaSucursal(
    p_sucursal    IN SUCURSALES.nombre%TYPE)
IS
intSeqVal number(10);
v_sucursal VARCHAR2(100) := p_sucursal;
v_monto number := 0;
BEGIN

select sec_cod_sucursal.nextval into intSeqVal from dual;
    INSERT into SUCURSALES(COD_SUCURSAL,nombre,MONTO_PRESTAMO)
    VALUES (
        intSeqVal,
        v_sucursal,
        v_monto);

--cada sucursal creada tendra 5 tipos de prestamos
FOR v_counter IN 1..5 LOOP
    INSERT INTO TIPOS_PRE_SUCURSAL(
        COD_SUCURSAL,
        COD_T_PRESTAM,
        monto_presta,
        fecha_mod)
     VALUES(
        intSeqVal,
        v_counter,
        v_monto,
        to_date(sysdate,'DD-MM-YY')
    );
    COMMIT;
    END LOOP;
    
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La sucursal ya existe.');
END NuevaSucursal;
/

--PROCEDIMIENTO_2
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

--PROCEDIMIENTO_3
CREATE OR REPLACE PROCEDURE insertPrestamo(
    p_id_cliente            IN prestamos.id_cliente%TYPE,
    p_cod_tipo_prestamo     IN prestamos.cod_tipo_prestamo%TYPE,
    p_monto_aprobado        IN prestamos.monto_aprobado%TYPE,
    p_fecha_pago            IN prestamos.fecha_pago%TYPE,
    p_no_sucursal IN prestamos.cod_sucursal%TYPE
)
IS
  v_cod_prestamo NUMBER := p_cod_tipo_prestamo;
  intSeqVal number(10);
  v_fecha date := SYSDATE;
  v_saldo number := p_monto_aprobado;
  v_monto_prestamo number := p_monto_aprobado;
  v_interes NUMBER;
  v_importe number := 0;
  v_interes_pagado number := 0;
  v_fecha_pago number := p_fecha_pago;
  v_letra_mensual number := 0;
BEGIN

--1
  select sec_no_prestamo.nextval into intSeqVal from dual;
  SELECT tasa_interes INTO v_interes FROM TIPOS_PRESTAMOS WHERE cod_prestamo = v_cod_prestamo;

--2  

INSERT INTO PRESTAMOS(
  no_prestamo,    
  id_cliente,
  cod_tipo_prestamo,    
  fecha_aprobado, 
  monto_aprobado,    
  letra_mensual,      
  importe_pago, 
  fecha_pago,
  tasa_interes, 
  saldo_actual, 
  interes_pagado,
  fecha_mod,
  cod_sucursal,
  usuario)
VALUES (intSeqVal,
    p_id_cliente,
    p_cod_tipo_prestamo,
    to_date(v_fecha,'DD-MM-YYY HH24:MI:SS'),
    p_monto_aprobado,
    v_letra_mensual, 
    v_importe, 
    v_fecha_pago, 
    v_interes,
    v_saldo, 
    v_interes_pagado,
    to_date(v_fecha,'DD-MM-YYY HH24:MI:SS'),
    p_no_sucursal,
    user
    );

--Actualizacion de la tabla relacion muchos a muchos de TIPO PRESTAMO Y SUCURSAL
UPDATE TIPOS_PRE_SUCURSAL SET MONTO_PRESTA = MONTO_PRESTA + v_monto_prestamo
    WHERE cod_sucursal = p_no_sucursal and cod_t_prestam = p_cod_tipo_prestamo; 

UPDATE SUCURSALES SET MONTO_PRESTAMO = MONTO_PRESTAMO + v_monto_prestamo
    WHERE cod_sucursal = p_no_sucursal; 

COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El PRESTAMO ya existe.');
END insertPrestamo;
/


--PROCEDIMIENTO_4
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

--MODIFICAR LA FECHA PARA REALIZAR PRUEBAS
IF to_char(CURRENT_DATE, 'dd') = '25' OR to_char(CURRENT_DATE, 'dd') = '30' THEN
v_status := 'PE';
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
       DBMS_OUTPUT.PUT_LINE('💣 Error: El PAGO ya existe.');
END insertPagos;
/

--PROCEDIMIENTO_5

CREATE OR REPLACE PROCEDURE actualizarPagos
IS
    v_id_cliente NUMBER;
    v_tipo_prestamo NUMBER; 
    v_cod_sucursal NUMBER;
    v_monto_pago NUMBER(15, 2) DEFAULT 0;
    v_status char(2) := 'PE'; -- SOLO SE PROCESARAN LOS ESTADOS CON ESTE VALOR
    v_id_transac NUMBER;

CURSOR c_transacpagos IS
    SELECT
    id_transaccion, 
    id_cliente, 
    tipo_prestamo,
    monto_pago,
    cod_sucursal
    FROM TRANSACPAGOS
    WHERE
    status = v_status;
BEGIN

OPEN c_transacpagos;
    LOOP
    FETCH c_transacpagos INTO
        v_id_transac,
       v_id_cliente,
       v_tipo_prestamo,
       v_monto_pago,
       v_cod_sucursal;
    EXIT
    WHEN c_transacpagos%NOTFOUND;
    
    --FALTA AGREGAR UNA CONDICION CUNADO EL SALDO LLEGE A CERO
    UPDATE PRESTAMOS
    SET 
    saldo_actual = calcularInteres(v_tipo_prestamo,saldo_actual) - v_monto_pago,
    importe_pago = importe_pago + v_monto_pago,
    interes_pagado = interes_pagado + (calcularInteres(v_tipo_prestamo,saldo_actual) - SALDO_ACTUAL)
    WHERE
    id_cliente = v_id_cliente
    AND
    cod_tipo_prestamo = v_tipo_prestamo;

    UPDATE TIPOS_PRE_SUCURSAL
    SET MONTO_PRESTA = MONTO_PRESTA - v_monto_pago
    WHERE
    cod_sucursal = v_cod_sucursal
    AND
    cod_t_prestam = v_tipo_prestamo;

    UPDATE SUCURSALES
    SET MONTO_PRESTAMO = MONTO_PRESTAMO - v_monto_pago               
    WHERE
    cod_sucursal = v_cod_sucursal;

    --ACTUALIZA EL ESTADO DEL PAGO PARA QUE NO SE VUELVA A REPETIR
    UPDATE TRANSACPAGOS
    SET
    status = 'PR'
    WHERE
    id_transaccion = v_id_transac;

    END LOOP;
CLOSE c_transacpagos;

END;
/


------------------- 6 INSERCCION DE LOS DATOS -------------


    --TIPOS_PRESTAMOS--
EXECUTE Nuevo_tipoPrestamo('Hipoteca', 0.05);
EXECUTE Nuevo_tipoPrestamo('Personal', 0.06);
EXECUTE Nuevo_tipoPrestamo('CasaCash', 0.02);
EXECUTE Nuevo_tipoPrestamo('Auto', 0.03);
EXECUTE Nuevo_tipoPrestamo('Garantizado con Ahorros', 0.04);

    --SUCURSALES
EXECUTE NuevaSucursal('Primera');
EXECUTE NuevaSucursal('Segunda');
EXECUTE NuevaSucursal('Tercera');
EXECUTE NuevaSucursal('Cuarta');
    --PROFESIONES--
EXECUTE Nuevo_tipoprofesion('Profesor');
EXECUTE Nuevo_tipoprofesion('Dentista');
EXECUTE Nuevo_tipoprofesion('Policia');
EXECUTE Nuevo_tipoprofesion('Bombero');
EXECUTE Nuevo_tipoprofesion('Enfermero');
EXECUTE Nuevo_tipoprofesion('Arquictecto');
EXECUTE Nuevo_tipoprofesion('Abogado');
EXECUTE Nuevo_tipoprofesion('Contador');
EXECUTE Nuevo_tipoprofesion('Químico');
EXECUTE Nuevo_tipoprofesion('Reportero');

    ---CLIENTES
EXECUTE insertCliente('800-99-123','JUAN','ZELAYA','16-JAN-1995','M',1,'La Locería calle 5', 1);
EXECUTE insertCliente('800-99-124','KREVITH','SHAW','20-AUG-1981','M',2,'La Gloria, Bethania, cl 19cN, ca 37', 2);
EXECUTE insertCliente('800-99-125','BORIS','FLORES','15-SEP-1992','M',3,'Plaza Camino de Cruces El Dorado', 3);
EXECUTE insertCliente('800-99-126','SERGIO','ROJAS','25-MAY-1993','M',4,'San francisco calle 70', 4);
EXECUTE insertCliente('800-99-127','RANDALL','WAYNE','13-APR-1998','M',5,'Obarrio, Calle 56 Este, Edificio Enid', 1);
/*EXECUTE insertCliente('800-99-128','JORGE','MOLINA','17-JUL-1987','M',6,'PH Edison Corporate Center Piso 8.', 2);
EXECUTE insertCliente('800-99-129','SEBASTIAN','GONZALEZ','27-DEC-1991','M',7,'Calle 109 Este, entrada de Chanis', 3);
EXECUTE insertCliente('800-99-130','ANTONIO','FALLAS','12-JUN-1957','M',8,'Calle D El Cangrejo y Eusebio A Morales.', 4);
--Execute insertCliente('800-99-131','JOSE','FALLAS','09-FEB-2000','M',9,'Calle Williamson Place, La Boca, Ancón', 1);
EXECUTE insertCliente('800-99-132','PATRICIA','CENTENO','16-JAN-1995','F',10,'Calle 53 El Cangrejo', 2);*/


--PRESTAMOS--ID_CLIENTE, TIPO PRESTAMO, MONTO APROBADO,FECHA_pago, cod_sucursal
/*EXECUTE insertPrestamo(1,2,600,15,1);
EXECUTE insertPrestamo(1,3,250, 15,2);    
EXECUTE insertPrestamo(1,4,300,30,3);
EXECUTE insertPrestamo(2,1,600, 30,2);    
EXECUTE insertPrestamo(4,1,800, 15,4);    
EXECUTE insertPrestamo(2,3,900,30,4);
EXECUTE insertPrestamo(2,4,500, 15,2);    
EXECUTE insertPrestamo(3,1,400, 15,4);    
EXECUTE insertPrestamo(3,2,550, 15,1);

--PAGOS ( ID CLIENTE, TIPO PRESTAMO, MOTO DEL PAGO)
EXECUTE insertPagos(1,2,100); 
EXECUTE insertPagos(1,2,100); 
EXECUTE insertPagos(1,2,100); 
EXECUTE insertPagos(1,2,100); 
EXECUTE insertPagos(1,2,100); 
EXECUTE insertPagos(1,2,100); 
EXECUTE insertPagos(1,2,100);
EXECUTE insertPagos(1,2,62.79);
EXECUTE insertPagos(1,2,3.77);*/


----PARTE II DEL LABORATORIO 7------

-- 1 Tipo de ahorros
CREATE TABLE tipos_ahorros (
    id_tipo_ahorro NUMBER NOT NULL,
    descripcion VARCHAR2(30),
    tasa_interes NUMBER (15,2),
    CONSTRAINT tp_ahorro_pk PRIMARY KEY (id_tipo_ahorro)
);


-- 2 Tipo de AH Sucursal
CREATE TABLE TIPO_AH_SUC (
    cod_sucursal NUMBER NOT NULL,
    id_tipo_ahorro NUMBER NOT NULL,
    monto_ahorros NUMBER(15,2) DEFAULT 0,
    fecha_mod DATE,  
    CONSTRAINT tipo_ah_suc_pk PRIMARY KEY (cod_sucursal, id_tipo_ahorro),
    CONSTRAINT tipo_suc_fk FOREIGN KEY (cod_sucursal) 
    REFERENCES SUCURSALES (cod_sucursal),
    CONSTRAINT tipo_ah_fk FOREIGN KEY (id_tipo_ahorro) 
    REFERENCES TIPOS_AHORROS (id_tipo_ahorro)
);


-- 3 Ahorros
CREATE TABLE ahorros (
    no_cuenta NUMBER NOT null,
    id_cliente NUMBER NOT NULL,
    tipo_ahorro NUMBER NOT NULL,
    cod_sucursal NUMBER NOT NULL,
    fecha_apertura DATE,
    tasa_interes NUMBER(2, 2) DEFAULT 0,
    deposito_mensual  NUMBER(15, 2) DEFAULT 0, 
    saldo_ahorro      NUMBER(15, 2) DEFAULT 0, 
    saldo_interes     NUMBER(15, 2) DEFAULT 0,  
    usuario        VARCHAR2(45),
    fecha_deposito NUMBER,
    fecha_retiro   NUMBER, 
    fecha_mod      DATE,
    CONSTRAINT ahorros_pk PRIMARY KEY (no_cuenta),
    CONSTRAINT ahorros_sucursales_fk FOREIGN KEY (cod_sucursal)
        REFERENCES SUCURSALES (cod_sucursal),
    CONSTRAINT ahorros_tipo_ahorros_fk FOREIGN KEY (tipo_ahorro)
        REFERENCES tipos_ahorros (id_tipo_ahorro),
    CONSTRAINT ahorros_cliente_fk FOREIGN KEY (id_cliente)
        REFERENCES clientes (id_cliente)
);


-- 4 Transacciones Depo Reti
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
    CONSTRAINT transadeporeti_tp_trans_ck CHECK (tipo_transac in(1, 2)),
    CONSTRAINT status_ck CHECK (status in('PE', 'PR')),
    CONSTRAINT transaDepoReti_pk PRIMARY KEY ( id_transaccion ), 
    CONSTRAINT transadeporeti_ahorros_fk FOREIGN KEY (no_cuenta)
        REFERENCES ahorros(no_cuenta),
    CONSTRAINT ti_transaDepoRecliente_fk FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),
    CONSTRAINT transaDepoReti_tipoahorro_fk FOREIGN KEY (tipo_ahorro)
        REFERENCES tipos_ahorros(id_tipo_ahorro),    
    CONSTRAINT transaDepoReti_sucursales_fk FOREIGN KEY ( cod_sucursal )
        REFERENCES sucursales ( cod_sucursal )
);


-- 5 AUDITORIA
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


-- 6 ALTER TABLA SUCURSAL
ALTER TABLE 
     SUCURSALES 
     ADD monto_ahorros NUMBER(15,2) DEFAULT 0 NOT NULL; 



--- SECUENCIAS LABORATORIO 7 ---

--SECUENCIAS DE ID TIPO AHORRO --
CREATE SEQUENCE sec_tipo_aho
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--SECUENCIAS DE NUMERO CUENTA AHORRO
CREATE SEQUENCE sec_no_cuenta
INCREMENT BY 100
START WITH 100
MAXVALUE 99999
MINVALUE 100;

--SECUENCIAS DE ID TRANSACCION DEPOSITO RETIRO
CREATE SEQUENCE sec_transacdeporeti
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--SECUENCIAS DE AUDITORIA-
CREATE SEQUENCE sec_cod_aut
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
MINVALUE 1;

--- FUNCIONES




-- PROCEDIMIENTOS PARA AHORROS -----

--TIPOS AHORRO
-- Hace falta
CREATE OR REPLACE PROCEDURE Nuevo_tipoAhorro(
    p_ahorro_descripcion  IN tipos_ahorros.descripcion%TYPE,
    p_ahorro_tasa_interes  IN tipos_ahorros.tasa_interes%TYPE
    )
IS
intSeqVal number(10);
BEGIN
    select sec_tipo_aho.nextval into intSeqVal from dual;
    INSERT into tipos_ahorros (id_tipo_ahorro, descripcion, tasa_interes)
    VALUES (intSeqVal, p_ahorro_descripcion, p_ahorro_tasa_interes);
    COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El tipo de ahorro ya existe.');
END Nuevo_tipoAhorro;
/

-- Insertar ahorros
/*
Procedimiento almacenado para la apertura o inserción de los ahorros aprobados
con toda la información correspondiente..
*/


CREATE OR REPLACE PROCEDURE insertAhorro(
    p_id_cliente            IN ahorros.id_cliente%TYPE,
    p_tipo_ahorro     IN ahorros.tipo_ahorro%TYPE,
    p_cod_sucursal        IN ahorros.cod_sucursal%TYPE,
    p_depo_mensual          IN ahorros.deposito_mensual%TYPE,
    p_fecha_deposito            IN ahorros.fecha_deposito%TYPE,
    p_fecha_retiro        IN ahorros.fecha_retiro%TYPE
)
IS
  intSeqVal number(10);
  v_fecha_ap date := SYSDATE;
  v_saldo_ah number := 10;
  v_interes NUMBER;
  v_saldoInteres NUMBER := 10;
  v_fecha_deposito number := p_fecha_deposito;
  v_fecha_retiro NUMBER := p_fecha_retiro;
  
BEGIN

  select sec_no_cuenta.nextval into intSeqVal from dual;
  SELECT tasa_interes INTO v_interes FROM TIPOS_AHORROS WHERE id_tipo_ahorro = p_tipo_ahorro;

INSERT INTO AHORROS

VALUES (
    intSeqVal,
    p_id_cliente,
    p_tipo_ahorro,
    p_cod_sucursal,
    to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    v_interes,
    p_depo_mensual,
    v_saldo_ah,
    v_saldoInteres,
    user,
    v_fecha_deposito,
    v_fecha_retiro,
    to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS')
    );

COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: El numero de cuenta ya existe.');
END insertAhorro;
/


-- INSERT TRANSADEPORETI --

CREATE OR REPLACE PROCEDURE insertTransaDeporeti (
  p_id_cliente IN transaDepoReti.id_cliente%TYPE,
  p_no_cuenta IN transaDepoReti.no_cuenta%TYPE, 
  p_tipo_ahorro IN transaDepoReti.tipo_ahorro%TYPE,
  p_cod_sucursal IN transaDepoReti.cod_sucursal%TYPE,
  p_tipo_transac IN transaDepoReti.tipo_transac%TYPE,
  p_monto IN transaDepoReti.monto%TYPE
)
IS
  intSeqVal number(10);
  --v_fecha_ap date := SYSDATE;
  --v_usuario VARCHAR2(45) := USER;
  v_status CHAR(2) := 'PE';
  v_monto NUMBER(15,2) := p_monto;
  --v_exception VARCHAR2(250) := EXCEPTION;
BEGIN
  select sec_transacdeporeti.nextval into intSeqVal from dual;

-- CONDICION DE TRANSACCION 1= DEPOSITO, 2=RETIRO solo de cuenta corriente se puede retirar.

IF p_tipo_ahorro = 2 AND (p_tipo_transac = 1 OR  p_tipo_transac =2 ) THEN
  INSERT INTO transaDepoReti
  VALUES(
    intSeqVal,
    p_no_cuenta,
    p_id_cliente,
    p_tipo_ahorro,
    p_cod_sucursal,
    --to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    SYSDATE,
    p_tipo_transac,
    v_monto,
    --to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    SYSDATE,
    v_status,
    user
  );

ELSIF (p_tipo_ahorro = 1 OR p_tipo_ahorro = 3) AND p_tipo_transac = 1 THEN
  INSERT INTO transaDepoReti
  VALUES(
    intSeqVal,
    p_no_cuenta,
    p_id_cliente,
    p_tipo_ahorro,
    p_cod_sucursal,
    --to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    SYSDATE,
    p_tipo_transac,
    v_monto,
    --to_date(v_fecha_ap,'DD-MM-YYY HH24:MI:SS'),
    SYSDATE,
    v_status,
    user
  );
ELSE
  DBMS_OUTPUT.PUT_LINE('💣 Error: El tiempo de retiro no puede realizarse en este momento. Verifique su tipo de cuenta.');



END IF;
COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       DBMS_OUTPUT.PUT_LINE('💣 Error: La transacción ya existe.');
END insertTransaDeporeti;
/

