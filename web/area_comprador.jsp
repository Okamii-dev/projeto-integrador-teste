<%-- 
    Document   : area_comprador
    Created on : 05/06/2023, 14:08:42
    Author     : sala303b
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!----======== CSS ======== -->
        <link rel="stylesheet" href="styleComprador.css">

        <!----===== Boxicons CSS ===== -->
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>

    </head>
    <body>
        <nav class="sidebar close">
            <header>
                <i class='bx bx-chevron-right toggle' style="background-color: grey;"></i>
            </header>

            <div class="menu-bar">
                <div class="menu">
                    <img src="./image/user.png" style="margin-left: 60px; width: 70px;" > 
                    <span class="text nav-text" style="margin-left: 10px;"> Área do Comprador</span>

                    <li style="margin-top: 100px;">
                        <a href="editar_dados.jsp"">
                            <img src="./image/editar_cadastro.png">
                            <span class="text nav-text">EDITAR CADASTRO</span>
                        </a>
                    </li>
                </div>


                <div class="bottom-content">
                    <li class="">
                        <a href="index.jsp">
                            <i class='bx bx-log-out icon' ></i>
                            <span class="text nav-text">Logout</span>
                        </a>
                    </li>

                    <li class="mode">
                        <div class="sun-moon">
                            <i class='bx bx-moon icon moon'></i>
                            <i class='bx bx-sun icon sun'></i>
                        </div>
                        <span class="mode-text text">Dark mode</span>

                        <div class="toggle-switch">
                            <span class="switch"></span>
                        </div>
                    </li>

                </div>
            </div>

        </nav>

        <!-- listAGEM EM CARD -->

        <%@ page import="dao.ProdutoDAO" %>
        <%@ page import="model.Produto" %>
        <%
            ProdutoDAO produtoDAO = new ProdutoDAO();
            List<Produto> produtos = produtoDAO.read();
        %>
        <section class="articles" style="margin-left: 260px;">
            <% for (Produto produto : produtos) {%>
            <article style="height: 450px; border: 1px solid #1f1204;">
                <div class="article-wrapper">
                    <figure>
                        <img src="https://picsum.photos/id/1011/800/450" alt="" />
                    </figure>
                    <div class="article-body">
                        <div style="margin-bottom: 20px; margin-left: -18px;">
                            <span>Produtos</span>
                            <label > <input value="<%= produto.getProduto()%>"></label>
                        </div>
                        <div style="margin-bottom: 20px; margin-left: -18px;">
                            <span style="margin-top: 2px;">Descrição</span>
                            <input type="text" name="descricao" id="descricao" style="font-size: 12pt; margin-top: 2px; width: 235px;" value="<%= produto.getDescricao()%>">
                        </div>
                        <div style="margin-bottom: 20px; margin-left: -18px;">
                            <span>Valor R$</span>
                            <input type="text" id="valor" readonly name="valor" style="border-radius: 20px; font-size: 12pt; margin-top: 2px; margin-left: 10px; width: 235px;" value="<%= produto.getPreco()%>">
                        </div>
                        <div style="margin-top: 20px; margin-left: -18px;">
                            <span>Contato</span>
                            <input type="tel" id="txtcontato" readonly name="txtcontato" style="border-radius: 20px; font-size: 12pt; margin-top: 2px; margin-left: 16px; width: 235px;" value="<%= produto.getContato()%>">
                        </div>
                    </div>
                </div>
            </article>
            <% }%>
        </section>  
        <!--script-->
        <script>
            const body = document.querySelector('body'),
                    sidebar = body.querySelector('nav'),
                    toggle = body.querySelector(".toggle"),
                    modeSwitch = body.querySelector(".toggle-switch"),
                    modeText = body.querySelector(".mode-text");


            toggle.addEventListener("click", () => {
                sidebar.classList.toggle("close");
            })
            modeSwitch.addEventListener("click", () => {
                body.classList.toggle("dark");

                if (body.classList.contains("dark")) {
                    modeText.innerText = "Light mode";
                } else {
                    modeText.innerText = "Dark mode";

                }
            });
        </script>
    </body>
</html>
