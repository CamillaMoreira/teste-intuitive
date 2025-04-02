import tabula
import pandas as pd
import zipfile
import os

def extrair_dados_pdf(pdf_file, output_csv):
    dfs = tabula.read_pdf(pdf_file, pages='all', multiple_tables=True)
    combined_df = pd.concat(dfs, ignore_index=True)
    
    abreviacoes = {'OD': 'Seg. Odontológica', 'AMB': 'Seg. Ambulatorial'}
    combined_df.replace(abreviacoes, inplace=True)
    
    combined_df.to_csv(output_csv, index=False)
    print(f"Dados salvos no arquivo CSV: {output_csv}")

def compactar_csv(input_csv, output_zip):
    with zipfile.ZipFile(output_zip, 'w') as zipf:
        zipf.write(input_csv, arcname=os.path.basename(input_csv))
    print(f"CSV compactado em: {output_zip}")

if __name__ == "__main__":
    pdf_file = "downloads/Anexo_I.pdf"  
    output_csv = "teste_camilla.csv"
    output_zip = "Teste_Camilla.zip"
    
    extrair_dados_pdf(pdf_file, output_csv)
    compactar_csv(output_csv, output_zip)
