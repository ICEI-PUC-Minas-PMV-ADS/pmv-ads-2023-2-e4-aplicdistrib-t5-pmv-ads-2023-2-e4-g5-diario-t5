using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.Domain.Models.Avaliacao
{
    public class Avaliacao
    {
        [JsonProperty("id_avaliacao")]
        public int IdAvaliacao { get; set; }

        [JsonProperty("id_aluno")]
        public int IdAluno { get; set; }

        [JsonProperty("id_materia")]
        public int IdMateria { get; set; }

        [JsonProperty("id_bimestre")]
        public int IdBimestre { get; set; }

        [JsonProperty("id_atividade")]
        public int IdAtividade { get; set; }

        [JsonProperty("nota_1")]
        public float? Nota_1 { get; set; }

        [JsonProperty("nota_2")]
        public float? Nota_2 { get; set; }

        [JsonProperty("nota_3")]
        public float? Nota_3 { get; set; }

        [JsonProperty("nota_4")]
        public float? Nota_4 { get; set; }

        [JsonProperty("nota_5")]
        public float? Nota_5 { get; set; }

        [JsonProperty("total")]
        public float? Total { get; set; }
    }

    public class ListaAvaliacao
    {
        [JsonProperty("lista_total")]
        public List<Avaliacao>? Lista_total { get; set; }

        [JsonProperty("message")]
        public string? Message { get; set; }
    }

    [Serializable]
    public class DataAvaliacao
    {
        [JsonProperty("data")]
        public Avaliacao? Avaliacao { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }
    }

    [Serializable]
    public class AvaliacaoNota
    {
        [JsonProperty("id_aluno")]
        public int IdAluno { get; set; }

        [JsonProperty("id_materia")]
        public string IdMateria { get; set; }

        [JsonProperty("id_bimestre")]
        public int IdBimestre { get; set; }

        [JsonProperty("id_atividade")]
        public float? IdAtividade { get; set; }

        [JsonProperty("nota_5")]
        public float? Nota { get; set; }

        [JsonProperty("total")]
        public float? Total { get; set; }
    }

}
