
--PROVINCIAS--
CREATE TABLE provincias (
    cod_provincia NUMBER NOT NULL,
    nombre        VARCHAR2(45),
    CONSTRAINT provincias_pk PRIMARY KEY ( cod_provincia )
);

--DISTRITOS--
CREATE TABLE distritos (
    cod_distrito NUMBER NOT NULL,
    nombre       VARCHAR2(45),
    CONSTRAINT distritos_pk PRIMARY KEY ( cod_distrito )
);

--PROFESIONES--
CREATE TABLE profesiones (
    id_profesion NUMBER NOT NULL,
    descripcion  VARCHAR2(100),
    CONSTRAINT profesion_pk PRIMARY KEY ( id_profesion )
);

--CIENTES--
CREATE TABLE clientes (
    id_cliente    NUMBER NOT NULL,
    cedula        VARCHAR2(10) NOT NULL,
    nombre1       VARCHAR2(45),
    apellido1     VARCHAR2(45),
    fecha_nac     DATE,
    sexo          VARCHAR2(2),
    cod_profesion NUMBER NOT NULL,
    cod_provincia NUMBER NOT NULL,
    calle         VARCHAR2(50),
    CONSTRAINT clientes_pk PRIMARY KEY ( id_cliente ),
    CONSTRAINT clientes_profesion_fk FOREIGN KEY ( cod_profesion )
        REFERENCES profesiones ( id_profesion ),
    CONSTRAINT clientes_provincias_fk FOREIGN KEY ( cod_provincia )
        REFERENCES provincias ( cod_provincia )
);

--TIPOS DE PRESTAMOS--
CREATE TABLE tipos_prestamos (
    cod_prestamo    NUMBER NOT NULL,
    nombre_prestamo VARCHAR2(45),
    tasa_interes    NUMBER(2, 2),
    CONSTRAINT tipos_prestamos_pk PRIMARY KEY ( cod_prestamo )
);

--TIPOS DE CORREOS--
CREATE TABLE tipos_correos (
    cod_correo  NUMBER NOT NULL,
    descripcion VARCHAR2(50),
    CONSTRAINT tipos_correos_pk PRIMARY KEY ( cod_correo )
);


--TIPOS DE TELEFONOS--
CREATE TABLE tipos_telefonos (
    cod_telefono NUMBER NOT NULL,
    descripcion  VARCHAR2(50),
    CONSTRAINT tipos_telefonos_pk PRIMARY KEY ( cod_telefono )
);

--RELACION CLIENTES_CORREOS--
CREATE TABLE clientes_correos (
    id_cliente NUMBER NOT NULL,
    id_correo  NUMBER NOT NULL,
    correo     VARCHAR2(100),
    CONSTRAINT clientes_correos_pk PRIMARY KEY ( id_cliente,
    id_correo ),
    CONSTRAINT clientes_fk FOREIGN KEY ( id_cliente )
        REFERENCES clientes ( id_cliente ),
    CONSTRAINT tipos_correos_fk FOREIGN KEY ( id_correo )
        REFERENCES tipos_correos ( cod_correo )
);

--RELACION CLIENTES_TELEFONOS--
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

--RELACION PROVINCIAS_DISTRITOS--
CREATE TABLE provincias_distritos (
    cod_provincia NUMBER NOT NULL,
    cod_distrito  NUMBER NOT NULL,
    CONSTRAINT provincias_distritos_pk PRIMARY KEY ( cod_provincia,cod_distrito ),
    CONSTRAINT distritos_fk FOREIGN KEY ( cod_distrito )
        REFERENCES distritos ( cod_distrito ),
    CONSTRAINT provincias_fk FOREIGN KEY ( cod_provincia )
        REFERENCES provincias ( cod_provincia )
);

--PRESTAMOS--
CREATE TABLE prestamos (
    id_cliente        NUMBER NOT NULL,
    cod_tipo_prestamo NUMBER NOT NULL,
    no_prestamo       NUMBER,
    fecha_aprovado    DATE,
    monto_aprobado    NUMBER(8, 4),
    letr_mensual      NUMBER(8, 4),
    importe_pago      NUMBER(8, 4),
    fecha_pago        DATE,
    tasa_interes      NUMBER(4, 2),
    CONSTRAINT prestamos_pk PRIMARY KEY ( id_cliente,cod_tipo_prestamo ),
    CONSTRAINT prestamos_clientes_fk FOREIGN KEY ( id_cliente )
        REFERENCES clientes ( id_cliente ),
    CONSTRAINT prestamos_tipos_prestamos_fk FOREIGN KEY ( cod_tipo_prestamo )
        REFERENCES tipos_prestamos ( cod_prestamo )
);








---VISTA DE LOS PRESTAMOS--

CREATE VIEW VIEW_PRESTAMOS
AS select	 pe.NO_PRESTAMO as "NO. PRESTAMO",c.CEDULA as "CEDULA",
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
     where c.id_cliente = pe.id_cliente and pe.TIPO_PRESTAMO = tp.COD_PRESTAMO and c.COD_PROFESION = p.ID_PROFESION
order by c.CEDULA ASC;