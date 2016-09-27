package com.opensource.servlet;

import com.opensource.conexion.OracleConexion;
import oracle.jdbc.OraclePreparedStatement;
import oracle.jdbc.driver.OracleSQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by ezequ on 9/15/2016.
 */
/*Clase para la llamada de procedure que generar archivos 
desde oracle
*/
@WebServlet(name = "ServletCallProcedure")
public class ServletCallProcedure extends HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        OracleConexion conexion = new OracleConexion();

        try {

            /**
             *Llamada al prodecure que genera los archivos de los Articulos)
             * */
             String callProcedure = "{call PROC_GENERA_ARCHIVO_ENTIDADES()}";
           /*Llamada de procedure*/
            OraclePreparedStatement callableStatement = (OraclePreparedStatement) conexion.getConnection().prepareStatement(callProcedure);

            /**
             * Ejecucion del Procedure
             * */
            callableStatement.execute();
            callableStatement.close();

            request.setAttribute("mensaje", "Archivos Generados Correctamente");
            request.getRequestDispatcher("exito.jsp").forward(request, response);

        } catch (OracleSQLException ex) {
            System.out.println(ex.getMessage());
            ex.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        } finally {
            conexion.closeCon();
        }

    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        request.getRequestDispatcher("generar.jsp").forward(request, response);
    }
}
