package P5;
import java.sql.*;

public class Ej7 {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/misPeliculas";
        String usuario = "Hugo";
        String pswd = "Hugo.23022020";

        try (Connection connection = DriverManager.getConnection(url, usuario, pswd)) {
            String selectQuery = "SELECT ID_pelicula, Titulo_pelicula FROM Peliculas";
            try (PreparedStatement pstmt = connection.prepareStatement(selectQuery);
                 ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int idPelicula = rs.getInt("ID_pelicula");
                    String tituloOriginal = rs.getString("Titulo_pelicula");
                    String tituloCapitalizado = capitalizarTitulo(tituloOriginal);
                    actualizarTitulo(connection, idPelicula, tituloCapitalizado);
                }
                System.out.println("Títulos de películas capitalizados con éxito.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String capitalizarTitulo(String titulo) {
        StringBuilder sb = new StringBuilder();
        String[] palabras = titulo.split("\\s+");
        for (String palabra : palabras) {
            if (!palabra.isEmpty()) {
                sb.append(Character.toUpperCase(palabra.charAt(0))).append(palabra.substring(1)).append(" ");
            }
        }
        return sb.toString().trim();
    }

    private static void actualizarTitulo(Connection connection, int idPelicula, String tituloCapitalizado) throws SQLException {
        String updateQuery = "UPDATE Peliculas SET Titulo_pelicula = ? WHERE ID_pelicula = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(updateQuery)) {
            pstmt.setString(1, tituloCapitalizado);
            pstmt.setInt(2, idPelicula);
            pstmt.executeUpdate();
        }
    }
}
