<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Recupera a mensagem e o tipo (erro ou sucesso) enviados pelo Servlet
    String msg = (String) request.getAttribute("msg");
    String tipo = (String) request.getAttribute("tipo"); // Deve ser "erro" ou "sucesso"
    
    // Só exibe o modal se houver uma mensagem
    if (msg != null && !msg.isEmpty()) {
        if (tipo == null) tipo = "erro"; // Padrão se não definir
%>

    <link rel="stylesheet" href="styleFeedback.css">
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>

    <div class="modal-overlay" id="modalAviso">
        <div class="modal-card <%= tipo %>">
            
            <% if (tipo.equals("sucesso")) { %>
                <i class='bx bxs-check-circle'></i>
                <h2>Sucesso!</h2>
            <% } else { %>
                <i class='bx bxs-error-circle'></i>
                <h2>Atenção</h2>
            <% } %>

            <p><%= msg %></p>
            
            <button onclick="fecharModal()">Entendido</button>
        </div>
    </div>

    <script>
        function fecharModal() {
            const modal = document.getElementById('modalAviso');
            modal.style.opacity = '0';
            setTimeout(() => { modal.style.display = 'none'; }, 300);
        }
    </script>

<%
    }
%>