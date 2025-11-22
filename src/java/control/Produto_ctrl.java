package control;

import dao.ProdutoDAO;
import java.util.List;
import model.Produto;

public class Produto_ctrl {

    public List<Produto> select_all() {
        ProdutoDAO dao = new ProdutoDAO();
        return dao.read();
    }

    public boolean validarDados(Produto produto) {
        System.out.println("produto " +produto.getProduto());
        System.out.println("descricao " +produto.getDescricao());
        System.out.println("preco " +produto.getPreco());
        System.out.println("contato " +produto.getContato());
        System.out.println("idUsuario " +produto.getIdusuario());
        System.out.println("Cheguei no validar");
    return produto.getProduto() != null && !produto.getProduto().isEmpty()
            && produto.getDescricao() != null && !produto.getDescricao().isEmpty()
            && produto.getContato() != null && !produto.getContato().isEmpty()
            && produto.getIdusuario() > 0
            && produto.getPreco() > 0;
}

    public boolean salvarDados(Produto pro) {
        boolean resp = false;

        if (validarDados(pro)) {
            ProdutoDAO dao = new ProdutoDAO();

            if (pro.getIdproduto() != 0) {

                resp = dao.update(pro);

            } else {
                resp = dao.create(pro);

            }
        }
        return resp;
    }

    public boolean delete(int id) {
        ProdutoDAO dao = new ProdutoDAO();
        return dao.delete(id);
    }

}
