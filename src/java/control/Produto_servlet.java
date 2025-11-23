package control;

import dao.ProdutoDAO;
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
import model.Produto;
import model.Usuario;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet(name = "Produto_servlet", urlPatterns = {"/Produto"})
public class Produto_servlet extends HttpServlet {

    Produto produto = new Produto();
    ProdutoDAO dao = new ProdutoDAO();
    Produto_ctrl ctrl = new Produto_ctrl();

    // Destinos
    String areaVendedor = "area_vendedor.jsp";
    String editar = "editar_produto.jsp";
    String erro = "erro.jsp";
    String abrir = "";

    // Método auxiliar para salvar foto
    private String salvarFoto(Part filePart, HttpServletRequest request) {
        if (filePart != null && filePart.getSize() > 0) {
            try {
                String nomeArquivoOriginal = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Gera um nome único para evitar sobreposição (ex: tomate.jpg vira 12345-tomate.jpg)
                String nomeUnico = UUID.randomUUID().toString() + "_" + nomeArquivoOriginal;
                
                // Caminho real onde o servidor está rodando
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads";
                
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir(); // Cria pasta se não existir

                // Salva o arquivo
                filePart.write(uploadPath + File.separator + nomeUnico);
                return nomeUnico; // Retorna só o nome para salvar no banco
            } catch (IOException e) {
                System.out.println("Erro ao salvar arquivo: " + e.getMessage());
            }
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // MANTENHA SEU DOGET IGUAL AO ANTERIOR (Logar, Listar, Excluir...)
        // Vou resumir aqui para focar no POST, mas use o que te mandei antes
        
        String acao = request.getParameter("acao");
        if (acao != null && acao.equals("editar")) {
             int id = Integer.parseInt(request.getParameter("id"));
             request.setAttribute("produto", dao.listar_produto(id));
             request.getRequestDispatcher(editar).forward(request, response);
             return;
        } else if (acao != null && acao.equals("excluir")) {
             int id = Integer.parseInt(request.getParameter("idproduto"));
             dao.delete(id);
             request.getRequestDispatcher(areaVendedor).forward(request, response);
             return;
        }
        response.sendRedirect(areaVendedor);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");

        // --- CADASTRAR PRODUTO ---
        if ("cad_produto".equals(acao)) {
            produto = new Produto();
            produto.setProduto(request.getParameter("txtProduto"));
            produto.setDescricao(request.getParameter("txtDescricao"));
            produto.setContato(request.getParameter("txtContato"));
            
            try {
                String precoStr = request.getParameter("txtPreco").replace(",", ".");
                produto.setPreco((int) Double.parseDouble(precoStr));
                produto.setIdusuario(Integer.parseInt(request.getParameter("idusuario")));
            } catch (Exception e) { produto.setPreco(0); }

            // --- UPLOAD DE FOTO ---
            Part filePart = request.getPart("foto"); // Pega o input type="file"
            String nomeFoto = salvarFoto(filePart, request);
            produto.setImagem(nomeFoto); // Salva o nome no objeto

            if (dao.create(produto)) {
                request.setAttribute("msg", "Produto cadastrado com foto!");
            } else {
                request.setAttribute("msg", "Erro ao cadastrar.");
            }
            abrir = areaVendedor;

        // --- ATUALIZAR PRODUTO ---
        } else if ("atualizar".equals(acao)) {
            produto = new Produto();
            produto.setIdproduto(Integer.parseInt(request.getParameter("idproduto")));
            produto.setProduto(request.getParameter("txtNome"));
            produto.setDescricao(request.getParameter("txtDescricao"));
            produto.setContato(request.getParameter("txtContato"));
            
            try {
                String precoStr = request.getParameter("txtPreco").replace(",", ".");
                produto.setPreco((int) Double.parseDouble(precoStr));
            } catch (Exception e) { }

            // --- UPLOAD DE FOTO NA EDIÇÃO ---
            Part filePart = request.getPart("foto");
            String nomeFoto = salvarFoto(filePart, request);
            
            // Se veio foto nova, salva. Se não, deixa null (a DAO vai tratar para não apagar a antiga)
            if (nomeFoto != null) {
                produto.setImagem(nomeFoto);
            }

            if (dao.update(produto)) {
                request.setAttribute("msg", "Produto atualizado!");
            } else {
                request.setAttribute("msg", "Erro ao atualizar.");
            }
            abrir = areaVendedor;
        }

        RequestDispatcher visualizar = request.getRequestDispatcher(abrir);
        visualizar.forward(request, response);
    }
}