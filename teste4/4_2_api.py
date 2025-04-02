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

    params = {
        "param_cod_ans": request.args.get("cod_ans", "").strip(),
        "param_nome_empresa": request.args.get("nome_empresa", "").strip(),
        "param_nome_fantasia": request.args.get("nome_fantasia", "").strip(),
        "param_modalidade": request.args.get("modalidade", "").strip(),
        "param_endereco": request.args.get("endereco", "").strip(),
        "param_numero_endereco": request.args.get("numero", "").strip(),
        "param_complemento_endereco": request.args.get("complemento_endereco", "").strip(),
        "param_bairro": request.args.get("bairro", "").strip(),
        "param_cidade": request.args.get("cidade", "").strip(),
        "param_telefone_contato": request.args.get("telefone_contato", "").strip(),
        "param_telefone_fax": request.args.get("telefone_fax", "").strip(),
        "param_email_contato": request.args.get("email_contato", "").strip(),
        "param_nome_representante": request.args.get("nome_representante", "").strip(),
        "param_cargo_representante": request.args.get("cargo_representante", "").strip(),
        "param_identificacao_cnpj": request.args.get("identificacao_cnpj", "").strip(),
        "param_estado": request.args.get("estado", "").strip()
    }

    limite = request.args.get("limite", 10, type=int)

    query = "SELECT * FROM buscar_operadoras("
    query_params = []
    for key, value in params.items():
        if value:
            query += f"{key} := %s, "
            query_params.append(value)

    query = query.rstrip(", ") + ") LIMIT %s"
    query_params.append(limite)

    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cur = conn.cursor(cursor_factory=RealDictCursor)

        cur.execute(query, query_params)
        resultados = cur.fetchall()

        cur.close()
        conn.close()

        return jsonify(resultados)

    except psycopg2.Error as e:
        return jsonify({"error": "Erro ao acessar o banco de dados", "details": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
