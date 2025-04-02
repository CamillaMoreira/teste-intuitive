import requests
from bs4 import BeautifulSoup
import os
import zipfile

URL = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
DOWNLOAD_DIR = "downloads"
ZIP_FILENAME = "anexos.zip"

os.makedirs(DOWNLOAD_DIR, exist_ok=True)

def baixar_arquivos():
    response = requests.get(URL)
    response.raise_for_status()
    soup = BeautifulSoup(response.text, "html.parser")
    
    pdf_links = [a["href"] for a in soup.find_all("a", href=True) if "Anexo" in a.text and a["href"].endswith(".pdf")]
    
    if not pdf_links:
        print("Nenhum arquivo encontrado para download.")
        return
    
    for link in pdf_links:
        try:
            pdf_response = requests.get(link)
            pdf_response.raise_for_status()
            filename = os.path.join(DOWNLOAD_DIR, link.split("/")[-1])
            
            with open(filename, "wb") as f:
                f.write(pdf_response.content)
            print(f"Baixado: {filename}")
        except requests.RequestException as e:
            print(f"Erro ao baixar {link}: {e}")

def compactar_arquivos():
    with zipfile.ZipFile(ZIP_FILENAME, "w") as zipf:
        for file in os.listdir(DOWNLOAD_DIR):
            zipf.write(os.path.join(DOWNLOAD_DIR, file), arcname=file)
    print(f"Arquivos compactados em {ZIP_FILENAME}")

if __name__ == "__main__":
    baixar_arquivos()
    compactar_arquivos()
