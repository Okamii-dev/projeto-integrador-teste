package connection;

import java.sql.Connection;

public class TesteConexao {
    public static void main(String[] args) {
        try {
            System.out.println("1. Tentando conectar ao banco 'user2'...");
            Connection con = ConnectionFactory.getConnection();
            System.out.println("2. SUCESSO! Conexão aberta.");
            
            // Vamos testar se a tabela existe
            System.out.println("3. Verificando tabela tbusuario...");
            java.sql.PreparedStatement stmt = con.prepareStatement("SELECT count(*) FROM tbusuario");
            java.sql.ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                System.out.println("4. Tabela encontrada! Registros atuais: " + rs.getInt(1));
            }
            
            con.close();
        } catch (Exception e) {
            System.out.println("ERRO GRAVE NA CONEXÃO:");
            e.printStackTrace(); // ISSO VAI NOS DIZER O MOTIVO EXATO
        }
    }
}