# Plano de Testes de Software

<span style="color:red">Pré-requisitos: <a href="2-Especificação do Projeto.md"> Especificação do Projeto</a></span>, <a href="3-Projeto de Interface.md"> Projeto de Interface</a>

Apresente os cenários de testes utilizados na realização dos testes da sua aplicação. Escolha cenários de testes que demonstrem os requisitos sendo satisfeitos.

Enumere quais cenários de testes foram selecionados para teste. Neste tópico o grupo deve detalhar quais funcionalidades avaliadas, o grupo de usuários que foi escolhido para participar do teste e as ferramentas utilizadas.
 
## Ferramentas de Testes (Opcional)

Comente sobre as ferramentas de testes utilizadas.
 
> **Links Úteis**:
> - [IBM - Criação e Geração de Planos de Teste](https://www.ibm.com/developerworks/br/local/rational/criacao_geracao_planos_testes_software/index.html)
> - [Práticas e Técnicas de Testes Ágeis](http://assiste.serpro.gov.br/serproagil/Apresenta/slides.pdf)
> -  [Teste de Software: Conceitos e tipos de testes](https://blog.onedaytesting.com.br/teste-de-software/)
> - [Criação e Geração de Planos de Teste de Software](https://www.ibm.com/developerworks/br/local/rational/criacao_geracao_planos_testes_software/index.html)
> - [Ferramentas de Test para Java Script](https://geekflare.com/javascript-unit-testing/)
> - [UX Tools](https://uxdesign.cc/ux-user-research-and-user-testing-tools-2d339d379dc7)

|*Caso de Teste      | *CT-01 – Cadastro de aluno            | 
|------------------|-------------------------------|
| Requisito Associado | RF-006 – Cadastrar informações dos alunos como nome, idade, nível de ensino, turma, Ano e outras informações relevantes. RF-007 – Permitir consultar alunos seguindo os critérios de nome, turma e ano.| 
|Objetivo do Teste|Verificar se a escola conseguirá cadastrar os alunos com suas respectivas características dentro da aplicação “Diário Eletrônico” seguindo os critérios estabelecidos.| 
|Passos   |1) Acessar a aplicação; 2) Visualizar a tela de “Cadastro de Aluno”; 3) Preencher os campos com as informações solicitadas; 4) Clicar em “incluir”.| 
| Critério de Êxito| Verificar na aba “Lista de alunos” se o aluno foi adicionado com sucesso.| 
