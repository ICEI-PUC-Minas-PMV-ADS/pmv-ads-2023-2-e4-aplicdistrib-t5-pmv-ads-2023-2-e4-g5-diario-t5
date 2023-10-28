using Moq;
using Puc.Diario.ApiData.Interface;
using Puc.Diario.ApiData.Repository;
using Puc.Diario.Domain.Models.Avaliacao;
using Puc.Diario.Services.Interface;
using Puc.Diario.Services.Services;
using Puc.Diario.Tests.Aluno;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Tests.Aluno
{
    [Collection("AlunoCollection")]
    public class AlunoTests
    {
        private readonly AlunoFixture _fixture;

        public AlunoTests(AlunoFixture fixture)
        {
            _fixture = fixture;
        }

        [Fact]
        public async void Listar_DeveListarTodos()
        {
            var aluno = await _fixture.AlunoService.ListarTodos();
            Assert.NotNull(aluno);
            Assert.NotEmpty(aluno);
        }


        [Fact]
        public async Task Inserir_DeveInserirAluno()
        {
            string name = "JoãoXunit";
            int idade = 15;
            string ano = "setimo";
            int turma = 1;
            string cpf = "12345678901";
            string nivel = "em";
            string sobrenome = "Silva";

            var result = await _fixture.AlunoService.Inserir(name, idade, ano, turma, nivel, sobrenome, cpf);

            Assert.NotNull(result); 

            Assert.Equal(name, result.Nome);
            Assert.Equal(idade, result.Idade);
            Assert.Equal(ano, result.Ano);
            Assert.Equal(turma, result.Turma);
            Assert.Equal(cpf, result.Cpf);
            Assert.Equal(nivel, result.NivelEnsino);
            Assert.Equal(sobrenome, result.Sobrenome);
        }

        [Fact]
        public async Task Atualizar_DeveAtualizarAluno()
        {
            int idAluno = 1242;
            string name = "Maria";
            int idade = 16;
            string ano = "sexto";
            int turma = 2;
            string cpf = "98765432101";
            string nivel = "em";
            string sobrenome = "Pereira";
            
            var result = await _fixture.AlunoService.Atualizar(idAluno, name, idade, ano, turma, nivel, sobrenome, cpf);

            Assert.NotNull(result); 

            Assert.Equal(name, result.Nome);
            Assert.Equal(idade, result.Idade);
            Assert.Equal(ano, result.Ano);
            Assert.Equal(turma, result.Turma);
            Assert.Equal(cpf, result.Cpf);
            Assert.Equal(nivel, result.NivelEnsino);
            Assert.Equal(sobrenome, result.Sobrenome);
        }
    }
}
