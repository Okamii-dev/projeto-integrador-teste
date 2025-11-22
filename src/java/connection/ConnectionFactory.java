package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionFactory {

    // MUDANÇA 1: Usar o driver mais moderno (com .cj. no meio) para evitar avisos
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // MUDANÇA 2: O endereço CORRETO do banco local
    // ATENÇÃO: Troque 'NOME_DO_SEU_BANCO' pelo nome exato que você criou no MySQL
    private static String URL = "jdbc:mysql://localhost:3306/user2?useTimezone=true&serverTimezone=UTC";
    
    // MUDANÇA 3: Usuário padrão do MySQL geralmente é 'root'
    private static String USER = "root";
    
    // MUDANÇA 4: A senha que você definiu ao instalar o MySQL. 
    // Se não tem senha, deixe as aspas vazias: ""
    private static String PASS = "1234"; 

    public static Connection getConnection() {
        try {
            Class.forName(DRIVER);
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException("erro ao tentar conectar Banco de Dados! " + e);
        }
    }

    // ... o resto dos métodos closeConnection continuam iguais ...
    public static void closeConnection(Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (Exception e) {
                System.out.println("Erro ao tentar fechar a conexão" + e);
            }
        }
    }

    public static void closeConnection(Connection con, PreparedStatement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (Exception e) {
                System.out.println("Erro ao tentar fechar Statement" + e);
            } finally {
                closeConnection(con);
            }
        }
    }

    public static void closeConnection(Connection con, PreparedStatement stmt, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
                System.out.println("Erro ao tentar fechar ResultSet" + e);
            } finally {
                closeConnection(con, stmt);
            }
        }
    }
}