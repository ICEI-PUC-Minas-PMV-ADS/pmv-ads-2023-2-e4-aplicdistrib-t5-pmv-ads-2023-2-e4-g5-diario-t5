using Puc.Diario.ApiData.Interface;
using Puc.Diario.ApiData.Repository;
using Puc.Diario.Domain.Models.Alunos;
using Puc.Diario.Domain.Models.Avaliacao;
using Puc.Diario.Infra;
using Puc.Diario.Services.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;
using System.Xml.Linq;

namespace Puc.Diario.Services.Services
{
    public class AtividadeService : IAtividadeService
    {
        private readonly IAtividadeRepository _atividadeRepository;
        private readonly IAlunoService _alunoService;
        private readonly IAvaliacaoService _avaliacaoService;
        public AtividadeService(IAtividadeRepository atividadeRepository, IAlunoService alunoService, IAvaliacaoService avaliacaoService)
        {
            _atividadeRepository = atividadeRepository;
            _avaliacaoService = avaliacaoService;
            _alunoService = alunoService;
        }   

        public async Task<Atividade> Inserir(string txtDesc, int txtMateria, int txtTurma, int txtBimestre)
        {
            var atividade = new Atividade();
            atividade.DescricaoAtv = txtDesc;
            atividade.IdMateria = txtMateria;
            atividade.Turma = txtTurma;
            atividade.IdBimestre = txtBimestre;

            var result = await _atividadeRepository.Inserir(atividade);

            return result;

        }

        public async Task<Atividade> Atualizar(int idAtividade, string txtDesc, int txtMateria, int txtTurma, int txtBimestre)
        {
            var atividade = new Atividade();
            atividade.IdMateria = txtMateria;
            atividade.Turma = txtTurma;
            atividade.IdBimestre = txtBimestre;
            atividade.DescricaoAtv = txtDesc;

            var result = await _atividadeRepository.Atualizar(atividade, idAtividade);

            return result;
        }

        public async Task<Atividade> ListarPorId(int id)
        {
            try
            {
                var aAtividade = new Atividade();

                if(id != 0)
                {
                    var atividade = await _atividadeRepository.ListarPorId(id);

                    if (atividade != null)
                    {
                        aAtividade.IdAtividade = atividade.IdAtividade;
                        aAtividade.IdMateria = atividade.IdMateria;
                        aAtividade.IdBimestre = atividade.IdBimestre;
                        aAtividade.Bimestre = Utils.NomeDoBimestre(atividade.Bimestre);
                        aAtividade.Materia = Utils.NomeDaMateria(atividade.Materia);
                        aAtividade.Turma = atividade.Turma;
                        aAtividade.DescricaoAtv = atividade.DescricaoAtv;
                        aAtividade.Status = atividade.Status;
                        aAtividade.DataAtv = atividade.DataAtv;
                    }
                }

                return aAtividade;                
            }
            catch (Exception ex)
            {
                return null;
            }           

        }

        public async Task<List<Atividade>> ListarTodos()
        {
            try
            {
                var lista = await _atividadeRepository.ListarTodos();
                var atividade = new List<Atividade>();

                foreach (var item in lista.ListaAtividade)
                {
                    var atv = new Atividade()
                    {
                        IdMateria = item.IdMateria,
                        IdBimestre = item.IdBimestre,
                        IdAtividade = item.IdAtividade,
                        DescricaoAtv = item.DescricaoAtv,
                        Turma = item.Turma,
                        Bimestre = Utils.NomeDoBimestre(item.Bimestre),
                        Materia = Utils.NomeDaMateria(item.Materia),
                        Status = item.Status,
                    };

                    atividade.Add(atv);
                }
                return atividade;
            }
            catch (Exception ex)
            {

                throw;
            }
            
        }

        public async Task<object> AtualizarStatus(object status, int idAtividade)
        {          

            var result = await _atividadeRepository.AtualizarStatus(status, idAtividade);

            return result;
        }

        public async Task<List<AlunoAvaliacao>> ListarAvaliacoesAlunos(int turma, int idAtividade)
        {
            List<Avaliacao> avaliacoes = await _avaliacaoService.ListarTodosPorAtvId(idAtividade);
            List<Aluno> alunos = await _alunoService.ListarTodos();
            var atv = await _atividadeRepository.ListarPorId(idAtividade);

            var listaAlunos = new List<AlunoAvaliacao>();

            foreach (var aluno in alunos.Where(x => x.Turma == turma && x.Status == true))
            {
                var dto = new AlunoAvaliacao();

                dto.IdAluno = aluno.IdAluno;
                dto.NomeCompleto = aluno.NomeCompleto;
                dto.Turma = aluno.Turma;

                if (avaliacoes.Count() > 0)
                {
                    var avaliacao = avaliacoes.FirstOrDefault(x => x.IdAluno == aluno.IdAluno);
                    if (avaliacao != null)
                    {
                        dto.Nota_5 = avaliacao.Nota_5;
                        dto.Total = avaliacao.Total;
                    }
                    else
                    {
                        dto.Nota_5 = null;
                        dto.Total = null;
                    }
                }
                else
                {
                    dto.Nota_5 = null;
                    dto.Total = null;
                }

                listaAlunos.Add(dto);
            }
            return listaAlunos;
        }
    }
}
