using Puc.Diario.Domain.Models.Alunos;
using Puc.Diario.Domain.Models.Avaliacao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.ApiData.Interface
{
    public interface IAtividadeRepository
    {
        Task<ListaAtividades> ListarTodos();
        Task<Atividade> ListarPorId(int idAtv);
        Task<Atividade> Inserir(Atividade atv);
        Task<Atividade> Atualizar(Atividade atv, int idAividade);
        Task<object> AtualizarStatus(object avaliado, int idAtividade);
    }
}
