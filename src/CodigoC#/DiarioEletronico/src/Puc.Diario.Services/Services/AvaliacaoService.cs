using Puc.Diario.ApiData.Interface;
using Puc.Diario.ApiData.Repository;
using Puc.Diario.Domain.Models.Avaliacao;
using Puc.Diario.Infra;
using Puc.Diario.Services.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Services.Services
{
    public class AvaliacaoService : IAvaliacaoService
    {
        private readonly IAvaliacaoRepository _avaliacaoRepository;
        public AvaliacaoService(IAvaliacaoRepository avaliacaoRepository)
        {
            _avaliacaoRepository = avaliacaoRepository;
        }

        public async Task<Avaliacao> InserirNota(Avaliacao av)
        {
            var avNota = new Avaliacao();
            var avaliacao = new List<Avaliacao>();
            var result = new Avaliacao();

            avaliacao = await ListarTodos();
            var avaliados = avaliacao.FirstOrDefault(x => x.IdAtividade == av.IdAtividade && x.IdAluno == av.IdAluno);

            if (avaliados == null && av.Total != null && av.Nota_5 != null)
            {
                avNota.IdMateria = av.IdMateria;
                avNota.IdAluno = av.IdAluno;
                avNota.IdAtividade = av.IdAtividade;
                avNota.IdBimestre = av.IdBimestre;
                avNota.Nota_5 = av.Nota_5;
                avNota.Total = av.Total;

                if (avNota != null)
                   result = await _avaliacaoRepository.Inserir(avNota);                
            }
            else
            {
                result = avaliados;
            }
            return result;
        }

        public async Task<List<Avaliacao>> ListarTodosPorAtvId(int idAtv)
        {
            try
            {
                var avaliacoes = await _avaliacaoRepository.ListarTodosPorAtvId(idAtv);
                var avaliacao = new List<Avaliacao>();

                foreach (var item in avaliacoes.Lista_total)
                {
                    var av = new Avaliacao()
                    {
                        IdMateria = item.IdMateria,
                        IdBimestre = item.IdBimestre,
                        IdAtividade = item.IdAtividade,
                        IdAluno = item.IdAluno,
                        IdAvaliacao = item.IdAvaliacao,
                        Nota_1 = item.Nota_1,
                        Nota_2 = item.Nota_2,
                        Nota_3 = item.Nota_3,
                        Nota_4 = item.Nota_4,
                        Nota_5 = item.Nota_5,
                        Total = item.Total
                    };

                    avaliacao.Add(av);
                }
                return avaliacao;
            }
            catch (Exception ex)
            {

                throw;
            }

        }

        public async Task<List<Avaliacao>> ListarTodosPorAlnId(int idAln)
        {
            try
            {
                var avaliacoes = await _avaliacaoRepository.ListarTodosPorAlnId(idAln);
                var avaliacao = new List<Avaliacao>();

                foreach (var item in avaliacoes.Lista_total)
                {
                    var av = new Avaliacao()
                    {
                        IdMateria = item.IdMateria,
                        IdBimestre = item.IdBimestre,
                        IdAtividade = item.IdAtividade,
                        IdAluno = item.IdAluno,
                        IdAvaliacao = item.IdAvaliacao,
                        Nota_1 = item.Nota_1,
                        Nota_2 = item.Nota_2,
                        Nota_3 = item.Nota_3,
                        Nota_4 = item.Nota_4,
                        Nota_5 = item.Nota_5,
                        Total = item.Total
                    };

                    avaliacao.Add(av);
                }
                return avaliacao;
            }
            catch (Exception ex)
            {

                throw;
            }

        }

        public async Task<List<Avaliacao>> ListarTodos()
        {
            try
            {
                var lista = await _avaliacaoRepository.ListarTodos();
                var avaliacao = new List<Avaliacao>();

                foreach (var item in lista.Lista_total)
                {
                    var av = new Avaliacao()
                    {
                        IdMateria = item.IdMateria,
                        IdBimestre = item.IdBimestre,
                        IdAtividade = item.IdAtividade,
                        IdAluno = item.IdAluno,
                        Nota_5 = item.Nota_5,
                        Total = item.Total,
                    };

                    avaliacao.Add(av);
                }
                return avaliacao;
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}
