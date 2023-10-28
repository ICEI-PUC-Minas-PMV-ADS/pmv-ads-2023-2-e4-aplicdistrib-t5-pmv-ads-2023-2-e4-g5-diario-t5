using Moq;
using Puc.Diario.ApiData.Interface;
using Puc.Diario.ApiData.Repository;
using Puc.Diario.Domain.Models.Avaliacao;
using Puc.Diario.Services.Interface;
using Puc.Diario.Services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Tests.Atividade
{
    [Collection("AtividadeCollection")]
    public class AtividadeTests
    {
        private readonly AtividadeFixture _fixture;

        public AtividadeTests(AtividadeFixture fixture)
        {
            _fixture = fixture;
        }

        [Fact]
        public async void Listar_DeveListarTodos()
        {
            var atividade = await _fixture.AtividadeService.ListarTodos();
            Assert.NotNull(atividade);
            Assert.NotEmpty(atividade);
        }

        [Fact]
        public async Task Inserir_DeveInserirAtividade()
        {
            string txtDesc = "Exemplo de descrição";
            int txtMateria = 1;
            int txtTurma = 2;
            int txtBimestre = 3;

            var result = await _fixture.AtividadeService.Inserir(txtDesc, txtMateria, txtTurma, txtBimestre);
            
            Assert.NotNull(result);                    
            
            Assert.Equal(txtDesc, result.DescricaoAtv);
            Assert.Equal(txtMateria, result.IdMateria);
            Assert.Equal(txtTurma, result.Turma);
            Assert.Equal(txtBimestre, result.IdBimestre);
        }

        [Fact]
        public async Task Atualizar_DeveAtualizarAtividade()
        {
            int idAtividade = 186;
            string txtDesc = "Nova descrição";
            int txtMateria = 2;
            int txtTurma = 3;
            int txtBimestre = 4;

            var result = await _fixture.AtividadeService.Atualizar(idAtividade, txtDesc, txtMateria, txtTurma, txtBimestre);
            
            Assert.NotNull(result);             

            Assert.Equal(idAtividade, result.IdAtividade);
            Assert.Equal(txtDesc, result.DescricaoAtv);
            Assert.Equal(txtMateria, result.IdMateria);
            Assert.Equal(txtTurma, result.Turma);
            Assert.Equal(txtBimestre, result.IdBimestre);
        }
    }
}
