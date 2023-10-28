using Newtonsoft.Json;
using Puc.Diario.ApiData.Interface;
using Puc.Diario.Domain.Models.Avaliacao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.ApiData.Repository
{
    public class AvaliacaoRepository : IAvaliacaoRepository
    {
        private readonly HttpClient _httpClient;

        public AvaliacaoRepository()
        {
            _httpClient = new HttpClient();
        }

        public async Task<Avaliacao> Inserir(Avaliacao nota)
        {
            try
            {
                var atividadeJson = JsonConvert.SerializeObject(nota);

                var content = new StringContent(atividadeJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await _httpClient.PostAsync("http://127.0.0.1:5000/diario/inserir/nota", content);

                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<DataAvaliacao>(responseContent);

                    return result.Avaliacao;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new Avaliacao();
            }
        }

        public async Task<ListaAvaliacao> ListarTodosPorAtvId(int idAtv)
        {
            try
            {
                HttpResponseMessage response = await _httpClient.GetAsync("http://127.0.0.1:5000/diario/avaliacao/atividade/" + idAtv);

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<ListaAvaliacao>(content);

                    return result;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new ListaAvaliacao();
            }
        }

        public async Task<ListaAvaliacao> ListarTodosPorAlnId(int idAln)
        {
            try
            {
                HttpResponseMessage response = await _httpClient.GetAsync("http://127.0.0.1:5000/diario/avaliacao/aluno/" + idAln);

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<ListaAvaliacao>(content);

                    return result;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new ListaAvaliacao();
            }
        }

        public async Task<ListaAvaliacao> ListarTodos()
        {
            try
            {
                HttpResponseMessage response = await _httpClient.GetAsync("http://127.0.0.1:5000/diario/avaliacao");

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<ListaAvaliacao>(content);

                    return result;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new ListaAvaliacao();
            }
        }
    }
}
