from flask import Flask, request, jsonify
import psycopg2
from psycopg2.extras import RealDictCursor
from flask_cors import CORS

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}}) 

DB_CONFIG = {
    "dbname": "postgres",
    "user": "postgres",
    "password": "1112",  
    "host": "localhost",
    "port": "5432"
}

@app.route("/", methods=["GET"])
def home():
    return jsonify({"message": "API está rodando com sucesso!"})

@app.route("/operadoras", methods=["GET"])
def buscar_operadora():
    termo = request.args.get("search", "").strip()
    limite = request.args.get("limite", 10, type=int)

    if not termo:
        return jsonify({"error": "Nenhum termo de busca fornecido"}), 400

    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cur = conn.cursor(cursor_factory=RealDictCursor)

        cur.execute("""
            SELECT *
            FROM operadoras_registradas
            WHERE nome_fantasia ILIKE %s OR cnpj ILIKE %s
            ORDER BY nome_fantasia ASC
            LIMIT %s
        """, (f"%{termo}%", f"%{termo}%", limite))

        resultados = cur.fetchall()
        cur.close()
        conn.close()

        return jsonify(resultados)

    except psycopg2.Error as e:
        return jsonify({"error": "Erro ao acessar o banco de dados", "details": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
