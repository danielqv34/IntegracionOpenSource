/******************************************************************************
Proceso que genera archivos .txt a partir de una tabla en la base de datos.   *
@Autor :Daniel Quiroz                                                         *
@Fecha :Sep 26, 2016                                                          *
*******************************************************************************/
CREATE OR REPLACE PROCEDURE PROC_GENERA_ARCHIVO_ENTIDADES AS

ENCABEZADO VARCHAR2(1000);
DETALLE VARCHAR2(1000);
SUMARIO VARCHAR2(1000);
NOMBRE_ARCHIVO VARCHAR2(100);
RUTA VARCHAR2(100) := 'PRACTICA_OP';

CURSOR ENTIDAD IS
    SELECT ID,
           TIPO_EMPRESA,
           CODIGO_EMPRESA,
           RNC
    FROM ENTIDAD ENT;

PROCEDURE P_LOCAL_EJECUTA_SENTENCIA (P_QUERY  VARCHAR2,
                                    P_ID_ARCHIVO UTL_FILE.FILE_TYPE ) IS
V_CURSOR              INTEGER;
V_COLUMNA_RETORNO     VARCHAR2(3000);
V_EJECUTAR            INTEGER;

BEGIN
  V_CURSOR  := DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(V_CURSOR, P_QUERY, DBMS_SQL.NATIVE);
  DBMS_SQL.DEFINE_COLUMN(V_CURSOR, 1, V_COLUMNA_RETORNO, 3000);
  V_EJECUTAR := DBMS_SQL.EXECUTE(V_CURSOR);

  LOOP
    EXIT WHEN (DBMS_SQL.FETCH_ROWS(V_CURSOR) <= 0 );
    DBMS_SQL.COLUMN_VALUE(V_CURSOR, 1, V_COLUMNA_RETORNO);
    UTL_FILE.PUT_LINE(P_ID_ARCHIVO, V_COLUMNA_RETORNO);
  END LOOP;

  DBMS_SQL.CLOSE_CURSOR(V_CURSOR);

END  P_LOCAL_EJECUTA_SENTENCIA;

PROCEDURE P_LOCAL_GENERA_ARCHIVO(RUTA IN VARCHAR2,
                                 NOMBRE_ARCHIVO IN VARCHAR2,
                                 ENCABEZADO IN VARCHAR,
                                 DETALLE IN VARCHAR,
                                 SUMARIO IN VARCHAR) IS
                                 
V_ID_ARCHIVO    utl_file.file_type;
V_RUTA_ARCHIVO  VARCHAR2(100);

BEGIN

    IF SUBSTR(RUTA, 1, LENGTH(RUTA)+1 - LENGTH(RUTA) ) = '/' THEN
        V_RUTA_ARCHIVO := SUBSTR(RUTA, 1, LENGTH(RUTA)-1);
    ELSE
        V_RUTA_ARCHIVO := RUTA;
    END IF;

    IF UTL_FILE.IS_OPEN(V_ID_ARCHIVO) THEN
        UTL_FILE.FCLOSE(V_ID_ARCHIVO);
    END IF;

    V_ID_ARCHIVO  := UTL_FILE.FOPEN(V_RUTA_ARCHIVO, NOMBRE_ARCHIVO, 'w');

    IF ENCABEZADO IS NOT NULL THEN
        P_LOCAL_EJECUTA_SENTENCIA(ENCABEZADO, V_ID_ARCHIVO);
    END IF;
    
    IF DETALLE IS NOT NULL THEN
        P_LOCAL_EJECUTA_SENTENCIA(DETALLE, V_ID_ARCHIVO);
    END IF;
    
    IF SUMARIO IS NOT NULL THEN
        P_LOCAL_EJECUTA_SENTENCIA(SUMARIO, V_ID_ARCHIVO);
    END IF;

    UTL_FILE.FCLOSE(V_ID_ARCHIVO);
END;

BEGIN

    FOR ENT IN ENTIDAD LOOP
        
        NOMBRE_ARCHIVO:= 'ARCHIVO_CARGA_ARTICULOS_'||ENT.CODIGO_EMPRESA||'.TXT';
        
        ENCABEZADO := 'SELECT "E"||'||
                        '        LPAD('||ENT.TIPO_EMPRESA||', 2, 0)||'||
                        '        RPAD("'||ENT.CODIGO_EMPRESA||'", 7, " ")||'||
                        '        RPAD("'||ENT.RNC||'", 11, " ")||'||
                        '        RPAD("'||TO_CHAR(SYSDATE, 'DDMMYYYY')||'", 10, " ")'||
                        ' FROM DUAL';
                        
        DETALLE := 'SELECT "D"||'||
                     '       LPAD(ART.ID, 4, 0)|| '||
                     '       RPAD(ART.NOMBRE, 32, " ")|| '||
                     '       RPAD(ART.CATEGORIA, 20, " ")|| '||
                     '       RPAD(TO_CHAR(NVL(ART.FECHA_FABRICACION, SYSDATE), "DDMMYYYY"), 10, " ")|| '||
                     '       ART.EXPIRA|| '||
                     '       RPAD(NVL(TO_CHAR(ART.FECHA_EXPIRACION, "DDMMYYYY")," "), 10, " ")|| '||
                     '       LPAD(ART.PRECIO, 6, "0")|| '||
                     '       LPAD(ART.CANTIDAD, 6, "0") '||
                     ' FROM ARTICULOS ART '||
                     ' WHERE ART.ID_EMPRESA = '||ENT.ID;

        SUMARIO := 'SELECT "S"||LPAD(COUNT(ART.ID) + 2, 10, "0") '||
                     ' FROM ARTICULOS ART '||
                     ' WHERE ART.ID_EMPRESA = '||ENT.ID;
                     
        ENCABEZADO  :=  REPLACE(ENCABEZADO,  '"',  '''');
        DETALLE     :=  REPLACE(DETALLE,     '"',  '''');
        SUMARIO     :=  REPLACE(SUMARIO,     '"',  '''');
        
        P_LOCAL_GENERA_ARCHIVO(RUTA, NOMBRE_ARCHIVO, ENCABEZADO, DETALLE, SUMARIO);
        
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: '||SQLERRM);

END;
/
