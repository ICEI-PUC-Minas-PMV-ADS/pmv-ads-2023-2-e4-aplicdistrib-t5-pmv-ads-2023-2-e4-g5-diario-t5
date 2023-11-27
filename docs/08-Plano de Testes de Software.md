# Plano de Testes de Software
Diante dos cenários apresentados e analisando os requisitos do projeto, foi realizado o plano de teste de software da aplicação. 

|*Caso de Teste      | *CT-01 – Cadastro            | 
|------------------|-------------------------------|
| Requisito Associado | RF-001 – A aplicação deverá conter uma tela de cadastro para acesso à aplicação | 
|Objetivo do Teste| Verificar se o usuário consegue se cadastrar na aplicação com sucesso e acessar a tela home com todas as funcionalidades disponíveis.| 
|Passos   |1) Acesse a aplicação; 2) Visualizar a tela principal de “Cadastro”; 3) Preencher os campos com as informações solicitadas de login e senha; 4) Clique em “Cadastrar”.| 
| Critério de Êxito| - Verificar se a mensagem “Usuário criado sucesso!” apareceu na tela de cadastro.|

|*Caso de Teste      | * CT-02 – Login           | 
|------------------|-------------------------------|
| Requisito Associado | RF-002 - O aplicativo deverá conter uma tela de login para acessar o aplicativo. | 
|Objetivo do Teste| Verificar se o usuário consegue fazer o Login corretamente na aplicação após realização do cadastro. | 
|Passos   |1) Acesse a aplicação; 2) Visualizar a tela de “Login”; 3) Preencher os campos com as informações solicitadas de login e senha; 4) Clique em “Entrar”. | 
| Critério de Êxito| - Verificar se o login foi realizado com sucesso. - O login e senha cadastrada devem direcionar o usuário para a tela home da aplicação. - Login e/ou senha incorretas devem exibir uma mensagem de “Usuário e/ou senha incorreto(s)”. |

|*Caso de Teste      | *CT-03 – Cadastro de aluno            | 
|------------------|-------------------------------|
| Requisito Associado | RF-006 – Cadastrar informações dos alunos como nome, idade, nível de ensino, turma, Ano e outras informações relevantes. RF-007 – Permitir consultar alunos seguindo os critérios de nome, turma e ano.| 
|Objetivo do Teste|Verificar se a escola conseguirá cadastrar os alunos com suas respectivas características dentro da aplicação “Diário Eletrônico” seguindo os critérios estabelecidos.| 
|Passos   |1) Acessar a aplicação; 2) Visualizar a tela de “Cadastro de Aluno”; 3) Preencher os campos com as informações solicitadas; 4) Clicar em “incluir”.| 
| Critério de Êxito| Verificar na aba “Lista de alunos” se o aluno foi adicionado com sucesso.| 

|*Caso de Teste      | *CT-04 – Cadastro de atividades           | 
|------------------|-------------------------------|
| Requisito Associado | RF-004 – Permitir aos professores cadastrarem atividades levando em consideração o assunto, matéria, bimestre e turma. RF-005 – Permitir consulta de atividades relacionadas a matéria lecionada.| 
|Objetivo do Teste|Verificar se o professor conseguirá cadastrar as atividades com sucesso dentro da aplicação “Diário Eletrônico” seguindo os critérios estabelecidos.| 
|Passos   |1) Acessar a aplicação; 2) Visualizar a tela de “Cadastro de atividades”; 3) Preencher os campos com as informações solicitadas; 4) Clicar em “incluir”.| 
| Critério de Êxito| Verificar na aba “Lista de atividades” se a atividade descrita foi adicionada com sucesso.| 

|*Caso de Teste      | *CT-05 – Cadastro de notas            | 
|------------------|-------------------------------|
| Requisito Associado | RF-008 – Permitir lançamento de notas do aluno na sua respectiva matéria cursada.| 
|Objetivo do Teste|Verificar se a nota do aluno foi lançada diante dos critérios pré-estabelecidos para lançamento.| 
|Passos   |1) Acessar a aplicação; 2) Visualizar a tela de “Visualizar atividade”; 3) Identificar o aluno; 4) Confirmar as informações da matéria cadastradas; 5) Incluir a nota para o respectivo aluno.| 
| Critério de Êxito| Verificar se a nota foi incluída para o respectivo aluno selecionado.| 
