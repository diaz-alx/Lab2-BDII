---clientes--

INSERT INTO CLIENTES VALUES (8977, '800-99-123','JUAN','ZELAYA', TO_DATE('16-01-1995','DD-MM-YYYY'),10,'La Locería calle 5 ','M');
INSERT INTO CLIENTES VALUES (9010, '800-99-124','KREVITH','SHAW', TO_DATE('20-08-1981','DD-MM-YYYY'),20,'La Gloria, Bethania, cl 19cN, ca 37','M');
INSERT INTO CLIENTES VALUES (9067, '800-99-125','BORIS','FLORES', TO_DATE('15-09-1992','DD-MM-YYYY'),30,'Plaza Camino de Cruces El Dorado','M');
INSERT INTO CLIENTES VALUES (9173, '800-99-126','SERGIO','ROJAS', TO_DATE('25-05-1993','DD-MM-YYYY'),40,'San francisco calle 70','M');
INSERT INTO CLIENTES VALUES (9208, '800-99-127','RANDALL','WAYNE', TO_DATE('13-04-1998','DD-MM-YYYY'),50,'Obarrio, Calle 56 Este, Edificio Enid,','M');
INSERT INTO CLIENTES VALUES (9235, '800-99-128','JORGE','MOLINA', TO_DATE('17-07-1987','DD-MM-YYYY'),60,'PH Edison Corporate Center Piso 8.','M');
INSERT INTO CLIENTES VALUES (9248, '800-99-129','SEBASTIAN','GONZALEZ', TO_DATE('27-12-1991','DD-MM-YYYY'),70,'Calle 109 Este, entrada de Chanis','M');
INSERT INTO CLIENTES VALUES (9251, '800-99-130','ANTONIO','FALLAS', TO_DATE('12-06-1957','DD-MM-YYYY'),80,'Calle D El Cangrejo y Eusebio A Morales.','M');
INSERT INTO CLIENTES VALUES (9274, '800-99-131','JOSE','FALLAS', TO_DATE('09-02-2000','DD-MM-YYYY'),90,'Calle Williamson Place, La Boca, Ancón','M');
INSERT INTO CLIENTES VALUES (9333, '800-99-132','PATRICIA','CENTENO', TO_DATE('16-01-1995','DD-MM-YYYY'),100,'Calle 53 El Cangrejo','F');


---TIPOS_CORREOS--
INSERT INTO TIPOS_CORREOS VALUES (1, 'Personal');
INSERT INTO TIPOS_CORREOS VALUES (2, 'Profesional');
INSERT INTO TIPOS_CORREOS VALUES (3, 'Academico');

--TIPOS_TELEFONOS--
INSERT INTO TIPOS_TELEFONOS VALUES (10, 'celular');
INSERT INTO TIPOS_TELEFONOS VALUES (20, 'residencia');
INSERT INTO TIPOS_TELEFONOS VALUES (30, 'familiar');
INSERT INTO TIPOS_TELEFONOS VALUES (40, 'conyugue');

--PROFESIONES--
INSERT INTO PROFESIONES VALUES (10, 'Profesor');
INSERT INTO PROFESIONES VALUES (20, 'Dentista');
INSERT INTO PROFESIONES VALUES (30, 'Policia');
INSERT INTO PROFESIONES VALUES (40, 'Bombero');
INSERT INTO PROFESIONES VALUES (50, 'Enfermero');
INSERT INTO PROFESIONES VALUES (60, 'Arquictecto');
INSERT INTO PROFESIONES VALUES (70, 'Abogado');
INSERT INTO PROFESIONES VALUES (80, 'Contador');
INSERT INTO PROFESIONES VALUES (90, 'Químico');
INSERT INTO PROFESIONES VALUES (100, 'Reportero');
--TIPOS_PRESTAMOS--
INSERT INTO TIPOS_PRESTAMOS VALUES (1, 'Hipoteca', 5);
INSERT INTO TIPOS_PRESTAMOS VALUES (2, 'Personal', 6);
INSERT INTO TIPOS_PRESTAMOS VALUES (3, 'CasaCash', 2);
INSERT INTO TIPOS_PRESTAMOS VALUES (4, 'Auto', 3);
INSERT INTO TIPOS_PRESTAMOS VALUES (5, 'Garantizado con Ahorros', 4);

--PRESTAMOS--
INSERT INTO PRESTAMOS VALUES( 1, 1, TO_DATE('04-05-2021','DD-MM-YYYY'), 60000, 180, 740  );
INSERT INTO PRESTAMOS VALUES( 2, 2, TO_DATE('05-05-2021','DD-MM-YYYY'), 1500, 15, 100  );
INSERT INTO PRESTAMOS VALUES( 3, 3, TO_DATE('06-05-2021','DD-MM-YYYY'), 12000, 9, 1333.33333333333  );
INSERT INTO PRESTAMOS VALUES( 4, 4, TO_DATE('07-05-2021','DD-MM-YYYY'), 6000, 12, 500  );
INSERT INTO PRESTAMOS VALUES( 5, 5, TO_DATE('08-05-2021','DD-MM-YYYY'), 2000, 10, 200  );
INSERT INTO PRESTAMOS VALUES( 6, 6, TO_DATE('09-05-2021','DD-MM-YYYY'), 120000, 192, 625  );
INSERT INTO PRESTAMOS VALUES( 7, 7, TO_DATE('10-05-2021','DD-MM-YYYY'), 5000, 5, 1000  );
INSERT INTO PRESTAMOS VALUES( 8, 8, TO_DATE('11-05-2021','DD-MM-YYYY'), 3000, 11, 272.727272727273  );
INSERT INTO PRESTAMOS VALUES( 9, 9, TO_DATE('12-05-2021','DD-MM-YYYY'), 3500, 8, 437.5  );
INSERT INTO PRESTAMOS VALUES( 10, 10, TO_DATE('13-05-2021','DD-MM-YYYY'), 8000, 20, 400  );
INSERT INTO PRESTAMOS VALUES( 11, 11, TO_DATE('14-05-2021','DD-MM-YYYY'), 2500, 6, 416.666666666667  );
INSERT INTO PRESTAMOS VALUES( 12, 12, TO_DATE('15-05-2021','DD-MM-YYYY'), 1000, 6, 166.666666666667  );
INSERT INTO PRESTAMOS VALUES( 13, 13, TO_DATE('16-05-2021','DD-MM-YYYY'), 9000, 8, 1125  );
INSERT INTO PRESTAMOS VALUES( 14, 14, TO_DATE('17-05-2021','DD-MM-YYYY'), 80000, 180, 444.444444444444  );

--CLIENTES_CORREOS--

--CLIENTES_TELEFONOS---

--CLIENTES_PRESTAMOS--

