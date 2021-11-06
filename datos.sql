
    /*---TIPOS_CORREOS--
    EXECUTE Nuevo_tipoCorreo('Personal');
    EXECUTE Nuevo_tipoCorreo('Profesional');
    EXECUTE Nuevo_tipoCorreo('Academico');

    --TIPOS_TELEFONOS--
    EXECUTE Nuevo_tipotelefonos('Celular');
    EXECUTE Nuevo_tipotelefonos('Residencia');
    EXECUTE Nuevo_tipotelefonos('Familiar');
    EXECUTE Nuevo_tipotelefonos('Conyugue');
      --PROVINCIAS--

    execute NuevaProvincia('Bocas del Toro');
    execute NuevaProvincia('Coclé');
    execute NuevaProvincia('Colón');
    execute NuevaProvincia('Chiriquí');
    execute NuevaProvincia('Darién');
    execute NuevaProvincia('Herrera');
    execute NuevaProvincia('Los Santos');
    execute NuevaProvincia('Panamá');
    execute NuevaProvincia('Veraguas');
    execute NuevaProvincia('Panamá Oeste');*/

    --TIPOS_PRESTAMOS--
    EXECUTE Nuevo_tipoPrestamo('Hipoteca', 0.05);
    EXECUTE Nuevo_tipoPrestamo('Personal', 0.06);
    EXECUTE Nuevo_tipoPrestamo('CasaCash', 0.02);
    EXECUTE Nuevo_tipoPrestamo('Auto', 0.03);
    EXECUTE Nuevo_tipoPrestamo('Garantizado con Ahorros', 0.04);

    --SUCURSALES
    EXECUTE NuevaSucursal('Primera');
    EXECUTE NuevaSucursal('Segunda');
    EXECUTE NuevaSucursal('Tercera');.
    EXECUTE NuevaSucursal('Cuarta');

 

    --PROFESIONES--
    execute Nuevo_tipoprofesion('Profesor');
    execute Nuevo_tipoprofesion('Dentista');
    execute Nuevo_tipoprofesion('Policia');
    execute Nuevo_tipoprofesion('Bombero');
    execute Nuevo_tipoprofesion('Enfermero');
    execute Nuevo_tipoprofesion('Arquictecto');
    execute Nuevo_tipoprofesion('Abogado');
    execute Nuevo_tipoprofesion('Contador');
    execute Nuevo_tipoprofesion('Químico');
    execute Nuevo_tipoprofesion('Reportero');

    ---CLIENTES
    execute insertCliente('800-99-123','JUAN','ZELAYA','16-JAN-1995','M',1,'La Locería calle 5', 1);
    execute insertCliente('800-99-124','KREVITH','SHAW','20-AUG-1981','M',2,'La Gloria, Bethania, cl 19cN, ca 37', 2);
    execute insertCliente('800-99-125','BORIS','FLORES','15-SEP-1992','M',3,'Plaza Camino de Cruces El Dorado', 3);
    execute insertCliente('800-99-126','SERGIO','ROJAS','25-MAY-1993','M',4,'San francisco calle 70', 4);
    execute insertCliente('800-99-127','RANDALL','WAYNE','13-APR-1998','M',5,'Obarrio, Calle 56 Este, Edificio Enid', 1);
    execute insertCliente('800-99-128','JORGE','MOLINA','17-JUL-1987','M',6,'PH Edison Corporate Center Piso 8.', 2);
    execute insertCliente('800-99-129','SEBASTIAN','GONZALEZ','27-DEC-1991','M',7,'Calle 109 Este, entrada de Chanis', 3);
    execute insertCliente('800-99-130','ANTONIO','FALLAS','12-JUN-1957','M',8,'Calle D El Cangrejo y Eusebio A Morales.', 4);
    --execute insertCliente('800-99-131','JOSE','FALLAS','09-FEB-2000','M',9,'Calle Williamson Place, La Boca, Ancón', 1);
    execute insertCliente('800-99-132','PATRICIA','CENTENO','16-JAN-1995','F',10,'Calle 53 El Cangrejo', 2);


    --PRESTAMOS--ID_CLIENTE,TIPO_PRESTAMO,MONTO_APROBADO,FECHA_pago,cod_sucursal
    EXECUTE insertPrestamo(1,2,600,15,1);
    EXECUTE insertPrestamo(1,3,250, 15,2);    
    EXECUTE insertPrestamo(1,4,300,30,3);
    EXECUTE insertPrestamo(2,1,600, 30,2);    
    EXECUTE insertPrestamo(4,1,800, 15,4);    
    EXECUTE insertPrestamo(2,3,900,30,4);
    EXECUTE insertPrestamo(2,4,500, 15,2);    
    EXECUTE insertPrestamo(3,1,400, 15,4);    
    EXECUTE insertPrestamo(3,2,550, 15,1);


    --TRANSACPAGOS : idcliente, tipo_prestamo,monto del pago
    EXECUTE insertPagos(3,1,60);

/*
    --CLIENTES_CORREOS--
    INSERT INTO CLIENTES_CORREOS VALUES (8977,1,'8977JUAN1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (8977,2,'8977JUAN2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (8977,3,'8977JUAN3@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9010,1,'9010KREVITH1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9010,2,'9010KREVITH2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9010,3,'9010KREVITH3@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9067,1,'9067BORIS1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9067,2,'9067BORIS2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9067,3,'9067BORIS3@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9173,1,'9173SERGIO1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9173,2,'9173SERGIO2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9173,3,'9173SERGIO3@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9208,1,'9208RANDALL1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9208,2,'9208RANDALL2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9208,3,'9208RANDALL3@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9235,1,'9235JORGE1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9235,2,'9235JORGE2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9235,3,'9235JORGE3@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9248,1,'9248SEBASTIAN1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9248,2,'9248SEBASTIAN2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9248,3,'9248SEBASTIAN3@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9251,1,'9251ANTONIO1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9251,2,'9251ANTONIO2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9251,3,'9251ANTONIO3@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9274,1,'9274JOSE1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9274,2,'9274JOSE2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9274,3,'9274JOSE3@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9333,1,'9333PATRICIA1@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9333,2,'9333PATRICIA2@MAIL.COM');
    INSERT INTO CLIENTES_CORREOS VALUES (9333,3,'9333PATRICIA3@MAIL.COM');

    --CLIENTES_TELEFONOS---
    INSERT INTO CLIENTES_TELEFONOS VALUES (8977, 10,'802559');
    INSERT INTO CLIENTES_TELEFONOS VALUES (8977, 20,'865737');
    INSERT INTO CLIENTES_TELEFONOS VALUES (8977, 30,'815012');
    INSERT INTO CLIENTES_TELEFONOS VALUES (8977, 40,'974958');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9010, 10,'996924');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9010, 20,'862603');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9010, 30,'832132');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9010, 40,'958363');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9067, 10,'855955');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9067, 20,'974666');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9067, 30,'964758');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9067, 40,'864231');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9173, 10,'840611');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9173, 20,'898722');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9173, 30,'968618');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9173, 40,'850501');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9208, 10,'900533');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9208, 20,'913523');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9208, 30,'819270');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9208, 40,'899377');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9235, 10,'869030');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9235, 20,'880981');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9235, 30,'931651');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9235, 40,'986750');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9248, 10,'871921');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9248, 20,'941760');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9248, 30,'999656');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9248, 40,'942548');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9251, 10,'807811');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9251, 20,'854847');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9251, 30,'815097');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9251, 40,'990741');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9274, 10,'845060');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9274, 20,'925870');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9274, 30,'989923');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9274, 40,'959967');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9333, 10,'918534');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9333, 20,'817105');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9333, 30,'880974');
    INSERT INTO CLIENTES_TELEFONOS VALUES (9333, 40,'959884');

*/


 --- PARTE II LABORATORIO 7 --

 --Tipos de ahorros. -Descripción, tasa de interes. Falta
EXECUTE Nuevo_tipoAhorro('Ahorro de Navidad', 0.06);
EXECUTE Nuevo_tipoAhorro('Ahorro de Corriente', 0.04);
EXECUTE Nuevo_tipoAhorro('Ahorro escolar', 0.06);

--
/*--PARAMETROS AHORROS
1-id_cliente number
2-tipo_ahorro number
3-cod_sucursal number 
4-deposito MENSUAL number
5-fecha deposito=dia, 
6-fecha retiro=dia */ 
EXECUTE insertAhorro(1,1,1,10,15,10);
EXECUTE insertAhorro(2,1,2,10,15,10);
EXECUTE insertAhorro(3,2,1,100,15,10);
EXECUTE insertAhorro(4,3,2,200,15,10);
EXECUTE insertAhorro(5,1,2,300,15,10);



/*--PARAMETROS TRANSAC
1-id_cliente number
2-NO CUENTA number SEC 100 EN 100
3-TIPO AHORRO number 
4-SUCURSAL number
5-TIPO TRANSAC (1=DEPO, 2=RETI), 
6-MONTO NUMBER */ 

EXECUTE insertTransaDeporeti(1,100,1,1,1,20);
EXECUTE insertTransaDeporeti(2,200,2,1,1,139);
EXECUTE insertTransaDeporeti(3,300,2,1,1,100);
EXECUTE insertTransaDeporeti(3,300,2,1,2,40);
EXECUTE insertTransaDeporeti(4,400,3,2,1,50);
EXECUTE insertTransaDeporeti(5,500,1,2,1,80);



