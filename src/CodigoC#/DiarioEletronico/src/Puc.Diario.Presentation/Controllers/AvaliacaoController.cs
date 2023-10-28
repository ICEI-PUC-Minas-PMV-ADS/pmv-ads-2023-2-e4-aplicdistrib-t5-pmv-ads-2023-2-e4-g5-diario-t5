using Humanizer;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Puc.Diario.ApiData.Interface;
using Puc.Diario.Domain.Models.Alunos;
using Puc.Diario.Domain.Models.Avaliacao;
using Puc.Diario.Infra;
using Puc.Diario.Services.Interface;
using Puc.Diario.Services.Services;
using System.Dynamic;
using System.Globalization;

namespace Puc.Diario.Presentation.Controllers
{
    public class AvaliacaoController : Controller
    {
        private readonly IAtividadeService _atividadeService;
        private readonly IAlunoService _alunoService;
        private readonly IAvaliacaoService _avaliacaoService;
        public AvaliacaoController
        (
            IAtividadeService atividadeService, 
            IAlunoService alunoService, 
            IAvaliacaoService avaliacaoService 
        )

        {
            _atividadeService = atividadeService;
            _alunoService = alunoService;
            _avaliacaoService = avaliacaoService;
        }

        //posso colocar que ao inserir um aluno eu pegue as atividades dessa turma e jogo o status pra em avaliacao
        [HttpGet("/Avaliacao/GetAtividadesLista")]
        public async Task<IActionResult> GetAtividadesLista()
        {
            List<Atividade> atividades = await _atividadeService.ListarTodos();
            return Ok(new { data = atividades });
        }

        public ActionResult Avaliacao()
        {
            return View("avaliacao_lst");
        }

        public async Task<ActionResult> Register(int idAtividade = 0, bool flEdit = true)
        {
            try
            {                
                var atividade = await _atividadeService.ListarPorId(idAtividade);               

                ViewBag.flEdit = flEdit;
                ViewBag.Turma = new SelectList(Utils.ComboTurma(), "Value", "Text");
                ViewBag.Materia = new SelectList(Utils.ComboMateria(), "Value", "Text");
                ViewBag.Bimestre = new SelectList(Utils.ComboBimestre(), "Value", "Text");

                return View("avaliacao_reg", atividade);
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        public async Task<IActionResult> Salvar(int? hdnIdAtividade, string txtDesc, int txtMateria, int txtTurma, int txtBimestre)
        {
            try
            {
                bool sucesso = false;
                if (hdnIdAtividade != null && hdnIdAtividade > 0)
                {
                    var aluno = await _atividadeService.Atualizar((int)hdnIdAtividade, txtDesc, txtMateria, txtTurma, txtBimestre);
                    if (aluno != null)
                        sucesso = true;

                    return Ok(new
                    {
                        sucesso = sucesso,
                        message = "Registro atualizado com sucesso.",
                        registro = aluno
                    });
                }
                else
                {
                    var aluno = await _atividadeService.Inserir(txtDesc, txtMateria, txtTurma, txtBimestre);
                    if (aluno != null)
                        sucesso = true;

                    return Ok(new
                    {
                        sucesso = sucesso,
                        message = "Registro incluído com sucesso.",
                        registro = aluno
                    });

                }
            }
            catch (Exception ex)
            {
                return BadRequest("Erro ao Salvar");
            }

        }

        [HttpGet("/Alunos/GetAlunosListaAvaliacao")]
        public async Task<IActionResult> GetAlunosListaAvaliacao(int turma, int idAtividade)
        {
            var listaAlunos = await _atividadeService.ListarAvaliacoesAlunos(turma, idAtividade);

            return Ok(new { data = listaAlunos });
        }


        public async Task<IActionResult> InserirNotas(List<Avaliacao> notas, int hdnAtvId, bool notasVazias)
        {
            var result = new Avaliacao();
            dynamic statusAtv = new ExpandoObject();
            try
            {
                foreach (var nota in notas)
                    result = await _avaliacaoService.InserirNota(nota);

                statusAtv.atv_status = (!notasVazias) ? true : false;
                await _atividadeService.AtualizarStatus(statusAtv, hdnAtvId);

                return Ok(new
                {
                    sucesso = true,
                    message = "Avaliação realizada com sucesso",
                    registro = hdnAtvId
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new
                {
                    sucesso = false,
                    message = "Um erro ocorreu contate o administrador do sistema",
                    error = ex.Message
                });
            }
        }


    }
}
