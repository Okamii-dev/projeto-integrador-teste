<%-- 
    Document   : cadastro_produto
    Created on : 05/06/2023
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastrar Produto</title>
        <link rel="stylesheet" href="styleCadastroproduto.css">
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        
        <div class="main-container">
            
            <form action="Produto" method="POST" enctype="multipart/form-data" class="card-box">
                
                <div class="form-header">
                    <h1>Novo Produto</h1>
                    <p>Preencha os dados abaixo</p>
                </div>

                <div class="form-body">
                    
                    <div class="col-left">
                        <h3>Informações</h3>
                        
                        <input type="hidden" value="cad_produto" name="acao">
                        <input type="hidden" value="${usuario.idusuario}" name="idusuario">

                        <div class="input-group">
                            <label>Nome do Produto</label>
                            <input type="text" name="txtProduto" placeholder="Ex: Alface Crespa" required>
                        </div>

                        <div class="input-group">
                            <label>Descrição</label>
                            <textarea name="txtDescricao" placeholder="Detalhes do produto..." rows="3"></textarea>
                        </div>

                        <div class="row-inputs">
                            <div class="input-group">
                                <label>Preço (R$)</label>
                                <input type="text" name="txtPreco" placeholder="0,00" required>
                            </div>
                            <div class="input-group">
                                <label>Contato</label>
                                <input type="tel" name="txtContato" placeholder="(00) 00000-0000" required>
                            </div>
                        </div>
                    </div>

                    <div class="col-right">
                        <h3>Foto do Produto</h3>
                        
                        <div class="image-area">
                            <img src="https://via.placeholder.com/300x200/e8f5e9/1b5e20?text=Sem+Foto" id="previewImg" alt="Preview">
                        </div>
                        
                        <input type="file" name="foto" id="fileInput" accept="image/*" style="display: none;">
                        
                        <label for="fileInput" class="btn-upload">
                            <i class='bx bxs-camera'></i> Escolher Imagem
                        </label>
                    </div>
                </div>

                <div class="form-footer">
                    <button type="submit" class="btn-save">Cadastrar Produto</button>
                    <a href="area_vendedor.jsp" class="btn-cancel">Cancelar</a>
                </div>

            </form>
        </div>

        <script>
            const fileInput = document.getElementById('fileInput');
            const previewImg = document.getElementById('previewImg');

            fileInput.addEventListener('change', function(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        previewImg.src = e.target.result;
                    }
                    reader.readAsDataURL(file);
                }
            });
        </script>

    </body>
</html>