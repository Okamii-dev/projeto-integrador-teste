package dao;

import connection.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Produto;
import model.Usuario;

public class ProdutoDAO {

    private ConnectionFactory myConnection = new ConnectionFactory();
    private Connection con;
    private PreparedStatement stmt;
    private ResultSet rs;
    private Produto pro = new Produto();

    public boolean create(Produto produto) {
        boolean right = false;
        con = myConnection.getConnection();
        String sql = "insert into tbproduto(produto, descricao, preco, contato, idusuario) values(?,?,?,?,?)";
        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, produto.getProduto());
            stmt.setString(2, produto.getDescricao());
            stmt.setInt(3, produto.getPreco());
            stmt.setString(4, produto.getContato());
            stmt.setInt(5, produto.getIdusuario());
            stmt.executeUpdate();
            right = true;

        } catch (Exception e) {
            System.out.println("Erro ao tentar inserir novo Produto!" + e);
        } finally {
            myConnection.closeConnection(con, stmt);
        }
        return right;
    }

    public List<Produto> read() {
        con = myConnection.getConnection();
        List produtos = new ArrayList();
        String sql = "select * from tbproduto";
        try {
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                //instanciar um objeto do tipo Aluno
                Produto pro = new Produto();
                //setar as informações obtidas no objeto
                pro.setIdproduto(rs.getInt("idproduto"));
                pro.setProduto(rs.getString("produto"));
                pro.setDescricao(rs.getString("descricao"));
                pro.setPreco(rs.getInt("preco"));
                pro.setContato(rs.getString("contato"));
                pro.setIdusuario(rs.getInt("idusuario"));

                //adicionar o objeto "alu no arraylist
                produtos.add(pro);
            }

        } catch (Exception e) {
            System.out.println("Erro ao tentar listar produtos!" + e);
        } finally {
            myConnection.closeConnection(con, stmt, rs);
        }
        return produtos;
    }

    public boolean update(Produto produto) {
        boolean right = false;
        con = myConnection.getConnection();
        String sql = "update tbproduto set produto=?, descricao=?, preco=?, contato=?, idusuario=? where idproduto=? ";

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, produto.getProduto());
            stmt.setString(2, produto.getDescricao());
            stmt.setInt(3, produto.getPreco());
            stmt.setString(4, produto.getContato());
            stmt.setInt(5, produto.getIdusuario());
            stmt.setInt(6, produto.getIdproduto());
            stmt.executeUpdate();
            right = true;

        } catch (Exception e) {
            System.out.println("Erro ao tentar atualizar produto!" + e);
        } finally {
            myConnection.closeConnection(con, stmt);
        }
        return right;
    }

    public boolean delete(int id) {
        boolean right = false;
        con = myConnection.getConnection();
        String sql = "delete from tbproduto where idproduto=?";
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            right = true;
        } catch (Exception e) {
            System.out.println("Erro ao tentar excluir produto!" + e);
        } finally {
            myConnection.closeConnection(con, stmt);
        }

        return right;
    }

    public List<Produto> listarProduto(int idusuario) {
        con = myConnection.getConnection();
        List produtos = new ArrayList();
        String sql = "select tbproduto.idproduto, tbproduto.produto, tbproduto.descricao, tbproduto.preco, tbproduto.contato, tbproduto.idusuario, tbusuario.idusuario from tbproduto, tbusuario where tbproduto.idusuario = tbusuario.idusuario and tbusuario.idusuario =? ; ";
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, idusuario);
            rs = stmt.executeQuery();
            while (rs.next()) {
                //instanciar um objeto do tipo Aluno
                Usuario usu = new Usuario();
                Produto pro = new Produto();
                //setar as informações obtidas no objeto
                pro.setIdproduto(rs.getInt("idproduto"));
                pro.setProduto(rs.getString("produto"));
                pro.setDescricao(rs.getString("descricao"));
                pro.setPreco(rs.getInt("preco"));
                pro.setContato(rs.getString("contato"));
                pro.setIdusuario(rs.getInt("idusuario"));
                usu.setIdusuario(rs.getInt("idusuario"));

                //adicionar o objeto "alu no arraylist
                produtos.add(pro);
            }

        } catch (Exception e) {
            System.out.println("Erro ao tentar listar produtos!" + e);
        } finally {
            myConnection.closeConnection(con, stmt, rs);
        }
        return produtos;
    }

    public Produto listar_produto(int id) {
        con = myConnection.getConnection();
        Produto produto = new Produto();
        String sql = "select * from tbproduto where idproduto=?";
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            while (rs.next()) {

                produto.setIdproduto(rs.getInt("idproduto"));
                produto.setProduto(rs.getString("produto"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPreco(rs.getInt("preco"));
                produto.setContato(rs.getString("contato"));
                produto.setIdusuario(rs.getInt("idusuario"));

            }

        } catch (Exception e) {
            System.out.println("Erro ao tentar listar produto!" + e);
        } finally {
            myConnection.closeConnection(con, stmt, rs);
        }
        return produto;
    }

}
