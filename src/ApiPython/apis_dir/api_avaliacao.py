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
show_table_names = cursor.execute(f"SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES \
                                  WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG='bncc'")
show_table_names = show_table_names.fetchall()

print(show_table_names)

@app.route('/diario/listanotas/<materia>/<turma>')
def get_grades_subjects(materia, turma):
    """mostra todas as notas de uma matéria de uma turma"""

    db = cursor.execute(f"""
                        SELECT tabela_alunos.nome_completo, tabela_materias.materia,
                        tabela_alunos.ano,
                        tabela_avaliacao.turma,  tabela_avaliacao.total
                        FROM tabela_alunos  INNER JOIN tabela_avaliacao ON 
                        tabela_alunos.id_aluno = tabela_avaliacao.id_aluno
                        INNER JOIN tabela_materias ON 
                        tabela_avaliacao.id_materia = 
                        tabela_materias.id_materia                        
                        where tabela_materias.materia = '{materia}' 
                        and tabela_avaliacao.turma = {turma}
                        """)
    db_get = db.fetchall()
    db_l = []    
    for x in db_get:
        db_l.append({
            "nome": x[0],
            "materia": x[1],
            "turma": x[2],
            "total": x[3]
        })      
    return jsonify(data = db_l, message = "dados solicitados")


@app.route('/diario/notas/')

def get_list_filters():
    """1) materia=MATERIA(str)&bimestre=BIMESTRE(int) => gera todos os
    boletins para todas as turmas do bimestre de 1 matéria \n
    2) materia=MATERIA(str)&bimestre=BIMESTRE(int)&turma=TURMA(int)=> gera todos os boletins 
    de uma matéria, de 1 bimestre para 1 turma \n
    3) materia=MATERIA(str)&ano=ANO(str)&bimestre=BIMESTRE(int) => gera todos os boletins
    de uma matéria para uma série/ano específico, baseado em um bimestre.
    4) materia=MATERIA(str)&ano=ANO(str)&bimestre=BIMESTRE(int)&turma=TURMA(int) => gera os boletins
    de uma matéria, de 1 bimestre, de 1 série específica, de 1 turma.
    5) materia=MATERIA(str) = > gera todas as notas de uma matéria, independente do ano
    6) materia=MATERIA(str)&turma=TURMA(int) => gera todas as notas de uma matéria, de uma turma 
    """
    filter_sub = request.args.get('materia')
    filter_cla = request.args.get('turma')
    filter_yea = request.args.get('ano')
    filter_per = request.args.get('bimestre')
    filter_gra = request.args.get('total')
    
    #matéria e bimestre
    if filter_sub is not None and filter_per is not None:
        query_l = cursor.execute(f"""
                                 SELECT nome_completo, ano, materia, tabela_avaliacao.turma, bimestre, total
                                 FROM tabela_alunos INNER JOIN tabela_avaliacao
                                 ON tabela_alunos.id_aluno = tabela_avaliacao.id_aluno
                                 INNER JOIN tabela_materias ON 
                                 tabela_avaliacao.id_materia = tabela_materias.id_materia
                                 WHERE materia ='{filter_sub}' and tabela_avaliacao.bimestre = {filter_per}
                                 
                             """)
    #matéria, ano
    if filter_sub is not None and filter_yea is not None:
        query_l = cursor.execute(f"""
                                  SELECT nome_completo, ano, materia, tabela_avaliacao.turma, bimestre, total
                                 FROM tabela_alunos INNER JOIN tabela_avaliacao
                                 ON tabela_alunos.id_aluno = tabela_avaliacao.id_aluno
                                 INNER JOIN tabela_materias ON 
                                 tabela_avaliacao.id_materia = tabela_materias.id_materia
                                 WHERE tabela_materias.materia ='{filter_sub}' and tabela_alunos.ano = '{filter_yea}'
                                 """)
    
    #matéria, bimestre e turma
    if filter_sub is not None and filter_per is not None and filter_cla is not None:
         query_l = cursor.execute(f"""
                                 SELECT nome_completo, ano, materia, tabela_avaliacao.turma, bimestre, total
                                 FROM tabela_alunos INNER JOIN tabela_avaliacao
                                 ON tabela_alunos.id_aluno = tabela_avaliacao.id_aluno
                                 INNER JOIN tabela_materias ON 
                                 tabela_avaliacao.id_materia = tabela_materias.id_materia
                                 WHERE materia ='{filter_sub}' and tabela_avaliacao.bimestre = {filter_per}
                                 AND tabela_avaliacao.turma = {filter_cla}                                 
                                 """)
    #materia, bimestre, ano e turma
    if filter_sub is not None and filter_per is not None and filter_cla is not None and filter_yea is not None:
        query_l = cursor.execute(f"""
                                SELECT nome_completo, ano, materia, tabela_avaliacao.turma, bimestre, total
                                FROM tabela_alunos INNER JOIN tabela_avaliacao
                                ON tabela_alunos.id_aluno = tabela_avaliacao.id_aluno
                                INNER JOIN tabela_materias ON 
                                tabela_avaliacao.id_materia = tabela_materias.id_materia
                                WHERE materia ='{filter_sub}' and tabela_avaliacao.bimestre = {filter_per}
                                AND tabela_avaliacao.turma = {filter_cla} AND tabela_alunos.ano = '{filter_yea}'                                
                                """)
    #materia
    if filter_sub is not None and filter_cla is \
        None and filter_gra is None and filter_per is None and filter_yea is None:
            query_l = cursor.execute(f"""
                                     SELECT nome_completo, ano, materia, tabela_avaliacao.turma, 
                                     bimestre, total FROM tabela_alunos INNER JOIN tabela_avaliacao
                                     ON tabela_alunos.id_aluno = tabela_avaliacao.id_aluno
                                     INNER JOIN tabela_materias ON
                                     tabela_avaliacao.id_materia = tabela_materias.id_materia
                                     WHERE materia = '{filter_sub}'
                                     """)
    #matéria e turma 
    if filter_sub is not None and filter_cla is not None:
        query_l = cursor.execute(f"""
                                SELECT nome_completo, ano, materia, tabela_avaliacao.turma, bimestre, total
                                FROM tabela_alunos INNER JOIN tabela_avaliacao
                                ON tabela_alunos.id_aluno = tabela_avaliacao.id_aluno
                                INNER JOIN tabela_materias ON 
                                tabela_avaliacao.id_materia = tabela_materias.id_materia
                                WHERE tabela_materias.materia ='{filter_sub}' and tabela_alunos.turma = {filter_cla}
                                """)
       
    query_l = query_l.fetchall()
    list_l = []
    for x in query_l:
        list_l.append({
            'nome_completo': x[0],
            'ano': x[1],
            'materia': x[2],
            'turma': x[3],
            'bimestre': x[4],
            'total': x[5]
        })
    return jsonify(data = list_l)
        
        
    
    

       
app.run(debug=True)
    
