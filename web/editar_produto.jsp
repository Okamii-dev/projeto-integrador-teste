<%-- 
    Document   : editar_produto
    Created on : 09/06/2023
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
        <title>Editar Produto</title>
        <link rel="stylesheet" href="styleCadastroproduto.css">
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        
        <div class="main-container">
            
            <form action="Produto" method="POST" enctype="multipart/form-data" class="card-box">
                
                <div class="form-header">
                    <h1>Editar Produto</h1>
                    <p>Altere os dados do produto selecionado</p>
                </div>

                <div class="form-body">
                    
                    <div class="col-left">
                        <h3>Informações</h3>
                        
                        <input type="hidden" value="atualizar" name="acao">
                        <input type="hidden" value="${produto.idproduto}" name="idproduto">
                        <input type="hidden" value="${usuario.idusuario}" name="idusuario">

                        <div class="input-group">
                            <label>Nome do Produto</label>
                            <input value="${produto.produto}" type="text" name="txtNome" required>
                        </div>

                        <div class="input-group">
                            <label>Descrição</label>
                            <textarea name="txtDescricao" rows="3">${produto.descricao}</textarea>
                        </div>

                        <div class="row-inputs">
                            <div class="input-group">
                                <label>Preço (R$)</label>
                                <input value="${produto.preco}" type="text" name="txtPreco" required>
                            </div>
                            <div class="input-group">
                                <label>Contato</label>
                                <input value="${produto.contato}" type="tel" name="txtContato" required>
                            </div>
                        </div>
                    </div>

                    <div class="col-right">
                        <h3>Foto do Produto</h3>
                        
                        <div class="image-area">
                            <img src="https://source.unsplash.com/300x200/?vegetables,fruit&sig=${produto.idproduto}" id="previewImg">
                        </div>
                        
                        <input type="file" name="foto" id="fileInput" accept="image/*" style="display: none;">
                        
                        <label for="fileInput" class="btn-upload">
                            <i class='bx bxs-camera'></i> Trocar Imagem
                        </label>
                    </div>
                </div>

                <div class="form-footer">
                    <button type="submit" class="btn-save">Salvar Alterações</button>
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