package P5;

import java.sql.*;

public class Ej3 {
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
            //System.out.println("Conexión exitosa");
            createSchema(connection);
            showTables(connection);
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

    private static void createSchema(Connection connection) throws SQLException{
        //Creamos las tablas
        String createActores = "create table if not exists Actores ("+
                                "ID_actor int not null primary key auto_increment,"+
                                "Nombre_actor varchar(50) not null,"+
                                "Edad int not null check (Edad >= 0 AND Edad <= 120),"+
                                "Nacionalidad varchar(20) not null,"+
                                "IMDb int unique );"
                                ;
        
        String createDirectores = "create table if not exists Directores ("+
                                    "ID_director int not null primary key auto_increment,"+
                                    "Nombre_director varchar(50) not null,"+
                                    "Edad int not null check (Edad >= 0 AND Edad <= 120),"+
                                    "Nacionalidad varchar(20) not null,"+
                                    "IMDb int unique );"
                                    ;
        String createPeliculas = "create table if not exists Peliculas (" +
                                    "ID_pelicula int not null primary key auto_increment,"+
                                    "Titulo_pelicula varchar(50) not null,"+
                                    "ID_director int not null,"+
                                    "Nacionalidad varchar(20) not null,"+
                                    "IMDb int unique," +
                                    "FOREIGN KEY (ID_director) REFERENCES Directores(ID_director) );";
        String createActuaEn = "create table if not exists actuaEn (" +
                                "ID_actor int not null," +
                                "ID_pelicula int not null," +
                                "foreign key (ID_actor) references Actores(ID_actor)," +
                                "foreign key (ID_pelicula) references Peliculas(ID_pelicula) );";

        try(Statement statement = connection.createStatement())  {
            statement.execute(createActores);
            statement.execute(createDirectores);
            statement.execute(createPeliculas);
            statement.execute(createActuaEn);

            System.out.println("*****************************");
            System.out.println("Tablas creada con éxito");
            System.out.println("*****************************\n");
        }catch(Exception e){
            e.printStackTrace();
        } 
    }
    public static void showTables(Connection conn){
        String sqlSelect = "SHOW TABLES";
        try (PreparedStatement pstmt = conn.prepareStatement(sqlSelect);
                 ResultSet rs = pstmt.executeQuery()) {
                System.out.println("*****************************");
                System.out.println("Tablas en la base de datos:\n");
                while (rs.next()) {
                    System.out.println(rs.getString(1)); // El nombre de la tabla está en la primera columna
                }
                System.out.println("*****************************\n");
            } catch (SQLException e) {
                e.printStackTrace();
            }
    }
}
