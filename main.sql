
CREATE TABLE clientes (
    id_cliente    NUMBER NOT NULL,
    cedula        VARCHAR2(10) NOT NULL,
    nombre1       VARCHAR2(45),
    apellido1     VARCHAR2(45),
    fecha_nac     DATE,
    cod_profesion NUMBER NOT NULL,
    direccion     VARCHAR2(250),
    sexo          VARCHAR2(2)
);

ALTER TABLE clientes ADD CONSTRAINT clientes_pk PRIMARY KEY ( id_cliente );

CREATE TABLE clientes_correos (
    id_cliente NUMBER NOT NULL,
    id_correo  NUMBER NOT NULL,
    correo     VARCHAR2(100)
);

ALTER TABLE clientes_correos ADD CONSTRAINT clientes_correos_pk PRIMARY KEY ( id_cliente,
                                                                              id_correo );

CREATE TABLE clientes_telefonos (
    id_cliente  NUMBER NOT NULL,
    id_telefono NUMBER NOT NULL,
    telefono    VARCHAR2(10)
);

ALTER TABLE clientes_telefonos ADD CONSTRAINT clientes_telefonos_pk PRIMARY KEY ( id_cliente,
                                                                                  id_telefono );

CREATE TABLE pagos (
    no_pago      NUMBER NOT NULL,
    monto_pagado NUMBER(6, 4),
    fecha_pagado DATE
);

ALTER TABLE pagos ADD CONSTRAINT pagos_pk PRIMARY KEY ( no_pago );

CREATE TABLE pagos_prestamos (
    no_prestamo NUMBER NOT NULL,
    no_pago     NUMBER NOT NULL,
    fecha_pago  DATE
);

ALTER TABLE pagos_prestamos ADD CONSTRAINT pagos_prestamos_pkv2 PRIMARY KEY ( no_prestamo );

CREATE TABLE prestamos (
    no_prestamo    NUMBER NOT NULL,
    id_cliente     NUMBER NOT NULL,
    tipo_prestamo  NUMBER NOT NULL,
    fecha_aprobado DATE,
    monto_aprobado NUMBER,
    no_coutas      NUMBER,
    letra_mensual  NUMBER
);

ALTER TABLE prestamos ADD CONSTRAINT prestamos_pk PRIMARY KEY ( no_prestamo );

CREATE TABLE profesiones (
    id_profesion NUMBER NOT NULL,
    descripcion  VARCHAR2(100)
);

ALTER TABLE profesiones ADD CONSTRAINT profesion_pk PRIMARY KEY ( id_profesion );

CREATE TABLE tipos_correos (
    cod_correo  NUMBER NOT NULL,
    descripcion VARCHAR2(50)
);

ALTER TABLE tipos_correos ADD CONSTRAINT tipos_correos_pk PRIMARY KEY ( cod_correo );

CREATE TABLE tipos_prestamos (
    cod_prestamo    NUMBER NOT NULL,
    nombre_prestamo VARCHAR2(45),
    tasa_interes    NUMBER(6,2)
);

ALTER TABLE tipos_prestamos ADD CONSTRAINT tipos_prestamos_pk PRIMARY KEY ( cod_prestamo );

CREATE TABLE tipos_telefonos (
    cod_telefono NUMBER NOT NULL,
    descripcion  VARCHAR2(50)
);

ALTER TABLE tipos_telefonos ADD CONSTRAINT tipos_telefonos_pk PRIMARY KEY ( cod_telefono );

ALTER TABLE clientes_correos
    ADD CONSTRAINT clientes_fk FOREIGN KEY ( id_cliente )
        REFERENCES clientes ( id_cliente );

ALTER TABLE clientes
    ADD CONSTRAINT clientes_profesion_fk FOREIGN KEY ( cod_profesion )
        REFERENCES profesiones ( id_profesion );

ALTER TABLE clientes_telefonos
    ADD CONSTRAINT clientes_telefonos_fk FOREIGN KEY ( id_cliente )
        REFERENCES clientes ( id_cliente );

ALTER TABLE clientes_telefonos
    ADD CONSTRAINT clientes_tipos_telefonos_fk FOREIGN KEY ( id_telefono )
        REFERENCES tipos_telefonos ( cod_telefono );

ALTER TABLE pagos_prestamos
    ADD CONSTRAINT pagos_prestamos_pagos_fk FOREIGN KEY ( no_pago )
        REFERENCES pagos ( no_pago );

ALTER TABLE pagos_prestamos
    ADD CONSTRAINT pagos_prestamos_prestamos_fk FOREIGN KEY ( no_prestamo )
        REFERENCES prestamos ( no_prestamo );

ALTER TABLE prestamos
    ADD CONSTRAINT prestamos_clientes_fk FOREIGN KEY ( id_cliente )
        REFERENCES clientes ( id_cliente );

ALTER TABLE prestamos
    ADD CONSTRAINT prestamos_tipos_prestamos_fk FOREIGN KEY ( tipo_prestamo )
        REFERENCES tipos_prestamos ( cod_prestamo );

ALTER TABLE clientes_correos
    ADD CONSTRAINT tipos_correos_fk FOREIGN KEY ( id_correo )
        REFERENCES tipos_correos ( cod_correo );

