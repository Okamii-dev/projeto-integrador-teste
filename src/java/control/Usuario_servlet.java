/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import com.sun.javafx.event.RedirectedEvent;
import dao.ProdutoDAO;
import dao.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Usuario;

/**
 *
 * @author sala303b
 */
public class Usuario_servlet extends HttpServlet {

    Usuario usuario = new Usuario();
    UsuarioDAO dao = new UsuarioDAO();
    ProdutoDAO daop = new ProdutoDAO();
    Usuario_ctrl ctrl = new Usuario_ctrl();

    String login = "index.jsp";
    String editar = "editar_dados.jsp";
    String sucesso_comprador = "area_comprador.jsp";
    String sucesso_vendedor = "area_vendedor.jsp";
    String erro = "erro.jsp";
    String sucesso = "sucesso.jsp";
    String abrir = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);

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

        // Define utf-8 para não bugar acentuação
        request.setCharacterEncoding("UTF-8");

        String acao = request.getParameter("acao");

        // Proteção contra NULL POINTER EXCEPTION
        if (acao == null) {
            response.getWriter().println("ERRO: O formulário não enviou o parâmetro 'acao'. Verifique o JSP.");
            return; // Para a execução aqui
        }

        HttpSession sessao = request.getSession();

        // Valor padrão caso nada seja selecionado (evita erro no final)
        abrir = erro;

        try {
            // --- LOGAR ---
            if (acao.equals("logar")) {
                String login = request.getParameter("login");
                String senha = request.getParameter("senha");

                usuario.setLogin(login);
                usuario.setSenha(senha);
                usuario = dao.logar(usuario);

                if (usuario.getLogin() != null) {
                    sessao.setAttribute("usuario", usuario);
                    if (usuario.getPermissao()) {
                        abrir = sucesso_vendedor;
                        request.setAttribute("msg", "Bem vindo Vendedor(a) " + login);
                    } else {
                        abrir = sucesso_comprador; // Corrigido: estava chamando vendedor
                        request.setAttribute("msg", "Bem vindo Comprador(a) " + login);
                    }
                } else {
                    abrir = erro;
                    request.setAttribute("msg", "Login ou Senha incorretos!");
                    sessao.removeAttribute("usuario");
                }
            } // --- CADASTRAR ---
            else if (acao.equals("cad_usuario")) {
                usuario = new Usuario(); // Limpa o objeto
                usuario.setNome(request.getParameter("txtNome"));
                usuario.setLogin(request.getParameter("txtLogin"));
                usuario.setSenha(request.getParameter("txtSenha"));
                usuario.setSexo(request.getParameter("txtSexo"));
                usuario.setEmail(request.getParameter("txtEmail"));
                usuario.setTelefone(request.getParameter("txtTelefone"));

                // Tratamento de erro para IDADE vazia
                String idadeTexto = request.getParameter("txtIdade");
                if (idadeTexto != null && !idadeTexto.isEmpty()) {
                    usuario.setIdade(Integer.parseInt(idadeTexto));
                } else {
                    usuario.setIdade(0); // Ou defina um padrão
                }

                boolean vendedor = "on".equals(request.getParameter("op1"));
                usuario.setPermissao(vendedor);

                // Validação do Controller
                if (ctrl.validarDados(usuario)) {
                    if (dao.create(usuario)) {
                        abrir = sucesso;
                        request.setAttribute("msg", "Usuario cadastrado com sucesso!");
                    } else {
                        abrir = erro;
                        request.setAttribute("msg", "Erro no Banco de Dados ao cadastrar!");
                    }
                } else {
                    abrir = erro;
                    request.setAttribute("msg", "Dados inválidos! Verifique os campos (Controller recusou).");
                }
            } // --- ATUALIZAR ---
            else if (acao.equals("atualizar")) {
                // ... (mantenha sua lógica de atualizar aqui se quiser)
            }

        } catch (Exception e) {
            // Captura qualquer erro maluco e mostra no console e na tela
            System.out.println("ERRO CRÍTICO NO SERVLET: " + e);
            e.printStackTrace();
            abrir = erro;
            request.setAttribute("msg", "Erro interno no servidor: " + e.getMessage());
        }

        // Redirecionamento final
        RequestDispatcher visualizar = request.getRequestDispatcher(abrir);
        visualizar.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
