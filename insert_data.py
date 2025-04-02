import pandas as pd
import psycopg2

conn = psycopg2.connect("dbname=postgres user=postgres password=1112 host=localhost")
cur = conn.cursor()

from pathlib import Path  

caminho_csv = Path(r"C:\camillaRepos\teste-python\operadoras.csv")
df = pd.read_csv(caminho_csv, header=None, names=['codigo', 'nome', 'tipo', 'municipio'])

for _, row in df.iterrows():
    cur.execute("INSERT INTO operadoras (codigo, nome, tipo, municipio) VALUES (%s, %s, %s, %s)",
                (row['codigo'], row['nome'], row['tipo'], row['municipio']))

conn.commit()
cur.close()
conn.close()

print("Dados inseridos com sucesso!")
