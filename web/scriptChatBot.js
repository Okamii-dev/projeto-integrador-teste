// web/scriptChatBot.js

// O endereço do seu Microserviço Python de RAG
// Se estiver rodando localmente na porta 8000 (padrão do Uvicorn)
const pythonEndpointBase = 'http://localhost:8000/api/rag-chat'; 

// Estado global para controlar streaming e conexão SSE ativa
let currentSource = null;
let isStreaming = false;

function sendMessage() {
    const userInput = document.getElementById('user-input');
    if (!userInput) return;
    const question = userInput.value.trim();
    userInput.value = '';

    if (!question) return;

    // Evita múltiplas conexões simultâneas
    if (isStreaming) {
        console.warn('Já existe uma requisição em andamento. Aguarde o fim do streaming.');
        return;
    }

    // 1. Adiciona a mensagem do usuário
    appendMessage('user', question);

    // 2. Cria a caixa de resposta inicial do modelo
    const modelMessageElement = appendMessage('model', 'Digitando...');

    // Constrói o URL completo com a pergunta
    const fullEndpoint = `${pythonEndpointBase}?q=${encodeURIComponent(question)}`;

    // Fecha conexão anterior se existir
    if (currentSource) {
        try { currentSource.close(); } catch(e) { /* ignore */ }
        currentSource = null;
    }

    // Desabilita input/enviar enquanto o streaming estiver ativo
    const sendBtn = document.getElementById('send-btn');
    if (sendBtn) sendBtn.disabled = true;
    userInput.disabled = true;

    // 3. Inicia a conexão de Streaming (Server-Sent Events)
    const source = new EventSource(fullEndpoint);
    currentSource = source;
    isStreaming = true;

    let fullResponse = '';
    modelMessageElement.innerText = ''; // Limpa o "Digitando..."

    source.onopen = function() {
        console.log('Conexão SSE aberta.');
    };

    source.onmessage = function(event) {
        // Recebe cada 'chunk' (pedaço) de texto
        const chunk = event.data;
        fullResponse += chunk;

        // Atualiza a interface em tempo real
        modelMessageElement.innerText = fullResponse;

        // Faz o scroll para o final da conversa
        scrollToBottom();
    };

    source.onerror = function(error) {
        try { source.close(); } catch(e) { /* ignore */ }
        currentSource = null;
        isStreaming = false;

        // Re-habilita input/enviar
        if (sendBtn) sendBtn.disabled = false;
        userInput.disabled = false;

        if (fullResponse === '') {
             modelMessageElement.innerText = 'ERRO: Não foi possível obter a resposta do servidor de IA. Verifique se o backend Python está ativo.';
             console.error("Erro na conexão SSE:", error);
        } else {
             // Se houver resposta, o erro provavelmente significa que o streaming terminou.
             console.log("Streaming finalizado.");
        }
        scrollToBottom();
    };
}

// Função auxiliar para adicionar mensagens
function appendMessage(role, text) {
    const messagesDiv = document.getElementById('messages');
    const msgDiv = document.createElement('div');
    msgDiv.classList.add('message', role);
    msgDiv.innerText = text;
    messagesDiv.appendChild(msgDiv);
    return msgDiv;
}

// Função auxiliar para rolar a tela
function scrollToBottom() {
    const messagesDiv = document.getElementById('messages');
    messagesDiv.scrollTop = messagesDiv.scrollHeight;
}

// Inicializa listeners quando o DOM estiver pronto
document.addEventListener('DOMContentLoaded', () => {
    const sendBtn = document.getElementById('send-btn');
    const userInput = document.getElementById('user-input');

    if (sendBtn) sendBtn.addEventListener('click', sendMessage);

    if (userInput) {
        userInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') sendMessage();
        });
    }

    // Fecha a conexão SSE se a página for descarregada
    window.addEventListener('beforeunload', () => {
        if (currentSource) {
            try { currentSource.close(); } catch(e) { /* ignore */ }
            currentSource = null;
        }
    });
});