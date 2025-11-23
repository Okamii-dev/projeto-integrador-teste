<%-- 
    Document   : area_comprador
    Created on : 05/06/2023, 14:08:42
    Author     : sala303b
--%>

<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page import="model.Produto"%>
<%@page import="dao.ProdutoDAO"%>
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
    
    ProdutoDAO produtoDAO = new ProdutoDAO();
    List<Produto> produtos = produtoDAO.read();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Área do Comprador</title>
        <link rel="stylesheet" href="styleComprador.css">
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <body>
        
        <nav class="sidebar close">
            <header>
                <div class="image-text">
                    <span class="image"><i class='bx bxs-leaf' style="font-size: 30px; color: #fff;"></i></span>
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
                                // CAMINHO ABSOLUTO PARA FOTO DE PERFIL
                                caminhoFoto = "/uploads/" + foto; 
                            } else {
                                caminhoFoto = "image/user.png";
                            }
                        %>
                        
                        <!-- DEBUG VISUAL REMOVIDO -->

                        <img src="<%= caminhoFoto %>" 
                             style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 2px solid #fff;"> 
                        
                        <span class="text nav-text" style="display:block; font-size: 14px;">Olá, <b>${usuarioLogado.nome}</b></span>
                    </div>
                    <ul class="menu-links">
                        <li class="nav-link">
                            <a href="editar_dados.jsp">
                                <i class='bx bx-user icon' ></i>
                                <span class="text nav-text">Meus Dados</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="bottom-content">
                    <li><a href="index.jsp"><i class='bx bx-log-out icon' ></i><span class="text nav-text">Sair</span></a></li>
                </div>
            </div>
        </nav>

        <section class="home">
            <div class="text">Produtos Disponíveis</div>

            <div class="product-grid">
                <% if (produtos.isEmpty()) { %>
                    <div class="empty-state">
                        <i class='bx bx-basket' style="font-size: 50px; color: #ccc;"></i>
                        <p>Nenhum produto fresquinho no momento.</p>
                    </div>
                <% } else { 
                    for (Produto p : produtos) { 
                        String imgPath;
                        if (p.getImagem() != null && !p.getImagem().isEmpty()) {
                            // CORREÇÃO: Usando caminho absoluto para as imagens do produto
                            imgPath = "/uploads/" + p.getImagem(); 
                        } else {
                            imgPath = "https://placehold.co/300x200/e8f5e9/1b5e20?text=Sem+Foto"; 
                        }
                %>
                
                <div class="card" onclick="abrirDetalhes(this)"
                    data-nome="<%= p.getProduto() %>"
                    data-desc="<%= p.getDescricao() %>"
                    data-preco="<%= p.getPreco() %>"
                    data-contato="<%= p.getContato() %>"
                    data-img="<%= imgPath %>">
                    
                    <div class="card-image">
                        <span class="card-badge">R$ <%= p.getPreco() %></span>
                        <img src="<%= imgPath %>" alt="Produto">
                    </div>
                    
                    <div class="card-body">
                        <h3><%= p.getProduto() %></h3>
                        <p class="desc"><%= p.getDescricao() %></p>
                        <div class="contact-box">
                            <i class='bx bxs-phone' ></i>
                            <span>Contato: <strong><%= p.getContato() %></strong></span>
                        </div>
                    </div>
                </div>
                
                <%  } 
                    } %>
            </div>
        </section>

        <!-- Modais e Scripts omitidos para brevidade (mantendo o código idêntico ao anterior para o restante) -->
        
        <div class="modal-overlay" id="modalDetalhes">
            <div class="modal-box">
                <i class='bx bx-x close-modal' onclick="fecharModais()"></i>
                
                <div class="modal-img-side">
                    <img id="detalheImg" src="" alt="Detalhe">
                </div>
                
                <div class="modal-info-side">
                    <h2 id="detalheNome">Nome do Produto</h2>
                    <p class="modal-desc" id="detalheDesc">Descrição...</p>
                    <div class="contact-box" style="margin-bottom: 20px; width: fit-content;">
                        <i class='bx bxs-phone'></i> Vendedor: <strong id="detalheContato"></strong>
                    </div>
                    
                    <div class="modal-price">R$ <span id="detalhePreco">0,00</span></div>
                    
                    <button class="btn-buy" onclick="abrirCheckout()">
                        <i class='bx bx-cart'></i> COMPRAR AGORA
                    </button>
                </div>
            </div>
        </div>

        <div class="modal-overlay" id="modalCheckout">
            <div class="checkout-box">
                
                <div class="checkout-summary">
                    <div>
                        <h3>Você está comprando:</h3>
                        <h2 id="checkoutNome">Nome do Produto</h2>
                    </div>
                    
                    <div class="price-tag">
                        <span>Total a Pagar:</span>
                        <strong id="checkoutPreco">R$ 0,00</strong>
                    </div>
                </div>

                <div class="checkout-form">
                    <button class="close-modal-checkout" onclick="fecharModais()">
                        <i class='bx bx-x'></i>
                    </button>

                    <form onsubmit="finalizarCompra(event)">
                        
                        <h4><i class='bx bx-map'></i> Endereço de Entrega</h4>
                        
                        <div class="form-row">
                            <input type="text" placeholder="CEP" style="flex: 0.4;" required>
                            <input type="text" placeholder="Cidade" required>
                            <input type="text" placeholder="UF" style="flex: 0.3;" required>
                        </div>

                        <input type="text" placeholder="Rua / Avenida" class="form-group" required>

                        <div class="form-row form-group">
                            <input type="number" placeholder="Número" style="flex: 0.4;" required>
                            <input type="text" placeholder="Complemento (Apto, Bloco...)">
                        </div>
                        
                        <h4><i class='bx bx-credit-card'></i> Pagamento</h4>
                        
                        <select id="selectPagamento" class="form-group" required>
                            <option value="" disabled selected>Selecione a Forma de Pagamento</option>
                            <option value="pix">PIX (Aprovação Imediata)</option>
                            <option value="credito">Cartão de Crédito</option>
                            <option value="debito">Cartão de Débito</option>
                            <option value="dinheiro">Dinheiro na Entrega</option>
                        </select>

                        <div class="form-row form-group">
                            <input type="text" placeholder="Nome no Cartão">
                            <input type="text" placeholder="CPF" required>
                        </div>

                        <button type="submit" class="btn-buy" style="width: 100%; margin-top: 10px;">
                            CONFIRMAR PEDIDO <i class='bx bx-check'></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            const body = document.querySelector('body'),
            sidebar = body.querySelector('nav'),
            toggle = body.querySelector(".toggle");
            toggle.addEventListener("click", () => { sidebar.classList.toggle("close"); });

            function abrirDetalhes(cardElement) {
                const ds = cardElement.dataset;

                // Preenche Detalhes
                document.getElementById('detalheNome').innerText = ds.nome;
                document.getElementById('detalheDesc').innerText = ds.desc;
                document.getElementById('detalhePreco').innerText = ds.preco; // R$ já está no HTML
                document.getElementById('detalheContato').innerText = ds.contato;
                document.getElementById('detalheImg').src = ds.img;
                
                // Preenche Checkout (Novo)
                document.getElementById('checkoutNome').innerText = ds.nome;
                document.getElementById('checkoutPreco').innerText = "R$ " + ds.preco;

                document.getElementById('modalDetalhes').classList.add('active');
            }

            function abrirCheckout() {
                document.getElementById('modalDetalhes').classList.remove('active');
                document.getElementById('modalCheckout').classList.add('active');
            }

            function fecharModais() {
                document.getElementById('modalDetalhes').classList.remove('active');
                document.getElementById('modalCheckout').classList.remove('active');
            }

            function finalizarCompra(event) {
                event.preventDefault();
                fecharModais();
                console.log("Pedido realizado com sucesso!"); 
            }
        </script>

        <jsp:include page="chat_widget.jsp" />

    </body>
</html>