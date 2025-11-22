<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SEMEIA PRODUTORES - Cadastro de Produtos</title>
        <link rel="stylesheet" href="styleCadastroproduto.css">
    </head>
    <body>
        <form class="form" action="Produto" method="POST" name="frm_cad_produto" id="frm_cad_produto" required>
            <div id="formulario">
                <h1> CADASTRO DE PRODUTO</h1>
            </div>

            <div id="formulario-cadastro">
                <label for="txtProduto">Produto</label>
                <input placeholder="Digite o nome do produto" name="txtProduto" type="text" id="txtProduto">

                <label for="txtDescricao">Descrição</label>
                <input placeholder="Descrição do Produto" name="txtDescricao" type="text" id="txtDescricao">

                <label for="cotxtPrecorreo">Preço</label>
                <input placeholder="Preço do Poduto" name="txtPreco" type="txt" id="txPreco">

                <label for="txtContato">Contato</label>
                <input placeholder="(00)00000-0000" name="txtContato" type="tel" id="txtContato">

                <label for="txtId">Usuario</label>
                <input type="hidden" value="${usuario.idusuario}" id="idusuario" name="idusuario">
            </div>
            <input type="hidden" value="cad_produto" id="acao" name="acao">
            <button id="button" type="submit" value="Enviar dados"> Salvar </button>
            <button id="button" type="reset" value="Limpar dados"> limpar </button>
        </form>        
    </form>
    
    <form id="uploadForm" enctype="multipart/form-data">
        <img id="fotoUsuario" src="./image/cafe4.jpg" alt="Foto do usuário" style="width: 400px; height: 200px; border-radius: 20px;">
        <input type="file" id="fotoInput" name="foto" accept="image/*" required style="color:white;">
        <input type="submit" value="Enviar">
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
