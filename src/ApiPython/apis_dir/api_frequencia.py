from flask import Flask, jsonify, request, render_template, make_response
import pyodbc
from flask_pydantic_spec import FlaskPydanticSpec
import asyncio 

app = Flask(__name__ )
spec = FlaskPydanticSpec('flask', title = "Endpoints da tabela de avaliação")
spec.register(app)      

data_for_connection = (
    "Driver={SQL Server Native Client RDA 11.0};"
    "Server=DESKTOP-1698A6Q\SQLEXPRESS;"
    "Database=bncc;"  
    "Trusted_connection=YES;"
)
connection = pyodbc.connect(data_for_connection)
cursor = connection.cursor()

@app.route('/diario/frequencia/<int:id_materia>/<int:id_bimestre>/<int:turma>', methods = ['GET'])
def get_freq (id_materia, id_bimestre, turma):
    db = cursor.execute(f"""select * from tabela_frequencia where id_materia 
                        ={id_materia} and id_bimestre = {id_bimestre}
                        and turma = {turma}""")
    db = db.fetchall()
    list_q = []
    for x in db:
        list_q.append(
            {
                'id_aluno': x[0],
                'id_materia': x[1],
                'id_bimestre':x[2],
                'turma': x[3],
                'data_aula': x[4],
                'descricao_aula': x[5],
                'habilidade_bncc': x[6],
                'presente': x[7],
                'id_frequencia': x[8]                
            }
        ) 
    return jsonify(message = "dados consultados", data = list_q)

@app.route('/diario/frequencia/inserir', methods = ["POST"])
def insert_freq():
    payload = request.get_json(force=True)
    id_turma = payload[0].get('id_turma')
    db_ids = cursor.execute(f"""SELECT id_aluno FROM tabela_alunos WHERE id_turma = {id_turma}""")
    list_ids = db_ids.fetchall()
    dic_ids = []
    for x in list_ids:
        for y in x:
            dic_ids.append({
                "id_aluno": y
            })

    result = []
    num_alunos = len(dic_ids)
    index = 0
    for aluno in dic_ids:
        data = payload[index % len(payload)]  
        result.append({
            "id_materia": data.get('id_materia'),
            "id_bimestre": data.get('id_bimestre'),
            "id_turma": id_turma,
            "data_aula": data.get('data_aula'),
            "descricao_aula": data.get('descricao_aula'),
            "habilidade_bncc": data.get('habilidade_bncc'),
            "id_aluno": aluno['id_aluno'],
            "presente": data.get('presente')
        })
        index += 1
    for x in result:
        cursor.execute(f"""INSERT INTO tabela_frequencia (id_aluno, id_materia, id_bimestre, id_turma, data_aula,
                       descricao_aula, habilidade_bncc, presente) VALUES (
                           {x['id_aluno']}, {x['id_materia']}, {x['id_bimestre']}, 
                           {id_turma}, '{x['data_aula']}', '{x['descricao_aula']}', '{x['habilidade_bncc']}',
                           {x['presente']}       
                       )
                       """)
    cursor.commit()               
    
    return jsonify(message= "está funcionando", data = result) 
    

app.run(debug=True)
