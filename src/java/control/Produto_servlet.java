package control;

import dao.ProdutoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Produto;
import model.Usuario;

public class Produto_servlet extends HttpServlet {

    Produto produto = new Produto();
    ProdutoDAO dao = new ProdutoDAO();
    Produto_ctrl ctrl = new Produto_ctrl();

    String login = "index.jsp";
    String editar = "editar_produto.jsp";
    String listar = "listarproduto.jsp";
    String sucesso = "sucesso.jsp";
    String erro = "erro.jsp";
    String abrir = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);

        String acao = request.getParameter("acao");
        HttpSession usuario = request.getSession();
        Usuario usu = new Usuario();
        usu = (Usuario) usuario.getAttribute("usuario");

        if (acao != null) {
            if (acao.equals("listarproduto")) {
                abrir = listar;
                int idusuario = usu.getIdusuario();                
                request.setAttribute("produtos", dao.listarProduto(idusuario));
            
            } else if (acao.equals("editar")) {
                int id = Integer.parseInt(request.getParameter("id"));
                abrir = editar;
                request.setAttribute("produto", dao.listar_produto(id));

            } else if (acao.equals("excluir")) {
                int id = Integer.parseInt(request.getParameter("id"));
                if (dao.delete(id)) {
                    abrir = listar;
                    request.setAttribute("msg", "tudo certo");
                } else {
                    abrir = erro;
                    request.setAttribute("msg", "erro tente novamente");
                }

            }

            RequestDispatcher visualizar = request.getRequestDispatcher(abrir);
            visualizar.forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);

        String acao = request.getParameter("acao");

        if (acao.equals("cad_produto")) {
            produto.setProduto(request.getParameter("txtProduto"));
            produto.setDescricao(request.getParameter("txtDescricao"));
            produto.setPreco(Integer.parseInt(request.getParameter("txtPreco")));
            produto.setContato(request.getParameter("txtContato"));
            produto.setIdusuario(Integer.parseInt(request.getParameter("idusuario")));
            if (ctrl.validarDados(produto)) {
                System.out.println("Cheguei aqui");
                if (dao.create(produto)) {
                    System.out.println("Passei aqui");
                    request.setAttribute("msg", "Eba!!! Produto cadastrado com sucesso!");
                    abrir = listar;
                } else {
                    System.out.println("Passei aqui2");
                    abrir = erro;
                    request.setAttribute("msg", "Ops!!! Erro ao tentar cadastrar produto!");
                }
            } else {
                System.out.println("Passei 6");
                abrir = erro;
                request.setAttribute("msg", "Ops!!! Erro ao tentar validar produto!");
            }
        } else if (acao.equals("atualizar")) {
            Produto produto = new Produto();

            produto.setIdproduto(Integer.parseInt(request.getParameter("idproduto")));
            produto.setProduto(request.getParameter("txtNome"));
            produto.setDescricao(request.getParameter("txtDescricao"));
            produto.setPreco(Integer.parseInt(request.getParameter("txtPreco")));
            produto.setContato(request.getParameter("txtContato"));
            if (dao.update(produto)) {
                System.out.println("Passei aqui3");
                abrir = sucesso;
                request.setAttribute("msg", "Eba!!! produto atualizado com sucesso!");
            } else {
                System.out.println("Passei aqui4");
                abrir = erro;
                request.setAttribute("msg", "Ops!!! Erro ao tentar atualizar produto!");
            }

        }
        RequestDispatcher visualizar = request.getRequestDispatcher(abrir);
        visualizar.forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
