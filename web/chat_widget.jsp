<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // --- CONTROLE GERAL DO CHAT ---
    // Mude para FALSE se quiser esconder o chat na apresentação
    boolean ativarChat = true; 
%>

<% if (ativarChat) { %>

    <style>
        /* Botão Flutuante */
        .chat-btn-float {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #4caf50; /* Verde Vivo */
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            cursor: pointer;
            z-index: 9999;
            transition: transform 0.3s;
            border: none;
        }
        .chat-btn-float:hover { transform: scale(1.1); }

        /* Janela do Chat */
        .chat-window {
            position: fixed;
            bottom: 100px;
            right: 30px;
            width: 350px;
            height: 450px;
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            z-index: 9999;
            display: none; /* Começa fechado */
            flex-direction: column;
            overflow: hidden;
            border: 1px solid #e0e0e0;
            font-family: 'Poppins', sans-serif;
        }

        /* Cabeçalho */
        .chat-header {
            background-color: #1b5e20; /* Verde Escuro */
            color: white;
            padding: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .chat-header img { width: 40px; height: 40px; border-radius: 50%; background: white; padding: 2px; }
        .chat-header h4 { font-size: 16px; margin: 0; }
        .chat-header small { font-size: 12px; color: #a5d6a7; }
        .close-chat { margin-left: auto; cursor: pointer; font-size: 20px; }

        /* Corpo das Mensagens */
        .chat-body {
            flex: 1;
            background-color: #e8f5e9; /* Fundo verdinho claro */
            padding: 15px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        /* Balões de Mensagem */
        .message {
            max-width: 80%;
            padding: 10px 15px;
            border-radius: 15px;
            font-size: 14px;
            position: relative;
            line-height: 1.4;
        }
        .received {
            background-color: #fff;
            align-self: flex-start;
            border-bottom-left-radius: 2px;
            color: #333;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .sent {
            background-color: #dcf8c6; /* Verde WhatsApp */
            align-self: flex-end;
            border-bottom-right-radius: 2px;
            color: #333;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        /* Área de Input */
        .chat-footer {
            padding: 10px;
            background-color: #fff;
            border-top: 1px solid #eee;
            display: flex;
            gap: 10px;
        }
        .chat-footer input {
            flex: 1;
            padding: 10px;
            border-radius: 20px;
            border: 1px solid #ddd;
            outline: none;
        }
        .chat-footer button {
            background-color: #4caf50;
            color: white;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 18px;
        }
    </style>

    <button class="chat-btn-float" onclick="toggleChat()">
        <i class='bx bxs-message-dots'></i>
    </button>

    <div class="chat-window" id="chatWindow">
        <div class="chat-header">
            <img src="./image/user.png" alt="User">
            <div>
                <h4>Chat Online</h4>
                <small>Respondemos rápido</small>
            </div>
            <i class='bx bx-x close-chat' onclick="toggleChat()"></i>
        </div>

        <div class="chat-body" id="chatBody">
            <div class="message received">Olá! Tenho interesse nos produtos. Estão frescos?</div>
            <div class="message sent">Boa tarde! Sim, colhidos hoje cedo. 🌱</div>
        </div>

        <div class="chat-footer">
            <input type="text" id="chatInput" placeholder="Digite sua mensagem..." onkeypress="handleEnter(event)">
            <button onclick="sendMessage()"><i class='bx bxs-send'></i></button>
        </div>
    </div>

    <script>
        function toggleChat() {
            const chat = document.getElementById('chatWindow');
            if (chat.style.display === 'none' || chat.style.display === '') {
                chat.style.display = 'flex';
                // Foca no input ao abrir
                setTimeout(() => document.getElementById('chatInput').focus(), 100);
            } else {
                chat.style.display = 'none';
            }
        }

        function sendMessage() {
            const input = document.getElementById('chatInput');
            const body = document.getElementById('chatBody');
            const text = input.value.trim();

            if (text !== "") {
                // Cria a mensagem "Enviada" (Verde)
                const msgDiv = document.createElement('div');
                msgDiv.className = 'message sent';
                msgDiv.innerText = text;
                body.appendChild(msgDiv);

                // Limpa input
                input.value = "";
                
                // Rola para baixo
                body.scrollTop = body.scrollHeight;

                // SIMULAÇÃO DE RESPOSTA AUTOMÁTICA (Para parecer real)
                setTimeout(() => {
                    const replyDiv = document.createElement('div');
                    replyDiv.className = 'message received';
                    replyDiv.innerText = "Obrigado pelo contato! O vendedor responderá em breve.";
                    body.appendChild(replyDiv);
                    body.scrollTop = body.scrollHeight;
                }, 1500);
            }
        }

        function handleEnter(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        }
    </script>

<% } %>