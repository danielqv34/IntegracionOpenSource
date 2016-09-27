package com.opensource.conexion;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.driver.OracleSQLException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by ezequ on 9/15/2016.
 */
public class OracleConexion {
    private final String url = "jdbc:oracle:thin:@//localhost:1521/SpringCRUD";
    private final String user = "c##dquiroz";
    private final String pass = "abc123";
    private OracleConnection connection = null;

    public OracleConexion() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = (OracleConnection) DriverManager.getConnection(url, user, pass);

        } catch (ClassNotFoundException e) {
            System.out.println("No se encontro la clase para la conexion con ORACLE");
            e.printStackTrace();
        } catch (OracleSQLException e) {
            System.out.println("Error con la conexion a ORACLE");
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void closeCon() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;

            } catch (OracleSQLException e) {
                System.out.println("No se pudo cerrar la conexion: Error ");
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public Connection getConnection() {
        return connection;
    }

}
