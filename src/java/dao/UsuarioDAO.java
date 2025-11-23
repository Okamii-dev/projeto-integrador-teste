package dao;

import connection.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Usuario;

public class UsuarioDAO {

    private ConnectionFactory myConnection = new ConnectionFactory();

    // --- CREATE (Com log de erro detalhado) ---
    public boolean create(Usuario usuario) {
        boolean right = false;
        Connection con = null;
        PreparedStatement stmt = null;
        
        // Coluna 'foto' está corretamente incluída aqui
        String sql = "insert into tbusuario (nome, login, senha, idade, sexo, email, telefone, permissao, foto) values (?,?,?,?,?,?,?,?,?)";
        
        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getLogin());
            stmt.setString(3, usuario.getSenha());
            stmt.setInt(4, usuario.getIdade());
            stmt.setString(5, usuario.getSexo());
            stmt.setString(6, usuario.getEmail());
            stmt.setString(7, usuario.getTelefone());
            stmt.setBoolean(8, usuario.getPermissao());
            
            // Parâmetro 'foto' está corretamente ligado aqui
            stmt.setString(9, usuario.getFoto()); 
            
            stmt.executeUpdate();
            right = true;

        } catch (Exception e) {
            // ADICIONADO PRINT STACK TRACE AQUI para mostrar o erro de SQL (se houver)
            System.out.println("Erro ao tentar inserir novo Usuario: " + e);
            e.printStackTrace(); 
        } finally {
            myConnection.closeConnection(con, stmt);
        }
        return right;
    }

    // --- LOGIN ---
    public Usuario logar(Usuario usuario) {
        Usuario usua = new Usuario();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        String sql = "select * from tbusuario where login=? and senha=?";
        
        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, usuario.getLogin());
            stmt.setString(2, usuario.getSenha());
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                usua.setIdusuario(rs.getInt("idusuario"));
                usua.setNome(rs.getString("nome"));
                usua.setLogin(rs.getString("login"));
                usua.setSenha(rs.getString("senha"));
                usua.setIdade(rs.getInt("idade"));
                usua.setSexo(rs.getString("sexo"));
                usua.setEmail(rs.getString("email"));
                usua.setTelefone(rs.getString("telefone"));
                usua.setPermissao(rs.getBoolean("permissao"));
                
                // RECUPERA A FOTO DO BANCO
                usua.setFoto(rs.getString("foto")); 
            }

        } catch (Exception e) {
            System.out.println("Erro ao tentar LOGAR: " + e);
        } finally {
            myConnection.closeConnection(con, stmt, rs);
        }
        return usua;
    }
    
    // --- UPDATE ---
    public boolean update(Usuario usuario) {
        boolean right = false;
        Connection con = null;
        PreparedStatement stmt = null;
        
        String sql = "";
        
        boolean trocouFoto = (usuario.getFoto() != null && !usuario.getFoto().isEmpty() && !usuario.getFoto().equals("user.png")); // Ajuste na condição

        if (trocouFoto) {
            // Atualiza tudo, inclusive a foto
            sql = "update tbusuario set nome=?, login=?, senha=?, idade=?, email=?, telefone=?, sexo=?, foto=? where idusuario=?";
        } else {
            // Mantém a foto antiga (não mexe na coluna foto)
            sql = "update tbusuario set nome=?, login=?, senha=?, idade=?, email=?, telefone=?, sexo=? where idusuario=?";
        }

        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getLogin());
            stmt.setString(3, usuario.getSenha());
            stmt.setInt(4, usuario.getIdade());
            stmt.setString(5, usuario.getEmail());
            stmt.setString(6, usuario.getTelefone());
            stmt.setString(7, usuario.getSexo()); 
            
            if (trocouFoto) {
                stmt.setString(8, usuario.getFoto());
                stmt.setInt(9, usuario.getIdusuario());
            } else {
                stmt.setInt(8, usuario.getIdusuario());
            }
            
            stmt.executeUpdate();
            right = true;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar usuario: " + e);
        } finally {
            myConnection.closeConnection(con, stmt);
        }
        return right;
    }

    // --- DELETE ---
    public boolean delete(int id) {
        boolean right = false;
        Connection con = null;
        PreparedStatement stmt = null;
        String sql = "delete from tbusuario where idusuario=?"; 
        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            right = true;
        } catch (Exception e) {
            System.out.println("Erro ao tentar excluir usuario: " + e);
        } finally {
            myConnection.closeConnection(con, stmt);
        }
        return right;
    }

    // --- LISTAR (Read) ---
    public List<Usuario> read() {
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "select * from tbusuario";
        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Usuario usu = new Usuario();
                usu.setIdusuario(rs.getInt("idusuario"));
                usu.setNome(rs.getString("nome"));
                usu.setLogin(rs.getString("login"));
                usu.setSenha(rs.getString("senha"));
                usu.setIdade(rs.getInt("idade"));
                usu.setSexo(rs.getString("sexo"));
                usu.setEmail(rs.getString("email"));
                usu.setPermissao(rs.getBoolean("permissao"));
                usu.setFoto(rs.getString("foto")); // Traz a foto na listagem também
                usuarios.add(usu);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar usuarios: " + e);
        } finally {
            myConnection.closeConnection(con, stmt, rs);
        }
        return usuarios;
    }
}