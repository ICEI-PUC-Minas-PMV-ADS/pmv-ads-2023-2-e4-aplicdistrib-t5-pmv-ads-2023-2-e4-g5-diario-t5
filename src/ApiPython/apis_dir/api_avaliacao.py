from flask import Flask, jsonify, request
import pyodbc
import pandas as pd
from flask_pydantic_spec import FlaskPydanticSpec


app = Flask(__name__ )
spec = FlaskPydanticSpec(title = "Endpoints da tabela de avaliação", \
    description = "Documentação da api")
spec.register(app)

data_for_connection = (
    "Driver={SQL Server Native Client RDA 11.0};"
    "Server=DESKTOP-1698A6Q\SQLEXPRESS;"
    "Database=bncc;"  
    "Trusted_connection=YES;"
)
connection = pyodbc.connect(data_for_connection)
cursor = connection.cursor()

@app.route('/diario/listanotas/<string:materia>/<int:turma>')
def get_grades_subjects(materia, turma):
    """mostra todas as notas de uma matéria de uma turma"""

    db = cursor.execute(f"""
                        SELECT tabela_alunos.nome_completo, tabela_materias.materia,
                        tabela_alunos.ano,
                        tabela_avaliacao.turma,  tabela_avaliacao.total, 
                        tabela_avaliacao.id_avaliacao
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
            "total": x[3],
            'id_avaliacao': x[4]
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
    filter_avg = request.args.get('media')
    
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
                                SELECT nome_completo, ano, materia, tabela_avaliacao.turma, bimestre, total, id_avaliacao
                                FROM tabela_alunos INNER JOIN tabela_avaliacao
                                ON tabela_alunos.id_aluno = tabela_avaliacao.id_aluno
                                INNER JOIN tabela_materias ON 
                                tabela_avaliacao.id_materia = tabela_materias.id_materia
                                WHERE tabela_materias.materia ='{filter_sub}' and tabela_alunos.turma = {filter_cla}
                                """)   

       
    query_l = query_l.fetchall()
    print(query_l)
    list_l = []
    for x in query_l:
        list_l.append({
            'nome_completo': x[0],
            'ano': x[1],
            'materia': x[2],
            'turma': x[3],
            'bimestre': x[4],
            'total': x[5],
            'id_avaliacao': x[6]
        })
    return jsonify(data = list_l)
        
@app.route('/diario/notas/media/', methods = ['GET'])
def get_mean():
    filter_sub = request.args.get('materia')
    filter_cla = request.args.get('turma')
    filter_yea = request.args.get('ano')
    filter_per = request.args.get('bimestre')
    
    #média de todas as turmas de uma determinada matéria
    if filter_sub is not None and filter_cla is None and filter_per is None and filter_yea is None:  
        query_l = cursor.execute(f"""
                                 SELECT materia, turma, AVG(tabela_avaliacao.total)
                                 FROM tabela_avaliacao INNER JOIN tabela_materias
                                 ON tabela_avaliacao.id_materia = 
                                 tabela_materias.id_materia where materia = '{filter_sub}'
                                 GROUP BY materia, turma                                
                                 """)        
    query_l = query_l.fetchall()
    print(query_l)
    list_l = []
    for x in query_l:
        list_l.append({
            'materia': x[0],
            'turma': x[1],
            'media': x[2],
        })
    return jsonify(message = "dados solicitados", data = list_l) 

@app.route('/diario/notas/inserir/<int:id_materia>/<int:id_bimestre>/<int:turma>', methods = ['GET', 'POST'])
def post_grades( id_materia, id_bimestre, turma):
    """insira, na ordem, id_materia(int), id_bimestre(int) e turma(int) \n
    id_materia disponíveis:
portugues:	1
ingles:	2
artes:	3
matematica:	4
ciencias:	5
educacao_fisica:	6
ensino_religioso:	7
historia:	8
geografia:	9    

id_bimestre
1, 2, 3, 4  

Informações a serem fornecidas no payload: descricao_at, nota_5. O programa precisa
de dados de todos os alunos referentes àquela turma  
    """   
    db_ids = cursor.execute(f"""
    select id_aluno from tabela_alunos where turma = {turma}""")
    list_ids = db_ids.fetchall()
    list_ids = [x for y in list_ids for x in y]
    new_act = request.get_json(force=True)
    dic_ids = []
    for x in list_ids:
        dic_ids.append({
            'id_aluno': x
        })
    resultado = []
    print()
    #funcionando até aqui
    for i in range(max(len(dic_ids), len(new_act))):
        novo_dicionario = {}
    
        if i < len(dic_ids):
            novo_dicionario.update(dic_ids[i])
            print(f"esse é o novo dicionario no primeiro if {novo_dicionario}")
        
        if i < len(new_act):
            novo_dicionario.update(new_act[i])
            print(f"esse é o novo dicionario no segundo if {novo_dicionario}")
        
        resultado.append(novo_dicionario)
    print(f"esse é o conteúdo da variável resultado ############################ {resultado}")   
    for x in resultado:
        id_std = x['id_aluno']
        des_act =  x['descricao_at']
        print(f'esse é o {id_std}')
        gra_5 =  x['nota_5']
        print(f'essa é a nota_5 {gra_5}')
        
        cursor.execute(f"""
                    INSERT INTO tabela_avaliacao (id_aluno, id_materia, id_bimestre, descricao_at, nota_5, turma)
                    VALUES ({id_std},{id_bimestre}, {id_materia}, '{des_act}', {gra_5}, {turma})
                    """)
 
    cursor.commit()
           
    return jsonify(message = "dados inseridos", dados_inseridos = resultado)
    
@app.route('/diario/notas/atualizar/<int:id_avaliacao>', methods = ['PUT'])
def update_grades(id_avaliacao):
    """Atualiza uma atividade criada. Os campos disponíveis para atualização são:
    id_materia(int)= portugues:	1, ingles:	2, artes:	3, matematica:	4, ciencias: 5
    educacao_fisica: 6, ensino_religioso: 7, historia:	8, geografia:	9  
    id_bimestre(int)= 1, 2, 3, 4 
    nota_5(int) (em breve serão disponibilizadas todas as notas)
    descricao_at(str)   
    
    """
    up_obj = request.get_json(force=True)
    up_per = up_obj['id_bimestre']
    up_des = up_obj['descricao_at']
    up_gra_5 = up_obj['nota_5']
    up_sub = up_obj['id_materia']
    
    if up_per is not None and up_des is not None \
        and up_gra_5 is not None and up_sub is not None:
        cursor.execute(f"""UPDATE tabela_avaliacao SET id_materia = {up_sub} 
                       id_bimestre = {up_per},
                       descricao_at = '{up_des}', nota_5 = {up_gra_5} WHERE
                       id_avaliacao = {id_avaliacao}
                   """)        
    cursor.commit()
    up_obj.update({'id_avaliacao': id_avaliacao})
    return jsonify(message="Atividade atualizada", data = up_obj)
    
@app.route('/diario/notas/deletar/<int:id_avaliacao>', methods = ['DELETE'])
def delete_grades(id_avaliacao):
    """Insira o id de alguma atividade e ela será apagada"""
    cursor.execute(f"""DELETE FROM tabela_avaliacao WHERE id_avaliacao = {id_avaliacao}
                   """)
    cursor.commit()
    
    return jsonify(message=f"Atividade {id_avaliacao} apagada!", dado_deletado = id_avaliacao)      
               
               
app.run(debug=True)
