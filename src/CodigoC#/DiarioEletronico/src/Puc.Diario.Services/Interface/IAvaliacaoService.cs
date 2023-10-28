using Puc.Diario.Domain.Models.Avaliacao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Services.Interface
{
    public interface IAvaliacaoService
    {
        Task<List<Avaliacao>> ListarTodosPorAtvId(int idAtv);
        Task<List<Avaliacao>> ListarTodosPorAlnId(int idAtv);
        Task<Avaliacao> InserirNota(Avaliacao av);
        Task<List<Avaliacao>> ListarTodos();
    }
}
