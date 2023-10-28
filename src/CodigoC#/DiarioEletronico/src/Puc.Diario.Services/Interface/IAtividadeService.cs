using Puc.Diario.Domain.Models.Alunos;
using Puc.Diario.Domain.Models.Avaliacao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Services.Interface
{
    public interface IAtividadeService
    {
        Task<List<Atividade>> ListarTodos();
        Task<Atividade> ListarPorId(int id);
        Task<Atividade> Inserir(string txtDesc, int txtMateria, int txtTurma, int txtBimestre);
        Task<Atividade> Atualizar(int idAtividade, string txtDesc, int txtMateria, int txtTurma, int txtBimestre);
        Task<object> AtualizarStatus(object avaliadon, int idAtividade);

        Task<List<AlunoAvaliacao>> ListarAvaliacoesAlunos(int turma, int idAtividade);
        //Task<Atividade> AtivarInativar(int idAluno, int status);
    }
}
