using Puc.Diario.ApiData.Interface;
using Puc.Diario.ApiData.Repository;
using Puc.Diario.Services.Interface;
using Puc.Diario.Services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Tests.Atividade
{
    public class AtividadeFixture
    {
        public IAtividadeService AtividadeService { get; }
        public IAtividadeRepository AtividadeRepository { get; }
        public IAvaliacaoService AvaliacaoService { get; }
        public IAlunoService AlunoService { get; }

        public AtividadeFixture()
        {
            AtividadeRepository = new AtividadeRepository();
            AtividadeService = new AtividadeService(AtividadeRepository, AlunoService, AvaliacaoService);
        }

        public void Dispose()
        {
            // Libere os recursos, se necessário
        }
    }
}
