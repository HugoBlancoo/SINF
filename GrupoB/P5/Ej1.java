package P5;

import java.sql.*;

public class Ej1 {
    public static void main(String[] args) {

        if (args.length != 3){
            System.out.println("Uso: java Ej1 <nombre_bd> <Usuario> <Contraseña>");
            System.exit(-1);
        }

        //Cargamos el controlador JDBC
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch(Exception e){
            e.printStackTrace();
        }
        
        //Establecemos la conexión:
        Connection connection = null;
        try{
            String url = "jdbc:mysql://localhost:3306/" + args[0];
            String usuario = args[1];
            String pswd = args[2];
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
