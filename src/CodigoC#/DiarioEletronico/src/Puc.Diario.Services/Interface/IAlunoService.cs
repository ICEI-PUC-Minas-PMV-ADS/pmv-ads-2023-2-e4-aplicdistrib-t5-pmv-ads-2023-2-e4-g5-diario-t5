using Puc.Diario.Domain.Models.Alunos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Services.Interface
{
    public interface IAlunoService
    {
        Task<List<Aluno>> ListarTodos();
        Task<Aluno> ListarPorId(int id);
        Task<Aluno> Inserir(string name, int idade, string ano, int turma, string nivel, string sobrenome, string cpf);
        Task<Aluno> Atualizar(int idAluno, string name, int idade, string ano, int turma, string nivel, string sobrenome, string cpf);
        Task<Aluno> AtivarInativar(int idAluno, int status);
    }
}
