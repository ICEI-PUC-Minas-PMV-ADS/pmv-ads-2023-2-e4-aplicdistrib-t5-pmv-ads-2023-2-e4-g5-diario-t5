using Puc.Diario.ApiData.Interface;
using Puc.Diario.Domain.Models.Alunos;
using Puc.Diario.Infra;
using Puc.Diario.Services.Interface;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Puc.Diario.Services.Services
{
    public class AlunoService : IAlunoService
    {
        private readonly IAlunosRepository _alunosRepo;
        public AlunoService(IAlunosRepository alunosRepo)
        {
            _alunosRepo = alunosRepo;
        }
        public async Task<List<Aluno>> ListarTodos()
        {
            try
            {
                var lista = await _alunosRepo.ListarTodos();
                var alunos = new List<Aluno>();

                foreach (var item in lista.ListaAluno)
                {
                    var alunoModel = new Aluno()
                    {
                        IdAluno = item.IdAluno,
                        Nome = item.Nome,
                        Sobrenome = item.Sobrenome,
                        NomeCompleto = item.NomeCompleto,
                        Idade = item.Idade,
                        NivelEnsino = item.NivelEnsino,
                        Turma = item.Turma,
                        Status = item.Status,
                        Ano = item.Ano,
                        DataAln = item.DataAln,
                        Cpf = item.Cpf
                    };
                    alunoModel.Ano = Utils.ConvertAnoNivel(alunoModel.Ano);
                    alunoModel.NivelEnsino = Utils.ConvertAnoNivel(alunoModel.NivelEnsino);
                    alunos.Add(alunoModel);
                }
                return alunos;
            }
            catch (Exception ex)
            {

                throw;
            }        
        }

        public async Task<Aluno> ListarPorId(int id)
        {
            try
            {
                var oAluno = new Aluno();
                if(id != 0)
                {
                    var aluno = await _alunosRepo.ListarPorId(id);

                    if (aluno != null)
                    {
                        oAluno.IdAluno = aluno.IdAluno;
                        oAluno.Nome = aluno.Nome;
                        oAluno.Sobrenome = aluno.Sobrenome;
                        oAluno.NomeCompleto = aluno.NomeCompleto;
                        oAluno.Cpf = aluno.Cpf;
                        oAluno.Idade = aluno.Idade;
                        oAluno.NivelEnsino = Utils.ConvertAnoNivel(aluno.NivelEnsino);
                        oAluno.Ano = Utils.ConvertAnoNivel(aluno.Ano);
                        oAluno.Turma = aluno.Turma;
                        oAluno.Status = aluno.Status;
                        oAluno.DataAln = aluno.DataAln;
                    }
                }
               
                return oAluno;
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public async Task<Aluno> Inserir(string name, int idade, string ano, int turma, string nivel, string sobrenome, string cpf)
        {
            var aluno = new Aluno();
            aluno.Nome = name;
            aluno.Idade = idade;
            aluno.Ano = ano;
            aluno.Turma = turma;
            aluno.Cpf = cpf;
            aluno.NivelEnsino = nivel;
            aluno.Sobrenome = sobrenome; 

            var result = await _alunosRepo.Inserir(aluno);
        
            return result;

        }

        public async Task<Aluno> Atualizar(int idAluno, string name, int idade, string ano, int turma, string nivel, string sobrenome, string cpf)
        {
            var aluno = new Aluno();
            aluno.Nome = name;
            aluno.Idade = idade;
            aluno.Ano = ano;
            aluno.Turma = turma;
            aluno.Cpf = cpf;
            aluno.NivelEnsino = nivel;
            aluno.Sobrenome = sobrenome;

            var result = await _alunosRepo.Atualizar(aluno, idAluno);

            return result;
        }

        public async Task<Aluno> AtivarInativar(int idAluno, int status)
        {
            var result = await _alunosRepo.AtivarInativar(idAluno, status);

            return result;
        }
    }
}
