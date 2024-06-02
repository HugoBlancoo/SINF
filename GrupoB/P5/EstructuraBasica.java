package P5;

import java.sql.Connection;
import java.sql.DriverManager;

public class EstructuraBasica {
    public static void main(String[] args) {
        //Cargamos el controlador JDBC
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch(Exception e){
            e.printStackTrace();
        }
        
        //Establecemos la conexión:
        Connection connection = null;
        try{
            String url = "jdbc:mysql://localhost:3306/";
            String usuario = "usuario";
            String pswd = "pswd";
            connection = DriverManager.getConnection(url, usuario, pswd);
            System.out.println("Conexión exitosa");
        }catch(Exception e){
            e.printStackTrace();
        } 
        finally{
            //Siempre debemos cerrar la conexión
            if (connection != null){
                try{
                    connection.close();
                }catch(Exception e){
                    e.printStackTrace();
                }
            }
        }
    }
}
