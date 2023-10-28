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

namespace Puc.Diario.Tests.Avaliacao
{
    [Collection("AvaliacaoCollection")]
    public class AtividadeTests
    {
        private readonly AvaliacaoFixture _fixture;

        public AtividadeTests(AvaliacaoFixture fixture)
        {
            _fixture = fixture;
        }

        [Fact]
        public async void TesteListarTodos()
        {
            var avaliacao = await _fixture.AvaliacaoService.ListarTodos();
            Assert.NotNull(avaliacao);
            Assert.NotEmpty(avaliacao);
        }

        [Fact]
        public async Task DeveInserirNovaNotaNaTblAvaliacao()
        {
            // Arrange
            var av = new Puc.Diario.Domain.Models.Avaliacao.Avaliacao
            {
                IdMateria = 1,
                IdAluno = 234,
                IdAtividade = 186,
                IdBimestre = 1,
                Nota_5 = 8,
                Total = 10
            };
            var avaliacaoService = new AvaliacaoFixture();
                        
            var result = await avaliacaoService.AvaliacaoService.InserirNota(av);
            
            Assert.NotNull(result);
            Assert.Equal(av.IdMateria, result.IdMateria);
            Assert.Equal(av.IdAluno, result.IdAluno);
            Assert.Equal(av.IdAtividade, result.IdAtividade);
            Assert.Equal(av.IdBimestre, result.IdBimestre);
            Assert.Equal(av.Nota_5, result.Nota_5);
            Assert.Equal(av.Total, result.Total);
        }
    }
}
