package P5;

import java.sql.*;
import java.util.Scanner;

public class Ej4 {
    public static void main(String[] args) {

        if (args.length != 3){
            System.out.println("Uso: java Ej1 <nombre_bd> <Usuario> <Contraseña>");
            System.exit(-1);
        }

        Scanner scanner = new Scanner(System.in);

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
            while(true){
                System.out.println("Elige una opción:");
                System.out.println("[1] Crear una tabla");
                System.out.println("[2] Consultar tablas");
                System.out.println("[3] Insertar datos");
                System.out.println("[4] Salir");
                String opcion = scanner.nextLine();
                switch(opcion){
                    case "1":
                        createSchema(connection);
                        break;
                    case "2":
                        showTables(connection);
                        break;
                    case "3":
                        insertData(connection);
                        break;
                    case "4":
                        System.exit(0);
                    default:
                        System.out.println("Entrada incorrecta");
                }
            }            
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
        String createActores = "create table if not exists Actores (" +
            "ID_actor int not null primary key auto_increment," +
            "Nombre_actor varchar(50) not null," +
            "Edad int not null check (Edad >= 0 AND Edad <= 120)," +
            "Nacionalidad varchar(20) not null DEFAULT 'Estadounidense'," +
            "IMDb int unique );";

    String createDirectores = "create table if not exists Directores (" +
            "ID_director int not null primary key auto_increment," +
            "Nombre_director varchar(50) not null," +
            "Edad int not null check (Edad >= 0 AND Edad <= 120)," +
            "Nacionalidad varchar(20) not null DEFAULT 'Estadounidense'," +
            "IMDb int unique );";

    String createPeliculas = "create table if not exists Peliculas (" +
            "ID_pelicula int not null primary key auto_increment," +
            "Titulo_pelicula varchar(50) not null," +
            "ID_director int not null," +
            "Nacionalidad varchar(20) not null DEFAULT 'Estadounidense'," +
            "IMDb int unique," +
            "FOREIGN KEY (ID_director) REFERENCES Directores(ID_director) );";
    String createActuaEn = "create table if not exists actuaEn (" +
            "ID_actor int not null," +
            "ID_pelicula int not null," +
            "foreign key (ID_actor) references Actores(ID_actor)," +
            "foreign key (ID_pelicula) references Peliculas(ID_pelicula) );";

    try (Statement statement = connection.createStatement()) {
        statement.execute(createActores);
        statement.execute(createDirectores); // Corrected table name
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
    public static void insertData (Connection connection){
        String[][] actores = {
            {"Emma Stone", "36", "1297015"},
            {"Ryan Gosling", "44", "0331516"},
            {"Patton Oswalt", "54", "0652663"},
            {"Eddie Murphy", "63", "0000552"},
            {"Timothée Chalamet", "29", "3154303"}
            };

            String insert = "insert into Actores (Nombre_actor, Edad, IMDb) values (?, ?, ?)" ;

            try (PreparedStatement statement = connection.prepareStatement(insert)){
                for (String[] actor : actores) {
                    statement.setString(1, actor[0]);
                    statement.setInt(2, Integer.parseInt(actor[1]));
                    statement.setInt(3, Integer.parseInt(actor[2]));
                    statement.addBatch();
                }
            statement.executeBatch();
            System.out.println("Datos insertados exitosamente.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
}
