<%-- 
    Document   : editar_dados
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario"%>
<%
    // Garante que o usuário está logado
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    // Coloca o objeto Usuario na requisição para a EL usar (necessário para o ${usuario.xxx} funcionar)
    request.setAttribute("usuario", u);
    
    // Lógica para definir o caminho correto da foto de perfil
    String fotoPerfil;
    if (u.getFoto() != null && !u.getFoto().isEmpty() && !u.getFoto().equals("user.png")) {
        // Caminho absoluto para a foto carregada
        fotoPerfil = request.getContextPath() + "/uploads/" + u.getFoto();
    } else {
        // Fallback para a foto padrão
        fotoPerfil = request.getContextPath() + "/image/user.png";
    }
    
    // Adicione a foto ao request para usar na tag IMG
    request.setAttribute("fotoPerfilPath", fotoPerfil);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Perfil</title>
        <link rel="stylesheet" href="styleEditarDados.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
        <style>
            /* Estilo exclusivo para a foto de perfil redonda */
            .profile-upload { display: flex; flex-direction: column; align-items: center; margin-bottom: 20px; }
            .profile-img-box { 
                width: 120px; height: 120px; border-radius: 50%; overflow: hidden; 
                border: 4px solid #4caf50; box-shadow: 0 5px 15px rgba(0,0,0,0.2);
                margin-bottom: 10px; position: relative; background: #fff;
            }
            .profile-img-box img { width: 100%; height: 100%; object-fit: cover; }
            .btn-upload-mini { 
                background: #1b5e20; color: white; padding: 5px 15px; border-radius: 20px; 
                font-size: 12px; cursor: pointer; display: flex; align-items: center; gap: 5px; 
                transition: 0.3s;
            }
            .btn-upload-mini:hover { background: #2e7d32; transform: scale(1.05); }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- enctype é obrigatório para envio de foto -->
            <form action="Usuario_servlet" method="POST" enctype="multipart/form-data" class="form-box">
                
                <div class="form-header">
                    <h1>Meu Perfil</h1>
                    <p>Atualize sua foto e dados</p>
                </div>
                
                <div class="form-body">
                    <!-- ID USUÁRIO ESCONDIDO (CHAVE PRIMÁRIA) -->
                    <input type="hidden" value="${usuario.idusuario}" name="idusuario">
                    <!-- AÇÃO ESCONDIDA PARA O SERVLET -->
                    <input type="hidden" value="atualizar" name="acao">

                    <!-- ÁREA DA FOTO -->
                    <div class="profile-upload">
                        <div class="profile-img-box">
                            <!-- Usa o caminho definido no Scriptlet (mais seguro) -->
                            <img src="${fotoPerfilPath}" id="previewProfile">
                        </div>
                        <input type="file" name="foto" id="fileProfile" accept="image/*" style="display: none;">
                        <label for="fileProfile" class="btn-upload-mini">
                            <i class='bx bxs-camera'></i> Alterar Foto
                        </label>
                    </div>

                    <div class="input-group">
                        <label>Nome Completo</label>
                        <input value="${usuario.nome}" type="text" name="txtNome" required> 
                    </div>
                    
                    <div class="input-group">
                        <label>Login</label>
                        <input value="${usuario.login}" type="text" name="txtLogin" readonly class="readonly"> 
                    </div>
                    
                    <div class="input-group">
                        <label>Senha</label>
                        <input value="${usuario.senha}" type="text" name="txtSenha" required> 
                    </div>
                    
                    <div class="input-group">
                        <label>Email</label>
                        <input value="${usuario.email}" type="email" name="txtEmail" required> 
                    </div>
                    
                    <div class="row">
                        <div class="input-group">
                            <label>Telefone</label>
                            <input value="${usuario.telefone}" type="tel" name="txtTelefone"> 
                        </div>
                        <div class="input-group">
                            <label>Idade</label>
                            <input value="${usuario.idade}" type="number" name="txtIdade" required> 
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Gênero</label>
                        <select name="txtSexo" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; background-color: #f9f9f9;">
                            <!-- Lógica para pré-selecionar o valor atual do usuário -->
                            <option value="Masculino" ${usuario.sexo == 'Masculino' ? 'selected' : ''}>Masculino</option>
                            <option value="Feminino" ${usuario.sexo == 'Feminino' ? 'selected' : ''}>Feminino</option>
                            <option value="Outro" ${usuario.sexo == 'Outro' ? 'selected' : ''}>Outro</option>
                            <option value="Prefiro não dizer" ${usuario.sexo == 'Prefiro não dizer' ? 'selected' : ''}>Prefiro não dizer</option>
                        </select>
                    </div>               
                </div>
                
                <div class="form-footer">
                    <button type="submit" class="btn-save">Salvar Alterações</button>
                    <button type="button" onclick="history.back()" class="btn-cancel">Cancelar</button>
                </div>
            </form>
        </div>

        <script>
            // Script de pré-visualização da foto
            document.getElementById('fileProfile').addEventListener('change', function(e) {
                if (e.target.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function(event) {
                        document.getElementById('previewProfile').src = event.target.result;
                    }
                    reader.readAsDataURL(e.target.files[0]);
                }
            });
        </script>
    </body>
</html>