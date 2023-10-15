from flask import Flask, jsonify, request
import pyodbc
import pandas as pd
from flask_pydantic_spec import FlaskPydanticSpec


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

# cursor.execute(f"""create table tabela_frequencia (
#    id_aluno int,
#    id_materia int, 
#    id_bimestre int,
#    turma int ,
#    data_aula datetime,
#    descricao_aula nvarchar(150),
#    habilidade_bncc text, 
#    presente bit) """)

# cursor.execute(f"""alter table tabela_frequencia add id_frequencia int identity 
#                constraint PK_frequencia primary key clustered """) 

# cursor.execute(f"""insert into tabela_frequencia (id_aluno, id_materia, id_bimestre,
#                turma, data_aula, descricao_aula, habilidade_bncc,
#                presente) values (
#                   1, 6, 2, 1, 15-10-2023, 'atividade em sala', 'ler', 1
#                ) 
#                """)
# db = cursor.execute(f"""select * from tabela_frequencia where turma = 2 and id_bimestre = 1
#                     and id_materia = 2
#                """) #inserir turma 2 bimestre 1 materia 2
# db_l = db.fetchall()
# print(db_l)

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

app.run(debug=True)
