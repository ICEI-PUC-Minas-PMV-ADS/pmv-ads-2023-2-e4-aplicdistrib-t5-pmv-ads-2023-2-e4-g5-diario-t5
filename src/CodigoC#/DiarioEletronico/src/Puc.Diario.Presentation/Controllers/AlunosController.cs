using Humanizer;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Puc.Diario.Domain.Models.Alunos;
using Puc.Diario.Infra;
using Puc.Diario.Services.Interface;
using Puc.Diario.Services.Services;
using System.Dynamic;
using System.Numerics;
using System.Reflection.Metadata;
using System.Xml.Linq;

namespace Puc.Diario.Presentation.Controllers
{
    public class AlunosController : Controller
    {
        private readonly IAlunoService _alunoService;
        private readonly IAtividadeService _atividadeService;
        public AlunosController(IAlunoService alunoService, IAtividadeService atividadeService)
        {
            _alunoService = alunoService;
            _atividadeService = atividadeService;
        }

        [HttpGet("/Alunos/GetAlunosLista")]
        public async Task<IActionResult> GetAlunosLista()
        {
            List<Aluno> alunos = await _alunoService.ListarTodos();
            return Ok(new { data = alunos});
        }

        // GET: AlunosController
        public async Task<ActionResult> Alunos()
        {
            return View("alunos_lst");
        }


        public async Task<ActionResult> Register(int idAluno = 0, bool flEdit = true, bool outraPagina = false)
        {
            try
            {
                var aluno = await _alunoService.ListarPorId(idAluno);
                if(aluno != null)
                    aluno.Cpf = !flEdit? Utils.FormataCPF(aluno.Cpf) : aluno.Cpf;

                ViewBag.flEdit = flEdit;
                ViewBag.AnoComboEM = new SelectList(Utils.ComboAno(), "Value", "Text");
                ViewBag.NivelCombo = new SelectList(Utils.ComboNivel(), "Value", "Text");
                ViewBag.Turma = new SelectList(Utils.ComboTurma(), "Value", "Text");
                ViewBag.outraPagina = outraPagina;

                return View("alunos_reg", aluno);
            }
            catch (Exception ex)
            {
                return null;
            }
           
        }

        // GET: AlunosController/Create
        public async Task<IActionResult> Salvar(int? hdnIdAluno, string txtName, int txtIdade, string txtAno, int txtTurma, string txtNivel, string txtSobrenome, string txtCpf)
        {
            try
            {
               
                bool sucesso = false;
                if (hdnIdAluno != null && hdnIdAluno > 0)
                {
                    var aluno = await _alunoService.Atualizar((int)hdnIdAluno, txtName, txtIdade, txtAno, txtTurma, txtNivel, txtSobrenome, txtCpf);
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
                    var aluno = await _alunoService.Inserir(txtName, txtIdade, txtAno, txtTurma, txtNivel, txtSobrenome, txtCpf);

                    dynamic statusAtv = new ExpandoObject();
                    statusAtv.atv_status = false;
                    var atvs = await _atividadeService.ListarTodos();

                    foreach (var atv in atvs.Where(x => x.Turma == aluno.Turma))
                    {
                        await _atividadeService.AtualizarStatus(statusAtv, atv.IdAtividade);
                    }

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

        public async Task<IActionResult> AtivarInativar(int idAluno, int status)
        {
            try
            {
                bool sucesso = false;
                var aluno = await _alunoService.AtivarInativar(idAluno, status);

                if (aluno != null)
                    sucesso = true;

                return Ok(new
                {
                    sucesso = sucesso,
                    message = "Registro inativado com sucesso.",
                    registro = aluno
                });
            }
            catch (Exception ex)
            {
                return BadRequest("Erro ao Salvar");
            }
        }
    }
}
