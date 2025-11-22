<%-- 
    Document   : area_vendedor
    Created on : 05/06/2023, 14:07:04
    Author     : sala303b
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!----======== CSS ======== -->
        <link rel="stylesheet" href="styleVendedor.css">

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
                    <img src="./image/user.png" style="margin-left: 80px; width: 70px;" > 
                    <span class="text nav-text" style="margin-left: 50px;">Área Vendedor</span>
                    <ul>
                        <li style="margin-top: 100px;">
                            <a href="editar_dados.jsp">
                                <img src="./image/editar_cadastro.png">
                                <span class="text nav-text">EDITAR CADASTRO</span>
                            </a>
                        </li>
                        <li style="margin-top: 50px;">
                            <a href="cadastro_produto.jsp">
                                <img src="./image/editar_cadastro.png">
                                <span class="text nav-text" >CADASTRO <br>DE PRODUTOS</span>
                            </a>
                        </li>
                    </ul>
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

        <div class="text-center">
            <a href="Produto?acao=listarproduto">
                <button class="btn-primary">
                    listar produtos
                </button>
            </a>            
        </div>

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
