/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
    private Connection con;
    private PreparedStatement stmt;
    private ResultSet rs;
    private Usuario usu = new Usuario();

    //CREATE
    public boolean create(Usuario usuario) {
        boolean right = false;
        con = myConnection.getConnection();
        String sql = "insert into tbusuario (nome, login, senha, idade, sexo, email, telefone, permissao) values (?,?,?,?,?,?,?,?)";
        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getLogin());
            stmt.setString(3, usuario.getSenha());
            stmt.setInt(4, usuario.getIdade());
            stmt.setString(5, usuario.getSexo());
            stmt.setString(6, usuario.getEmail());
            stmt.setString(7, usuario.getTelefone());
            stmt.setBoolean(8, usuario.getPermissao());
            stmt.executeUpdate();
            right = true;

        } catch (Exception e) {
            System.out.println("Erro ao tentar inserir novo Usuario!" + e);
        } finally {
            myConnection.closeConnection(con, stmt);
        }
        return right;
    }

    //LOGIN
    public Usuario logar(Usuario usuario) {

        Usuario usua = new Usuario();
        con = myConnection.getConnection();
        String sql = "select * from tbusuario where login=? and senha=?";
        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, usuario.getLogin());
            stmt.setString(2, usuario.getSenha());
            rs = stmt.executeQuery();
            while (rs.next()) {
                usua.setIdusuario(rs.getInt("idusuario"));
                usua.setNome(rs.getString("nome"));
                usua.setLogin(rs.getString("login"));
                usua.setSenha(rs.getString("senha"));
                usua.setIdade(rs.getInt("idade"));
                usua.setSexo(rs.getString("sexo"));
                usua.setEmail(rs.getString("email"));
                usua.setTelefone(rs.getString("telefone"));
                usua.setPermissao(rs.getBoolean("permissao"));
            }

            // Chamada do método para obter o ID do cliente logado
            int idusuario = obterIdUsuarioLogado(usuario);
            usua.setIdusuario(idusuario);

        } catch (Exception e) {
            System.out.println("Erro ao tentar LOGAR!" + e);
        } finally {
            myConnection.closeConnection(con, stmt, rs);
        }
        return usua;
    }
    
    private int idUsuarioObtido;

public int obterIdUsuarioLogado(Usuario usuario) {
    con = myConnection.getConnection();
    String sql = "SELECT idusuario FROM tbusuario WHERE login=?";
    int idusuario = 0;
    try {
        stmt = con.prepareStatement(sql);
        stmt.setString(1, usuario.getLogin());
        rs = stmt.executeQuery();
        if (rs.next()) {
            System.out.println("o id é  no obter" + idusuario);
            idusuario = rs.getInt("idusuario");
         
            idUsuarioObtido = idusuario; // Atribui o valor a variável de instância
        }
    } catch (Exception e) {
        System.out.println("Erro ao obter o ID do cliente logado: " + e);
    } finally {
        myConnection.closeConnection(con, stmt, rs);
    }
    return idusuario;
}
    
    
    //READ
    public List<Usuario> read() {
        con = myConnection.getConnection();
        List usuarios = new ArrayList();
        String sql = "select * from tbusuario";
        try {
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                //instanciar um objeto do tipo Aluno
                Usuario usu = new Usuario();
                //setar as informações obtidas no objeto               
                usu.setIdusuario(rs.getInt("idusuario"));
                usu.setNome(rs.getString("nome"));
                usu.setLogin(rs.getString("login"));
                usu.setSenha(rs.getString("senha"));
                usu.setIdade(rs.getInt("idade"));
                usu.setSexo(rs.getString("sexo"));
                usu.setEmail(rs.getString("email"));
                usu.setPermissao(rs.getBoolean("permissao"));
                //adicionar o objeto "alu no arraylist
                usuarios.add(usu);
            }

        } catch (Exception e) {
            System.out.println("Erro ao tentar listar usuarios!" + e);
        } finally {
            myConnection.closeConnection(con, stmt, rs);
        }
        return usuarios;
    }

    //UPDATE
    public boolean update(Usuario usuario) {
        boolean right = false;
        con = myConnection.getConnection();
        String sql = "update tbusuario set nome=?, login=?, senha=?, idade=?, email=?, telefone=? where idusuario=?";

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getLogin());
            stmt.setString(3, usuario.getSenha());
            stmt.setInt(4, usuario.getIdade());
            stmt.setString(5, usuario.getEmail());
            stmt.setString(6, usuario.getTelefone());
            stmt.setInt(7, usuario.getIdusuario());
            stmt.executeUpdate();
            right = true;

        } catch (Exception e) {
            System.out.println("Erro ao tentar atualizar dados do usuario!" + e);
        } finally {
            myConnection.closeConnection(con, stmt);
        }
        return right;
    }

    //DELETE
    public boolean delete(int id) {
        boolean right = false;
        con = myConnection.getConnection();
        String sql = "delete from aluno where idusuario=?";
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            right = true;
        } catch (Exception e) {
            System.out.println("Erro ao tentar excluir usuario!" + e);
        } finally {
            myConnection.closeConnection(con, stmt);
        }

        return right;
    }

    //LISTE ESPECIFICO
    public Usuario listar_usuario(int id) {
        con = myConnection.getConnection();
        Usuario usu = new Usuario();
        String sql = "select * from tbusuario where idusuario=?";
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            while (rs.next()) {

                usu.setIdusuario(rs.getInt("idusuario"));
                usu.setNome(rs.getString("nome"));
                usu.setLogin(rs.getString("login"));
                usu.setSenha(rs.getString("senha"));
                usu.setIdade(rs.getInt("idade"));
                usu.setSexo(rs.getString("sexo"));
                usu.setEmail(rs.getString("email"));
                usu.setPermissao(rs.getBoolean("permissao"));
            }

        } catch (Exception e) {
            System.out.println("Erro ao tentar listar usuario!" + e);
        } finally {
            myConnection.closeConnection(con, stmt, rs);
        }
        return usu;
    }

}
