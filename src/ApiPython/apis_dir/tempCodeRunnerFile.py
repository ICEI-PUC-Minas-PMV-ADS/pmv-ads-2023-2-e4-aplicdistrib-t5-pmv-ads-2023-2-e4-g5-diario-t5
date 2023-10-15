
cursor.execute(f"""create table tabela_frequencia (
   id_aluno int,
   id_materia int, 
   id_bimestre int,
   turma int ,
   data_aula datetime,
   descricao_aula nvarchar(150),
   habilidade_bncc text, 
   presente bit) """)
