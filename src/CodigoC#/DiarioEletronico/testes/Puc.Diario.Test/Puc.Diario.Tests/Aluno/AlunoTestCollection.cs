using Puc.Diario.Tests.Aluno;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Tests.Aluno
{
    [CollectionDefinition("AlunoCollection")]
    public class AlunoTestCollection : ICollectionFixture<AlunoFixture>
    {
    }
}
