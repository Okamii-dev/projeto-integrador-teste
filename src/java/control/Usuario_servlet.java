package control;

import dao.UsuarioDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Usuario;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 10,      
    maxRequestSize = 1024 * 1024 * 50    
)
@WebServlet(name = "Usuario_servlet", urlPatterns = {"/Usuario_servlet"})
public class Usuario_servlet extends HttpServlet {

    Usuario usuario = new Usuario();
    UsuarioDAO dao = new UsuarioDAO();
    
    String loginPage = "index.jsp";
    String sucesso_comprador = "area_comprador.jsp";
    String sucesso_vendedor = "area_vendedor.jsp";
    String abrir = "";

    private String salvarFoto(Part filePart, HttpServletRequest request) {
        if (filePart != null && filePart.getSize() > 0) {
            try {
                String nomeArquivo = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String nomeUnico = UUID.randomUUID().toString() + "_" + nomeArquivo;
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads";
                
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                filePart.write(uploadPath + File.separator + nomeUnico);
                
                System.out.println("[DEBUG] Foto salva fisicamente em: " + uploadPath + File.separator + nomeUnico);
                return nomeUnico;
            } catch (IOException e) {
                System.out.println("[ERRO] Falha ao salvar arquivo: " + e);
            }
        } else {
            System.out.println("[DEBUG] Nenhum arquivo recebido ou arquivo vazio.");
        }
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");
        
        System.out.println("--- INICIANDO REQUISIÇÃO ---");
        System.out.println("Ação recebida: " + acao);

        if (acao == null) {
            response.getWriter().println("ERRO: Ação não informada.");
            return;
        }

        HttpSession sessao = request.getSession();
        abrir = loginPage;

        try {
            if ("logar".equals(acao)) {
                Usuario uLogar = new Usuario();
                uLogar.setLogin(request.getParameter("login"));
                uLogar.setSenha(request.getParameter("senha"));
                
                uLogar = dao.logar(uLogar);

                // CORREÇÃO: Verifica se getIdusuario() não é nulo antes de comparar com 0
                // Se o login falhou (uLogar.getIdusuario() == null), ele vai para o bloco 'else' abaixo.
                if (uLogar.getIdusuario() != null && uLogar.getIdusuario() > 0) { 
                    sessao.setAttribute("usuario", uLogar); 
                    if (uLogar.getPermissao()) abrir = sucesso_vendedor;
                    else abrir = sucesso_comprador;
                } else {
                    abrir = loginPage;
                    request.setAttribute("msg", "Login ou Senha incorretos!");
                    request.setAttribute("tipo", "erro");
                    sessao.removeAttribute("usuario");
                }
            } 
            
            else if ("cad_usuario".equals(acao)) {
                System.out.println("--- DEBUG CADASTRO INICIO ---");
                
                usuario = new Usuario();
                usuario.setNome(request.getParameter("txtNome"));
                usuario.setLogin(request.getParameter("txtLogin"));
                usuario.setSexo(request.getParameter("txtSexo")); 
                usuario.setEmail(request.getParameter("txtEmail"));
                
                // Debug dos campos básicos
                System.out.println("Nome: " + usuario.getNome());
                System.out.println("Login: " + usuario.getLogin());
                
                // Senha e outros campos
                usuario.setSenha(request.getParameter("txtSenha"));
                usuario.setTelefone(request.getParameter("txtTelefone"));
                try {
                    usuario.setIdade(Integer.parseInt(request.getParameter("txtIdade")));
                } catch (Exception e) { usuario.setIdade(0); }

                String op1 = request.getParameter("op1");
                usuario.setPermissao("on".equals(op1));

                // Lógica de Foto com DEBUG
                Part filePart = request.getPart("foto");
                System.out.println("Part da foto recebido? " + (filePart != null));
                
                String nomeFoto = salvarFoto(filePart, request);
                System.out.println("Nome da foto gerado: " + nomeFoto);

                if (nomeFoto != null) {
                    usuario.setFoto(nomeFoto);
                } else {
                    usuario.setFoto("user.png");
                    System.out.println("Usando foto padrão: user.png");
                }
                
                System.out.println("Objeto Usuario pronto para o DAO. Foto: " + usuario.getFoto());

                // CHAMADA AO DAO
                if (dao.create(usuario)) {
                    System.out.println("DAO retornou TRUE (Sucesso)");
                    abrir = loginPage;
                    request.setAttribute("msg", "Cadastro realizado com sucesso! Faça seu login.");
                    request.setAttribute("tipo", "sucesso");
                } else {
                    System.out.println("DAO retornou FALSE (Erro)");
                    abrir = loginPage;
                    request.setAttribute("msg", "Erro ao gravar. Verifique se o Login já existe.");
                    request.setAttribute("tipo", "erro");
                }
                System.out.println("--- DEBUG CADASTRO FIM ---");
            }
            
            else if ("atualizar".equals(acao)) {
                // ... (código de atualizar mantido similar, pode adicionar logs se precisar depois)
                usuario = new Usuario();
                usuario.setIdusuario(Integer.parseInt(request.getParameter("idusuario")));
                usuario.setNome(request.getParameter("txtNome"));
                usuario.setLogin(request.getParameter("txtLogin"));
                usuario.setSenha(request.getParameter("txtSenha"));
                usuario.setEmail(request.getParameter("txtEmail"));
                usuario.setTelefone(request.getParameter("txtTelefone"));
                usuario.setSexo(request.getParameter("txtSexo"));
                
                try {
                    usuario.setIdade(Integer.parseInt(request.getParameter("txtIdade")));
                } catch (Exception e) { usuario.setIdade(0); }
                
                Part filePart = request.getPart("foto"); 
                String nomeFoto = salvarFoto(filePart, request);
                
                if (nomeFoto != null) {
                    usuario.setFoto(nomeFoto);
                }

                Usuario usuarioSessao = (Usuario) sessao.getAttribute("usuario");
                usuario.setPermissao(usuarioSessao.getPermissao());
                
                if (nomeFoto == null) {
                    usuario.setFoto(usuarioSessao.getFoto());
                }

                if (dao.update(usuario)) {
                    sessao.setAttribute("usuario", usuario); 
                    request.setAttribute("msg", "Perfil atualizado com sucesso!");
                    request.setAttribute("tipo", "sucesso");
                    if (usuario.getPermissao()) abrir = sucesso_vendedor;
                    else abrir = sucesso_comprador;
                } else {
                    request.setAttribute("msg", "Erro ao atualizar dados.");
                    request.setAttribute("tipo", "erro");
                    if (usuario.getPermissao()) abrir = sucesso_vendedor;
                    else abrir = sucesso_comprador;
                }
            }

        } catch (Exception e) {
            System.out.println("ERRO CRÍTICO NO SERVLET: " + e);
            e.printStackTrace();
            abrir = loginPage;
            request.setAttribute("msg", "Erro interno no servidor: " + e.getMessage());
            request.setAttribute("tipo", "erro");
        }

        RequestDispatcher visualizar = request.getRequestDispatcher(abrir);
        visualizar.forward(request, response);
    }
}