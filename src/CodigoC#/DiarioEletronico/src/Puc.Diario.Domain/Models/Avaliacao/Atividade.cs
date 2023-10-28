using Newtonsoft.Json;

namespace Puc.Diario.Domain.Models.Avaliacao
{
    [Serializable]
    public class Atividade
    {
        [JsonProperty("id_atividade")]
        public int IdAtividade { get; set; }

        [JsonProperty("id_materia")]
        public int? IdMateria { get; set; }

        [JsonProperty("id_bimestre")]
        public int? IdBimestre { get; set; }

        [JsonProperty("turma")]
        public int? Turma { get; set; }

        [JsonProperty("bimestre")]
        public string Bimestre { get; set; } 

        [JsonProperty("materia")]
        public string Materia { get; set; }

        [JsonProperty("descricao_at")]
        public string? DescricaoAtv { get; set; }

        [JsonProperty("atv_status")]
        public bool? Status { get; set; }

        [JsonProperty("data_cadastro_atv")]
        public DateTime? DataAtv { get; set; }

    }

    [Serializable]
    public class ListaAtividades
    {
        [JsonProperty("lista_total")]
        public List<Atividade>? ListaAtividade { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }
    }

    [Serializable]
    public class DataAtividades
    {
        [JsonProperty("data")]
        public Atividade? Atividade { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }
    }

}
