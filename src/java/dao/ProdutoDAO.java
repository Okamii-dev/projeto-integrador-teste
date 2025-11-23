package dao;

import connection.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Produto;

public class ProdutoDAO {

    private ConnectionFactory myConnection = new ConnectionFactory();

    // --- CREATE (Com Imagem) ---
    public boolean create(Produto produto) {
        boolean right = false;
        Connection con = null;
        PreparedStatement stmt = null;
        
        // Adicionei a coluna 'imagem'
        String sql = "insert into tbproduto(produto, descricao, preco, contato, idusuario, imagem) values(?,?,?,?,?,?)";
        
        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, produto.getProduto());
            stmt.setString(2, produto.getDescricao());
            stmt.setInt(3, produto.getPreco());
            stmt.setString(4, produto.getContato());
            stmt.setInt(5, produto.getIdusuario());
            
            // Se não tiver imagem, salva null ou vazio
            stmt.setString(6, produto.getImagem()); 
            
            stmt.executeUpdate();
            right = true;
        } catch (Exception e) {
            System.out.println("Erro ao inserir Produto: " + e);
            e.printStackTrace();
        } finally {
            myConnection.closeConnection(con, stmt);
        }
        return right;
    }

    // --- READ ---
    public List<Produto> read() {
        List<Produto> produtos = new ArrayList<>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from tbproduto";
        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Produto pro = mapResultSetToProduto(rs);
                produtos.add(pro);
            }
        } catch (Exception e) { System.out.println("Erro read: " + e); } 
        finally { myConnection.closeConnection(con, stmt, rs); }
        return produtos;
    }

    // --- UPDATE (Com Imagem) ---
    public boolean update(Produto produto) {
        boolean right = false;
        Connection con = null;
        PreparedStatement stmt = null;
        
        // Lógica: Só atualiza a imagem SE o usuário enviou uma nova.
        // Se a imagem for nula, mantemos a antiga (não mexemos na coluna imagem).
        String sql = "";
        boolean temImagemNova = (produto.getImagem() != null && !produto.getImagem().isEmpty());

        if (temImagemNova) {
            sql = "update tbproduto set produto=?, descricao=?, preco=?, contato=?, imagem=? where idproduto=?";
        } else {
            sql = "update tbproduto set produto=?, descricao=?, preco=?, contato=? where idproduto=?";
        }

        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, produto.getProduto());
            stmt.setString(2, produto.getDescricao());
            stmt.setInt(3, produto.getPreco());
            stmt.setString(4, produto.getContato());
            
            if (temImagemNova) {
                stmt.setString(5, produto.getImagem());
                stmt.setInt(6, produto.getIdproduto());
            } else {
                stmt.setInt(5, produto.getIdproduto());
            }
            
            stmt.executeUpdate();
            right = true;
        } catch (Exception e) {
            System.out.println("Erro update: " + e);
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
        String sql = "delete from tbproduto where idproduto=?";
        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            right = true;
        } catch (Exception e) { System.out.println("Erro delete: " + e); } 
        finally { myConnection.closeConnection(con, stmt); }
        return right;
    }

    // --- LISTAR POR USUARIO ---
    public List<Produto> listarProdutoPorUsuario(int idusuario) {
        List<Produto> produtos = new ArrayList<>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from tbproduto where idusuario=?";
        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, idusuario);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Produto pro = mapResultSetToProduto(rs);
                produtos.add(pro);
            }
        } catch (Exception e) { System.out.println("Erro listar user: " + e); } 
        finally { myConnection.closeConnection(con, stmt, rs); }
        return produtos;
    }

    // --- LISTAR ESPECIFICO ---
    public Produto listar_produto(int id) {
        Produto produto = new Produto();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from tbproduto where idproduto=?";
        try {
            con = myConnection.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                produto = mapResultSetToProduto(rs);
            }
        } catch (Exception e) { System.out.println("Erro listar um: " + e); } 
        finally { myConnection.closeConnection(con, stmt, rs); }
        return produto;
    }

    // Método auxiliar para evitar repetir código
    private Produto mapResultSetToProduto(ResultSet rs) throws java.sql.SQLException {
        Produto pro = new Produto();
        pro.setIdproduto(rs.getInt("idproduto"));
        pro.setProduto(rs.getString("produto"));
        pro.setDescricao(rs.getString("descricao"));
        pro.setPreco(rs.getInt("preco"));
        pro.setContato(rs.getString("contato"));
        pro.setIdusuario(rs.getInt("idusuario"));
        pro.setImagem(rs.getString("imagem")); // Pega a imagem do banco
        return pro;
    }
}