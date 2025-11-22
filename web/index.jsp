<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Semeia Produtores</title>    
    <link rel="stylesheet" href="stylelogin.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">        
</head>
<body>      
    <div class="container">
        <div class="content first-content">
            <div class="first-column">
                <h2 class="title title-primary">Bem vindo de volta!</h2>
                <p class="description description-primary">Para manter-se conectado conosco</p>
                <p class="description description-primary">faça o login com suas informações pessoais</p>
                <button id="signin" class="btn btn-primary">LOGAR</button>
            </div>    
            
            <div class="second-column">
                <h2 class="title title-second">Criar uma conta</h2>
                <p class="description description-second">ou use seu e-mail para se cadastrar:</p>
                
                <form class="form" action="Usuario" method="POST" name="frm_cad_usuario" id="frm_cad_usuario">
                    
                    <label class="label-input">
                        <i class="far fa-user icon-modify"></i>
                        <input type="text" placeholder="Nome" name="txtNome" required>
                    </label>
                    
                    <label class="label-input">
                        <i class="far fa-user icon-modify"></i>
                        <input type="text" placeholder="Login" name="txtLogin" required>
                    </label>

                    <label class="label-input">
                        <i class="far fa-envelope icon-modify"></i>
                        <input type="email" placeholder="Email" name="txtEmail" required>
                    </label>
                    
                    <label class="label-input">
                        <i class="far fa-user icon-modify"></i>
                        <input type="tel" placeholder="Telefone" name="txtTelefone" required>
                    </label>
                    
                    <label class="label-input">
                        <input type="number" placeholder="Idade" min="1" max="99" style="margin-left: 5px;" name="txtIdade" required>
                    </label>

                    <label class="label-input">
                        <i class="far fa-user icon-modify"></i>
                        <input type="text" placeholder="Sexo" name="txtSexo" required>
                    </label>

                    <label class="label-input" >
                        <i class="fas fa-lock icon-modify"></i>
                        <input type="password" placeholder="Senha" name="txtSenha" required>
                    </label>
                    
                    <label class="label-input" style="font-size: 1.0em; font-family: Arial; color: grey;">
                        <span>Vendedor:</span> 
                        <input type="checkbox" id="op1" name="op1" value="on" style="margin-left: -135px; height: 1.5em;">
                    </label>
                    
                    <input type="hidden" value="cad_usuario" id="acao" name="acao">                    
                    <button class="btn btn-second" type="submit">CADASTRO</button>        
                </form>
            </div></div><div class="content second-content">
            <div class="first-column">
                <h2 class="title title-primary">Olá, amigo!</h2>
                <p class="description description-primary">Insira seus dados pessoais</p>
                <p class="description description-primary">e comece a jornada conosco</p>
                <button id="signup" class="btn btn-primary">CADASTRO</button>
            </div>
            
            <div class="second-column">
                <h2 class="title title-second">FAÇA LOGIN OU CADASTRO</h2>
                <p class="description description-second">Faça login ou cadastro para acessar nosso sistema</p>
                
                <form class="form" action="Usuario" method="POST">
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
            </div></div></div>
    
    <script>
        var btnSignin = document.querySelector("#signin");
        var btnSignup = document.querySelector("#signup");
        var body = document.querySelector("body");

        btnSignin.addEventListener("click", function () {
            body.className = "sign-in-js";
        });

        btnSignup.addEventListener("click", function () {
            body.className = "sign-up-js";
        });
    </script>
</body>
</html>