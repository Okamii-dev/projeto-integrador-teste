<%-- 
    Document   : editar_dados
    Created on : 07/06/2023, 15:52:29
    Author     : sala303b
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styleEditarDados.css">
    </head>
    <body>
        <form action="Usuario" method="POST" name="frm_edit_usuario" id="frm_edit_usuario" style="margin-left: 397px;">
            <div id="formulario">
                <h1>EDIÇÃO DE CADASTRO</h1>
            </div>
            <div id="formulario_editar" style="margin-left: -15px;">
                <input type="hidden" value="${usuario.idusuario}" id="idusuario" name="idusuario">
                <label>
                    <input value="${usuario.nome}" class="form-control" type="text" id="txtNome" name="txtNome" placeholder="Nome"required > 
                </label>
                <label>
                    <input value="${usuario.login}" class="form-control" type="text" id="txtLogin" name="txtLogin" placeholder="Login" required > 
                </label>
                <label>
                    <input value="${usuario.senha}" class="form-control" type="password" id="txtSenha" name="txtSenha" placeholder="Senha" required > 
                </label>
                <label>
                    <input value="${usuario.email}"  class="form-control" type="email" id="txtEmail" name="txtEmail" placeholder="E-mail" required > 
                </label>
                <label>
                    <input value="${usuario.telefone}" class="form-control" type="tel" id="txtTel" name="txtTel" placeholder="Telefone : (00)00000-0000" >                     
                </label>
                <label>
                    <input value="${usuario.idade}" class="form-control" type="number" placeholder="Idade" min="1" max="99" id="txtIdade" name="txtIdade" required> 
                </label>                  
            </div>
            <input type="hidden" value="atualizar" id="acao" name="acao">
            <button id="button" type="submit" value="Enviar dados"> Salvar </button>
            <button id="button" type="reset" value="Limpar dados"> limpar </button>
        </form>
    </body>
</html>
