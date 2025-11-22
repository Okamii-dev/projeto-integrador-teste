<%-- 
    Document   : editar_produto
    Created on : 09/06/2023, 00:40:28
    Author     : wanes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>     
        <link rel="stylesheet" href="styleEditarProduto.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
    <body>
        <form action="Produto" method="POST"  name="frm_edProduto" id="frm_edProduto">
            
            <div id="formulario">
                <h1>EDIÇÃO DE PRODUTO</h1>
            </div>
            <div id="frm_edProduto">
                
                <input type="hidden" value="${produto.idproduto}" id="idproduto" name="idproduto">
                <label>
                    <input value="${produto.produto}"  class="form-control" placeholder="nome do produto" name="txtNome" type="text" id="txtNome">
                </label> 
                <label>                    
                    <input value="${produto.descricao}"  class="form-control" placeholder="Descrição do Produto" name="txtDescricao" type="text" id="txtDescricao">
                </label>
                <label>
                    <input value="${produto.preco}" class="form-control" placeholder="Preço do Poduto" name="txtPreco" type="text" id="txtPreco">
                </label>
                <label > 
                    <input value="${produto.contato}" class="form-control" placeholder="(00)00000-0000" name="txtContato" type="tel" id="txtContato">
                </label>
                <label > 
                    <input type="hidden" value="${usuario.idusuario}" id="idusuario" name="idusuario">
                </label>     
            </div>
            <input type="hidden" value="atualizar" id="acao" name="acao">
            <button name="registro" type="submit" id="button" value="Enviar dados" > Salvar </button>
            <button name="registro" type="reset" id="button" value="Limpar dados" > Cancelar </button>
        </form>


        <script>
            
            $(document).ready(function () {
                // Quando o formulário for enviado
                $('#uploadForm').submit(function (e) {
                    e.preventDefault(); // Evita o envio padrão do formulário

                    var formData = new FormData(this); // Cria um objeto FormData com os dados do formulário

                    // Envia a requisição AJAX
                    $.ajax({
                        url: 'seu_script_de_armazenamento.php', // Substitua pelo caminho do seu script de armazenamento
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            // Ação a ser executada em caso de sucesso
                            console.log('Foto enviada com sucesso!');
                            $('#fotoUsuario').attr('src', response); // Atualiza a imagem de usuário com a nova foto
                        },
                        error: function () {
                            // Ação a ser executada em caso de erro
                            console.log('Erro ao enviar a foto!');
                        }
                    });
                });

                // Quando um arquivo for selecionado
                $('#fotoInput').change(function () {
                    var file = this.files[0]; // Obtém o arquivo selecionado
                    var reader = new FileReader();

                    // Função de callback quando a leitura do arquivo estiver concluída
                    reader.onload = function (e) {
                        $('#fotoUsuario').attr('src', e.target.result); // Atualiza a imagem de usuário com a nova foto
                    };

                    // Lê o arquivo como uma URL de dados
                    reader.readAsDataURL(file);
                });
            });
        </script> 
    </body>
</html>
