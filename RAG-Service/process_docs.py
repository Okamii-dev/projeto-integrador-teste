import os
from dotenv import load_dotenv
from google import genai
from langchain_community.vectorstores import Chroma
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.document_loaders import PyPDFLoader, TextLoader
from langchain_google_genai import GoogleGenerativeAIEmbeddings

load_dotenv()
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")

if not GEMINI_API_KEY:
    raise ValueError("GEMINI_API_KEY não encontrada no arquivo .env. Verifique o arquivo.")

client = genai.Client(api_key=GEMINI_API_KEY)

VECTOR_DB_PATH = "vector_db"
EMBEDDING_MODEL = "text-embedding-004" # Modelo gratuito para Embeddings

# 1. Carrega o modelo de embeddings do Gemini
embedding_function = GoogleGenerativeAIEmbeddings(model=EMBEDDING_MODEL, client=client)

# 2. Carrega e divide os documentos
documents = []
for file in os.listdir("documents"):
    file_path = os.path.join("documents", file)
    
    if file.endswith(".pdf"):
        print(f"Carregando PDF: {file}")
        loader = PyPDFLoader(file_path)
    elif file.endswith(".txt"):
        print(f"Carregando TXT: {file}")
        loader = TextLoader(file_path, encoding='utf-8')
    else:
        continue # Ignora outros tipos de arquivo

    documents.extend(loader.load())

# 3. Splitter de texto (quebra documentos grandes em pedaços de 1000 caracteres)
text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
texts = text_splitter.split_documents(documents)

# 4. Cria e persiste o Vector DB
print(f"Criando Vector Store com {len(texts)} pedaços de texto...")
vectorstore = Chroma.from_documents(
    documents=texts,
    embedding=embedding_function,
    persist_directory=VECTOR_DB_PATH
)
vectorstore.persist()
print("\n✅ Vector Store criado com sucesso! O serviço RAG está pronto para uso.")

# --- Execute este script UMA VEZ ---
# python process_docs.py