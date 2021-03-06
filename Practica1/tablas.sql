
CREATE TABLE ENTIDAD
(
  ID              NUMBER Generated as Identity ( START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP) NOT NULL,
  TIPO_EMPRESA    NUMBER(2),
  CODIGO_EMPRESA  VARCHAR2(10 BYTE),
  DESC_EMPRESA    VARCHAR2(20 BYTE),
  RNC             VARCHAR2(11 BYTE)
)

CREATE TABLE ARTICULOS(
ID NUMBER(4) GENERATED ALWAYS AS IDENTITY,
ID_EMPRESA NUMBER NOT NULL,
NOMBRE VARCHAR2(32) NOT NULL ,
CATEGORIA VARCHAR2(20) NOT NULL,
FECHA_FABRICACION DATE ,
EXPIRA CHAR(1) DEFAULT 'N',
FECHA_EXPIRACION DATE ,
PRECIO NUMBER(18,6),
CANTIDAD NUMBER,
CONSTRAINT FK_EMPRESA FOREIGN KEY (ID_EMPRESA)REFERENCES ENTIDAD (ID)
);


insert into ENTIDAD(TIPO_EMPRESA,CODIGO_EMPRESA,DESC_EMPRESA,RNC)
VALUES(01,'PLAMA','PLAZA LAMA','12345874102');
insert into ENTIDAD(TIPO_EMPRESA,CODIGO_EMPRESA,DESC_EMPRESA,RNC)
VALUES(01,'TCORRIP','TIENDAS CORRIPIO','12345834102');
insert into ENTIDAD(TIPO_EMPRESA,CODIGO_EMPRESA,DESC_EMPRESA,RNC)
VALUES(01,'LASIRN','LA SIRENA','12345874101');
insert into ENTIDAD(TIPO_EMPRESA,CODIGO_EMPRESA,DESC_EMPRESA,RNC)
VALUES(01,'JUMB','JUMBO','12345874106');
insert into ENTIDAD(TIPO_EMPRESA,CODIGO_EMPRESA,DESC_EMPRESA,RNC)
VALUES(02,'FAMERICA','FERRETERIA AMERICANA','12345879106');
insert into ENTIDAD(TIPO_EMPRESA,CODIGO_EMPRESA,DESC_EMPRESA,RNC)
VALUES(02,'FOCHO','FERRETERIA OCHOA','12345874136');
insert into ENTIDAD(TIPO_EMPRESA,CODIGO_EMPRESA,DESC_EMPRESA,RNC)
VALUES(02,'FPOPU','FERRETERIA POPULAR','12345874116');


INSERT INTO ARTICULOS(ID_EMPRESA,NOMBRE,CATEGORIA,FECHA_FABRICACION,EXPIRA,FECHA_EXPIRACION,PRECIO,CANTIDAD)
VALUES(1,'COLA-COLA','BEBIDAS',SYSDATE,'S',SYSDATE,20.4,60000);
INSERT INTO ARTICULOS(ID_EMPRESA,NOMBRE,CATEGORIA,FECHA_FABRICACION,EXPIRA,FECHA_EXPIRACION,PRECIO,CANTIDAD)
VALUES(1,'PEPSI','BEBIDAS',SYSDATE,'S',SYSDATE,20.4,60000);
INSERT INTO ARTICULOS(ID_EMPRESA,NOMBRE,CATEGORIA,FECHA_FABRICACION,EXPIRA,FECHA_EXPIRACION,PRECIO,CANTIDAD)
VALUES(3,'SALAMI','EMBUTIDOS',SYSDATE,'S',SYSDATE,150,6000);
INSERT INTO ARTICULOS(ID_EMPRESA,NOMBRE,CATEGORIA,FECHA_FABRICACION,EXPIRA,FECHA_EXPIRACION,PRECIO,CANTIDAD)
VALUES(2,'CHULETA','EMBUTIDOS',SYSDATE,'S',SYSDATE,60,3000);
INSERT INTO ARTICULOS(ID_EMPRESA,NOMBRE,CATEGORIA,FECHA_FABRICACION,EXPIRA,PRECIO,CANTIDAD)
VALUES(5,'SAMSUNG TV','ELECTRODOMESTICOS',SYSDATE,'N',150,6000);
INSERT INTO ARTICULOS(ID_EMPRESA,NOMBRE,CATEGORIA,FECHA_FABRICACION,EXPIRA,PRECIO,CANTIDAD)
VALUES(6,'IPHONE','TELEFONO',SYSDATE,'N',150,6000);

SELECT* FROM ENTIDAD