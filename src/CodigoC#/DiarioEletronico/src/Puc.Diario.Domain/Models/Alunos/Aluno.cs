using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Domain.Models.Alunos
{
    [Serializable]
    public class Aluno
    {
        [JsonProperty("id_aluno")]
        public int IdAluno { get; set; }

        [JsonProperty("nome")]
        public string Nome { get; set; }

        [JsonProperty("sobrenome")]
        public string Sobrenome { get; set; }

        [JsonProperty("nome_completo")]
        public string NomeCompleto { get; set; }

        [JsonProperty("ano")]
        public string Ano { get; set; }

        [JsonProperty("nivel_ensino")]
        public string? NivelEnsino { get; set; }

        [JsonProperty("idade")]
        public int? Idade { get; set; }

        [JsonProperty("cpf")]
        public string? Cpf { get; set; }

        [JsonProperty("turma")]
        public int Turma { get; set; }

        [JsonProperty("status_aluno")]
        public bool Status { get; set; } = true;

        [JsonProperty("data_cadastro_aln")]
        public DateTime DataAln { get; set; }
    }

    [Serializable]
    public class ListaAlunos
    {
        [JsonProperty("lista_total")]
        public List<Aluno>? ListaAluno { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }
    }

    [Serializable]
    public class DataAluno
    {
        [JsonProperty("data")]
        public Aluno? Aluno { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }
    }

    //classe para registro de avaliacao
    [Serializable]
    public class AlunoAvaliacao
    {
        [JsonProperty("id_aluno")]
        public int IdAluno { get; set; }

        [JsonProperty("nome_completo")]
        public string NomeCompleto { get; set; }

        [JsonProperty("turma")]
        public int Turma { get; set; }

        [JsonProperty("nota_5")]
        public float? Nota_5 { get; set; }

        [JsonProperty("total")]
        public float? Total { get; set; }
    }
}
