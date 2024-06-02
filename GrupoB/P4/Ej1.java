import java.io.*;
import java.sql.*;
import javax.swing.*;
import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//ejercicio 1
public class Ej1 {
    static final String jdbc_driver = "com.mysql.cj.jdbc.Driver";
    static final String db_url = "jdbc:mysql://localhost:3306/Cine";

    static final String user = "Hugo";
    static final String pass = "Hugo.23022020";

    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("connecting to database...");
            conn = DriverManager.getConnection(db_url,user,pass);

            System.out.println("creating statement...");
            stmt = conn.createStatement();
            String sqldata = "use Cine";
            int ok = stmt.executeUpdate(sqldata);

            System.out.println("query ok, "+ok+" row afected ");

            InputStreamReader isr = new InputStreamReader(System.in);
            BufferedReader br = new BufferedReader(isr);
            String cadena = "", table, id, foto;

            while (!cadena.equalsIgnoreCase("3")) {
                System.out.println("\n¿quiere almacenar o recuperar una imagen?\n 1.- almacenar 2.- recuperar 3.- salir\n");
                cadena = br.readLine();
                switch (Integer.parseInt(cadena)) {
                    case 1:
                        System.out.println("\nalmacenar en... (Actores/Directores)\n");
                        table = cadena = br.readLine();
                        System.out.println("\n...con id_Actores/id_Directores = ...\n");
                        id = cadena = br.readLine();
                        System.out.println("\n¿nombre del archivo? (nombre.jpg)\n");
                        foto = cadena = br.readLine();
                        almacenarfoto(conn, table, id, foto);
                        break;
                    case 2:
                        System.out.println("\nrecuperar de... (Actores/Directores)\n");
                        table = cadena = br.readLine();
                        System.out.println("\n...con id_Actores/id_Directores = ...\n");
                        id = cadena = br.readLine();
                        //System.out.println("\n¿nombre que desea ponerle al archivo? (nombre.jpg)\n");
                        //foto = cadena = br.readLine();
                        recuperarimagen(table, id);
                        break;
                    case 3: 
                        System.exit(ok);
                        break;
                }
            }

            stmt.close();
            conn.close();
        }catch(SQLException se){
            se.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try{
                if(stmt!=null)
                    stmt.close();
            }catch(SQLException se2){
            }
            try{
                if(conn!=null)
                    conn.close();
            }catch(SQLException se){
                se.printStackTrace();
            }
        }
        System.out.println("bye!");
    }

    private static void recuperarimagen(String tipo, String idPersona) {
        String sql = "";
        try {
            Connection conn = DriverManager.getConnection(db_url, user, pass);
            PreparedStatement pstmt = null;
            if (tipo.equals("Actores")) {
                sql = "SELECT Foto_Actor FROM Actores WHERE ID_Actor = ?";
            } else if (tipo.equals("Directores")) {
                sql = "SELECT Foto_Director FROM Directores WHERE ID_Director = ?";
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, idPersona);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                InputStream input = rs.getBinaryStream(1);
                if (input != null) {
                    BufferedImage imagenRecuperada = ImageIO.read(input);
                    if (imagenRecuperada != null) {
                        System.out.println("Imagen recuperada con éxito.");
                        // Crear una ventana para mostrar la imagen
                        JFrame frame = new JFrame("Imagen Recuperada");
                        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                        JLabel label = new JLabel(new ImageIcon(imagenRecuperada));
                        frame.getContentPane().add(label, BorderLayout.CENTER);
                        frame.pack();
                        frame.setVisible(true);
                    } else {
                        System.out.println("La imagen recuperada es nula.");
                    }
                } else {
                    System.out.println("La secuencia de entrada de la imagen es nula.");
                }
            } else {
                System.out.println("No se encontraron resultados para el ID proporcionado.");
            }
            pstmt.close();
            conn.close();
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }
    
    


    private static void almacenarfoto(Connection conn, String table, String id, String foto) throws IOException, SQLException {
        //System.out.println(table);
        String sql="";
        if (table.equals("Actores")){
            sql = "update "+table+" set Foto_Actor = (?) where ID_actor = "+id;
        }
        else if (table.equals("Directores")){
            sql = "update "+table+" set Foto_Director = (?) where ID_director = "+id;
        }
        else{
            System.out.println("Error");
        }
        File file = new File(foto);
        FileInputStream is = new FileInputStream(file);
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setBinaryStream(1, is, (int) file.length());
        int ok = pst.executeUpdate();
        System.out.println("query ok, "+ok+" row afected ");
        is.close();
        pst.close();
    }
}

