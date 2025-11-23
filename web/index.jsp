<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <!-- ============================ -->
        <!-- CONFIGURAÇÕES DO DOCUMENTO   -->
        <!-- ============================ -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">

        <!-- TÍTULO DA PÁGINA -->
        <title>Semeia Produtores - Login</title>    

        <!-- ARQUIVOS DE ESTILO -->
        <link rel="stylesheet" href="stylelogin.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">        
        <!-- Ícones Boxicons -->
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>

        <!-- ESTILOS PARA A FOTO DE PERFIL NO CADASTRO -->
        <style>
            .profile-upload { 
                display: flex; 
                flex-direction: column; 
                align-items: center; 
                margin-bottom: 15px; 
            }
            .profile-img-box { 
                width: 100px; 
                height: 100px; 
                border-radius: 50%; 
                overflow: hidden; 
                border: 3px solid #2d6a4f; 
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
                margin-bottom: 8px; 
                position: relative; 
                background: #fff;
            }
            .profile-img-box img { 
                width: 100%; 
                height: 100%; 
                object-fit: cover; 
            }
            .btn-upload-mini { 
                background: #1b5e20; 
                color: white; 
                padding: 5px 15px; 
                border-radius: 15px; 
                font-size: 12px; 
                cursor: pointer; 
                display: flex; 
                align-items: center; 
                gap: 5px; 
                transition: 0.3s; 
                font-family: sans-serif;
            }
            .btn-upload-mini:hover { 
                background: #2e7d32; 
                transform: scale(1.05); 
            }
        </style>
    </head>

    <body>      

        <!-- ============================ -->
        <!-- CONTAINER PRINCIPAL          -->
        <!-- ============================ -->
        <div class="container">

            <!-- ************************************************************************ -->
            <!-- =====================  SEÇÃO 1 : TELA DE CADASTRO  ===================== -->
            <!-- ************************************************************************ -->
            <div class="content first-content">

                <!-- ===== COLUNA ESQUERDA (mensagem + botão Logar) ===== -->
                <div class="first-column">
                    <h2 class="title title-primary">Bem vindo de volta!</h2>
                    <p class="description description-primary">Para manter-se conectado conosco</p>
                    <p class="description description-primary">faça o login com suas informações pessoais</p>
                    <button id="signin" class="btn btn-primary">LOGAR</button>
                </div>    

                <!-- ===== COLUNA DIREITA (formulário de cadastro) ===== -->
                <div class="second-column">
                    <h2 class="title title-second">Criar uma conta</h2>
                    <p class="description description-second">ou use seu e-mail para se cadastrar:</p>

                    <!-- ========================= -->
                    <!-- FORMULÁRIO DE CADASTRO    -->
                    <!-- ========================= -->
                    <!-- ATENÇÃO: enctype adicionado AQUI para permitir envio de arquivo -->
                    <form class="form" action="Usuario_servlet" method="POST" enctype="multipart/form-data" name="frm_cad_usuario" id="frm_cad_usuario">

                        <!-- ÁREA DA FOTO (NOVO) -->
                        <div class="profile-upload">
                            <div class="profile-img-box">
                                <!-- Imagem padrão inicial -->
                                <img src="./image/user.png" id="previewProfileRegister" alt="Foto de Perfil">
                            </div>
                            <!-- Input invisível que guarda o arquivo -->
                            <input type="file" name="foto" id="fileProfileRegister" accept="image/*" style="display: none;">
                            <!-- Botão visível para clicar -->
                            <label for="fileProfileRegister" class="btn-upload-mini">
                                <i class='bx bxs-camera'></i> Escolher Foto
                            </label>
                        </div>

                        <label class="label-input">
                            <i class="far fa-user icon-modify"></i>
                            <input type="text" placeholder="Nome" name="txtNome" required>
                        </label>

                        <label class="label-input">
                            <i class="far fa-user icon-modify"></i>
                            <input type="text" placeholder="Login (Usuário)" name="txtLogin" required>
                        </label>

                        <label class="label-input">
                            <i class="far fa-envelope icon-modify"></i>
                            <input type="email" placeholder="Email" name="txtEmail" required>
                        </label>

                        <label class="label-input">
                            <i class="fas fa-lock icon-modify"></i>
                            <input type="password" placeholder="Senha" name="txtSenha" required>
                        </label>

                        <!-- LINHA DUPLA PARA IDADE E TELEFONE -->
                        <div style="display: flex; width: 100%; gap: 10px;">
                            <label class="label-input" style="flex: 1;">
                                <input type="number" placeholder="Idade" name="txtIdade" required>
                            </label>
                            <label class="label-input" style="flex: 1;">
                                <input type="tel" placeholder="Telefone" name="txtTelefone" required>
                            </label>
                        </div>

                        <!-- SELECT DE GÊNERO -->
                        <label class="label-input">
                            <i class="fas fa-venus-mars icon-modify"></i>
                            <select name="txtSexo" required class="input-padrao">
                                <option value="" disabled selected>Selecione seu Gênero</option>
                                <option value="Masculino">Masculino</option>
                                <option value="Feminino">Feminino</option>
                                <option value="Outro">Outro</option>
                                <option value="Prefiro não dizer">Prefiro não dizer</option>
                            </select>
                        </label>

                        <label class="label-input" style="font-size: 1.0em; font-family: Arial; color: grey; background: transparent; justify-content: center; margin-top: 10px;">
                            <span>Sou Vendedor:</span> 
                            <input type="checkbox" id="op1" name="op1" value="on" style="margin-left: 10px; height: 1.5em; width: 20px;">
                        </label>

                        <input type="hidden" value="cad_usuario" id="acao" name="acao">

                        <button class="btn btn-second" type="submit">CADASTRAR</button>        
                    </form>
                </div>
            </div>

            <!-- ************************************************************************ -->
            <!-- ======================= SEÇÃO 2 : TELA DE LOGIN ======================== -->
            <!-- ************************************************************************ -->
            <div class="content second-content">

                <!-- ===== COLUNA ESQUERDA (mensagem + botão Cadastro) ===== -->
                <div class="first-column">
                    <h2 class="title title-primary">Olá, amigo!</h2>
                    <p class="description description-primary">Insira seus dados pessoais</p>
                    <p class="description description-primary">e comece a jornada conosco</p>
                    <button id="signup" class="btn btn-primary">CADASTRAR</button>
                </div>

                <!-- ===== COLUNA DIREITA (formulário de login) ===== -->
                <div class="second-column">
                    <h2 class="title title-second">FAÇA LOGIN OU CADASTRO</h2>
                    <p class="description description-second">Faça login ou cadastro para acessar nosso sistema</p>

                    <!-- ========================= -->
                    <!-- FORMULÁRIO DE LOGIN       -->
                    <!-- ========================= -->
                    <form class="form" action="Usuario_servlet" method="POST">

                        <label class="label-input">
                            <i class="far fa-envelope icon-modify"></i>
                            <input type="text" placeholder="Login" name="login" required>
                        </label>

                        <label class="label-input">
                            <i class="fas fa-lock icon-modify"></i>
                            <input type="password" placeholder="Senha" name="senha" required>
                        </label>

                        <input type="hidden" name="acao" value="logar">

                        <button class="btn btn-second" type="submit">LOGIN</button>
                    </form>

                </div>

            </div> <!-- fim second-content -->
        </div> <!-- fim container -->


        <!-- ============================ -->
        <!-- SCRIPT DE ANIMAÇÃO/TROCA     -->
        <!-- ============================ -->
        <script>
            var btnSignin = document.querySelector("#signin");
            var btnSignup = document.querySelector("#signup");
            var body = document.querySelector("body");

            // Botão LOGAR → Muda para tela de login
            btnSignin.addEventListener("click", function () {
                body.className = "sign-in-js";
            });

            // Botão CADASTRAR → Muda para tela de cadastro
            btnSignup.addEventListener("click", function () {
                body.className = "sign-up-js";
            });

            // --- SCRIPT DE PREVIEW DA FOTO (NOVO) ---
            // Quando o usuário seleciona um arquivo, atualiza a imagem redonda
            document.getElementById('fileProfileRegister').addEventListener('change', function(e) {
                if (e.target.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function(event) {
                        document.getElementById('previewProfileRegister').src = event.target.result;
                    }
                    reader.readAsDataURL(e.target.files[0]);
                }
            });
        </script>

        <!-- Módulos Extras: Chat e Feedback Visual -->
        <jsp:include page="chat_widget.jsp" />
        <jsp:include page="feedback.jsp" />
        
    </body>
</html>