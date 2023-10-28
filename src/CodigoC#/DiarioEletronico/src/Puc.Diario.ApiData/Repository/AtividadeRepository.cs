using Newtonsoft.Json;
using Puc.Diario.ApiData.Interface;
using Puc.Diario.Domain.Models.Alunos;
using Puc.Diario.Domain.Models.Avaliacao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Puc.Diario.ApiData.Repository
{
    public class AtividadeRepository : IAtividadeRepository
    {
        private readonly HttpClient _httpClient;

        public AtividadeRepository()
        {
            _httpClient = new HttpClient();
        }
        public async Task<ListaAtividades> ListarTodos()
        {
            try
            {
                HttpResponseMessage response = await _httpClient.GetAsync("http://127.0.0.1:5000/diario/atividades");

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<ListaAtividades>(content);

                    return result;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new ListaAtividades();
            }
        }

        public async Task<Atividade> ListarPorId(int idAtv)
        {
            try
            {
                HttpResponseMessage response = await _httpClient.GetAsync("http://127.0.0.1:5000/diario/atividade/" + idAtv);

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<DataAtividades>(content).Atividade;

                    return result;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new Atividade();
            }
        }
        public async Task<Atividade> Inserir(Atividade atv)
        {
            try
            {
                var atividadeJson = JsonConvert.SerializeObject(atv);

                var content = new StringContent(atividadeJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await _httpClient.PostAsync("http://127.0.0.1:5000/diario/inserir/atividades", content);

                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<DataAtividades>(responseContent);

                    return result.Atividade;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new Atividade();
            }

        }

        public async Task<Atividade> Atualizar(Atividade atv, int idAtividade)
        {
            try
            {
                var atividadeJson = JsonConvert.SerializeObject(atv);

                var content = new StringContent(atividadeJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await _httpClient.PutAsync("http://127.0.0.1:5000/diario/atualizar/" + idAtividade, content);

                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<DataAtividades>(responseContent);

                    return result.Atividade;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new Atividade();
            }
        }

        public async Task<object> AtualizarStatus(object status, int idAtividade )
        {
            try
            {
                var atividadeJson = JsonConvert.SerializeObject(status);

                var content = new StringContent(atividadeJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await _httpClient.PutAsync("http://127.0.0.1:5000/diario/atualizar/status/" + idAtividade, content);

                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<object>(responseContent);

                    return result;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}
