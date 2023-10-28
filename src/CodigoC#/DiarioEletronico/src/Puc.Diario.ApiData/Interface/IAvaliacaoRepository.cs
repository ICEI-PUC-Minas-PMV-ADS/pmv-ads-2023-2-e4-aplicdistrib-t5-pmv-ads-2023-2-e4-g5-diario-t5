using Puc.Diario.Domain.Models.Avaliacao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.ApiData.Interface
{
    public interface IAvaliacaoRepository
    {

        Task<Avaliacao> Inserir(Avaliacao nota);
        Task<ListaAvaliacao> ListarTodosPorAtvId(int idAtv);
        Task<ListaAvaliacao> ListarTodosPorAlnId(int idAln);
        Task<ListaAvaliacao> ListarTodos();
    }
}


