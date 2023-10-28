using Puc.Diario.ApiData.Interface;
using Puc.Diario.ApiData.Repository;
using Puc.Diario.Services.Interface;
using Puc.Diario.Services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Tests.Aluno
{
    public class AlunoFixture
    {
        public IAlunosRepository AlunosRepository { get; }
        public IAlunoService AlunoService { get; }

        public AlunoFixture()
        {
            AlunosRepository = new AlunosRepository();
            AlunoService = new AlunoService(AlunosRepository);
        }

        public void Dispose()
        {
            // Libere os recursos, se necessário
        }
    }
}
