
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
    fecha_up      DATE,
    CONSTRAINT tipos_pre_sucursal_pk PRIMARY KEY ( cod_sucursal,cod_t_prestam ),
    CONSTRAINT tipos_prestamos_fk FOREIGN KEY ( cod_t_prestam )
        REFERENCES tipos_prestamos ( cod_prestamo ),
CONSTRAINT tipos_sucursales_fk FOREIGN KEY ( cod_sucursal )
        REFERENCES sucursales ( cod_sucursal )
);


CREATE TABLE prestamos (
    id_cliente        NUMBER NOT NULL,
    cod_tipo_prestamo NUMBER NOT NULL,
    no_prestamo       NUMBER NOT NULL,
    fecha_aprobado    DATE,
    monto_aprobado    NUMBER(15,2) DEFAULT 0,
    letra_mensual      NUMBER(15,2) DEFAULT 0,
    importe_pago      NUMBER(15,2) DEFAULT 0,
    fecha_pago        DATE,
    tasa_interes      NUMBER(2, 2) DEFAULT 0,
    saldo_acual       NUMBER(15, 2) DEFAULT 0,
    interes_pagado    NUMBER(15, 2) DEFAULT 0,
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
    CONSTRAINT transacpagos_pk PRIMARY KEY ( id_transaccion ),
    CONSTRAINT transacpagos_prestamos_fk FOREIGN KEY ( id_cliente,tipo_prestamo )
        REFERENCES prestamos ( id_cliente,cod_tipo_prestamo ),
    CONSTRAINT transac_sucursales_fk FOREIGN KEY ( cod_sucursal )
        REFERENCES sucursales ( cod_sucursal )
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