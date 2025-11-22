import os
from dotenv import load_dotenv
from fastapi import FastAPI, HTTPException
from fastapi.responses import StreamingResponse
from fastapi.middleware.cors import CORSMiddleware
from google import genai
from langchain_community.vectorstores import Chroma
from langchain_google_genai import GoogleGenerativeAIEmbeddings

load_dotenv()
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
client = genai.Client(api_key=GEMINI_API_KEY)

# --- Configuração FastAPI ---
app = FastAPI(title="Gemini RAG Streaming Service")

# Permite chamadas do seu frontend (CRUCIAL para CORS)
app.add_middleware(
    CORSMiddleware,
    # Em desenvolvimento: use "*" ou o endereço exato do seu servidor Java, ex: "http://localhost:8080"
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- Configurações Gemini/RAG ---
VECTOR_DB_PATH = "vector_db"
EMBEDDING_MODEL = "text-embedding-004"
GENERATION_MODEL = "gemini-2.5-flash"

# Carrega a função de embedding e o Vector Store
try:
    embedding_function = GoogleGenerativeAIEmbeddings(model=EMBEDDING_MODEL, client=client)
    # Persiste a conexão com o banco de vetores criado
    vectorstore = Chroma(persist_directory=VECTOR_DB_PATH, embedding_function=embedding_function)
except Exception as e:
    print(f"Falha ao carregar o Vector Store: {e}")
    # Continue, mas o endpoint de chat irá falhar se o DB não existir.

# --- Endpoint de Streaming do Chat ---
@app.get("/api/rag-chat")
async def rag_chat_stream(q: str):
    if not q:
        raise HTTPException(status_code=400, detail="A pergunta (parâmetro 'q') é necessária.")
    
    # 1. Recupera o contexto relevante do Vector DB (Busca de similaridade)
    docs = vectorstore.similarity_search(q, k=4)
    context = "\n---\n".join([doc.page_content for doc in docs])
    
    # 2. Cria o prompt de Sistema (Instrui o modelo a usar o contexto)
    system_instruction = (
        "Você é um chatbot especialista em documentos científicos. "
        "Use APENAS o contexto fornecido para responder. "
        "Mantenha a resposta clara e concisa. "
        "Se a resposta não estiver no contexto, diga gentilmente que a informação não foi encontrada em sua base de conhecimento."
    )
    
    full_prompt = (
        f"{system_instruction}\n\n"
        f"--- CONTEXTO FORNECIDO ---\n{context}\n\n"
        f"--- PERGUNTA DO USUÁRIO ---\n{q}"
    )

    # 3. Função geradora para streaming
    def stream_response():
        try:
            response_stream = client.models.generate_content_stream(
                model=GENERATION_MODEL,
                contents=full_prompt
            )
            for chunk in response_stream:
                if chunk.text:
                    # Formato Server-Sent Events (SSE)
                    yield f"data: {chunk.text}\n\n"
        except Exception as e:
            print(f"Erro durante a comunicação com o Gemini: {e}")
            yield f"data: ERRO INTERNO: Falha no serviço de IA.\n\n"

    # 4. Retorna a resposta como StreamingResponse (text/event-stream)
    return StreamingResponse(stream_response(), media_type="text/event-stream")

# --- COMO INICIAR O SERVIDOR ---
# uvicorn app:app --host 0.0.0.0 --port 8000