using Puc.Diario.Domain.Models.Alunos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.ApiData.Interface
{
    public interface IAlunosRepository
    {
        Task<ListaAlunos> ListarTodos();
        Task<Aluno> ListarPorId(int idAluno);
        Aluno ListarFiltrado(int idAluno, string ano, string nivel, string nome, string sobrenome, string nomeCompleto, string cpf, int idade);
        Task<Aluno> Inserir(Aluno aluno);
        Task<Aluno> AtivarInativar(int idAluno, int status);
        Task<Aluno> Atualizar(Aluno aluno, int idAluno);

        

    }
}
