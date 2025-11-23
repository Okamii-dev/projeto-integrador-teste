<%-- 
    Document   : area_vendedor
    Created on : 05/06/2023, 14:07:04
    Author     : sala303b
--%>

<%@page import="java.util.List"%>
<%@page import="model.Produto"%>
<%@page import="dao.ProdutoDAO"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
    if (usuarioLogado == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    // Coloca o objeto UsuarioLogado no escopo de requisição para JSTL/EL
    request.setAttribute("usuarioLogado", usuarioLogado); 

    // --- Lógica mais robusta para obter o ID do usuário (retornada) ---
    int idUsuario = 0;
    if (usuarioLogado.getIdusuario() != null) {
        idUsuario = usuarioLogado.getIdusuario(); // Unboxing seguro
    }
    
    if (idUsuario == 0) {
        response.sendRedirect("index.jsp");
        return;
    }

    ProdutoDAO pDao = new ProdutoDAO();
    // Lista produtos usando o ID seguro
    List<Produto> listaProdutos = pDao.listarProdutoPorUsuario(idUsuario);
    // ------------------------------------------------------------------
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Área do Produtor - Alimentação Consciente</title>
        <link rel="stylesheet" href="styleVendedor.css">
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <body>

        <nav class="sidebar close">
            <header>
                <div class="image-text">
                    <span class="image">
                        <i class='bx bxs-leaf' style="font-size: 30px; color: #fff;"></i>
                    </span>
                    <div class="text logo-text">
                        <span class="name">Alimentação</span>
                        <span class="profession">Consciente</span>
                    </div>
                </div>
                <i class='bx bx-chevron-right toggle'></i>
            </header>

            <div class="menu-bar">
                <div class="menu">
                    <div style="text-align: center; margin-bottom: 20px;">
                        
                        <!-- LÓGICA DE EXIBIÇÃO DA FOTO -->
                        <% 
                            String foto = usuarioLogado.getFoto();
                            String caminhoFoto;
                            if (foto != null && foto.equals("user.png")) {
                                caminhoFoto = "image/user.png";
                            } else if (foto != null && !foto.isEmpty()) {
                                // CORREÇÃO APLICADA: Usando caminho absoluto /uploads/
                                caminhoFoto = "/uploads/" + foto;
                            } else {
                                // Fallback
                                caminhoFoto = "image/user.png";
                            }
                        %>
                        <img src="<%= caminhoFoto %>" 
                             style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 2px solid #fff;"> 
                        <!-- FIM DA CORREÇÃO -->

                        <span class="text nav-text" style="display:block; font-size: 14px;">Olá, <b>${usuarioLogado.nome}</b></span>
                    </div>

                    <ul class="menu-links">
                        <li class="nav-link">
                            <a href="editar_dados.jsp">
                                <i class='bx bx-user icon' ></i>
                                <span class="text nav-text">Meus Dados</span>
                            </a>
                        </li>
                        <li class="nav-link">
                            <a href="cadastro_produto.jsp">
                                <i class='bx bx-plus-circle icon' ></i>
                                <span class="text nav-text">Novo Produto</span>
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="bottom-content">
                    <li>
                        <a href="index.jsp">
                            <i class='bx bx-log-out icon' ></i>
                            <span class="text nav-text">Sair</span>
                        </a>
                    </li>
                </div>
            </div>
        </nav>

        <section class="home">
            <div class="text">Meus Produtos</div>

            <c:if test="${not empty msg}">
                <div class="msg-sucesso">${msg}</div>
            </c:if>

            <div class="product-grid">

                <% if (listaProdutos.isEmpty()) { %>
                    <div style="grid-column: 1/-1; text-align: center; margin-top: 50px; color: #666;">
                        <i class='bx bx-basket' style="font-size: 40px;"></i>
                        <p>Você ainda não tem produtos cadastrados.</p>
                        <a href="cadastro_produto.jsp" style="color: var(--btn-green); font-weight: bold;">Cadastrar Agora</a>
                    </div>
                <% } else {
                    for (Produto p : listaProdutos) {%>

                <div class="card">
                    
                    <div class="card-image">
                        <% 
                            String nomeImagem = p.getImagem();
                            if (nomeImagem != null && !nomeImagem.isEmpty()) { 
                        %>
                            <!-- CORREÇÃO APLICADA: Usando caminho absoluto /uploads/ -->
                            <img src="/uploads/<%= nomeImagem %>" alt="Foto do produto" style="width: 100%; height: 100%; object-fit: cover;">
                        <% } else { %>
                            <img src="https://via.placeholder.com/300x200/e8f5e9/1b5e20?text=Sem+Foto" alt="Sem foto" style="width: 100%; height: 100%; object-fit: cover;">
                        <% } %>
                    </div>

                    <div class="card-body">
                        <h3><%= p.getProduto()%></h3>
                        <p class="desc"><%= p.getDescricao()%></p>
                        <p class="price">R$ <%= p.getPreco()%></p>
                        <p class="contact"><small>Contato: <%= p.getContato()%></small></p>
                    </div>

                    <div class="card-footer">
                        <a href="Produto?acao=editar&id=<%= p.getIdproduto()%>" class="btn-card btn-edit">editar</a>
                        <a href="Produto?acao=excluir&idproduto=<%= p.getIdproduto()%>" class="btn-card btn-delete">excluir</a> 
                    </div>
                </div>

                <%  }
                    }%>

            </div>
        </section>

        <script>
            const body = document.querySelector('body'),
            sidebar = body.querySelector('nav'),
            toggle = body.querySelector(".toggle");

            toggle.addEventListener("click", () => {
                sidebar.classList.toggle("close");
            })
        </script>
        
        <jsp:include page="chat_widget.jsp" />
    </body>
</html>