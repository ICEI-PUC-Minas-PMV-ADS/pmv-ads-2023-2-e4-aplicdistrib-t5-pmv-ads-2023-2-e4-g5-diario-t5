using Puc.Diario.ApiData.Interface;
using Puc.Diario.ApiData.Repository;
using Puc.Diario.Services.Interface;
using Puc.Diario.Services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Tests.Avaliacao
{
    public class AvaliacaoFixture
    {
        public IAvaliacaoService AvaliacaoService { get; }
        public IAvaliacaoRepository AvaliacaoRepository { get; }

        public AvaliacaoFixture()
        {
            AvaliacaoRepository = new AvaliacaoRepository(); 
            AvaliacaoService = new AvaliacaoService(AvaliacaoRepository); 
        }

        public void Dispose()
        {
            // Libere os recursos, se necessário
        }
    }
}
