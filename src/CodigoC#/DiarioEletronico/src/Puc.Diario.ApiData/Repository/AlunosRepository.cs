using Newtonsoft.Json;
using Puc.Diario.ApiData.Interface;
using Puc.Diario.Domain.Models.Alunos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Puc.Diario.ApiData.Repository
{
    public class AlunosRepository : IAlunosRepository
    {
        private readonly HttpClient _httpClient;

        public AlunosRepository()
        {
            _httpClient = new HttpClient();
        }

        public Aluno ListarFiltrado(int idAluno, string ano, string nivel, string nome, string sobrenome, string nomeCompleto, string cpf, int idade)
        {
            throw new NotImplementedException();
        }

        public async Task<Aluno> ListarPorId(int idAluno)
        {
            try
            {
                HttpResponseMessage response = await _httpClient.GetAsync("http://127.0.0.1:5000/diario/aluno/" + idAluno);

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<DataAluno>(content).Aluno;

                    return result;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new Aluno();
            }
        }

        public async Task<ListaAlunos> ListarTodos()
        {
            try
            {
                HttpResponseMessage response = await _httpClient.GetAsync("http://127.0.0.1:5000/diario");

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<ListaAlunos>(content);

                    return result; 
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new ListaAlunos();
            } 
        }

        public async Task<Aluno> Inserir(Aluno aluno)
        {
            try
            {
                var alunoJson = JsonConvert.SerializeObject(aluno);

                var content = new StringContent(alunoJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await _httpClient.PostAsync("http://127.0.0.1:5000/diario/inserir", content);

                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<DataAluno>(responseContent);

                    return result.Aluno;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new Aluno();
            }

        }
        public async Task<Aluno> Atualizar(Aluno aluno, int idAluno)
        {
            try
            {
                var alunoJson = JsonConvert.SerializeObject(aluno);

                var content = new StringContent(alunoJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await _httpClient.PutAsync("http://127.0.0.1:5000/diario/atualizar/aluno/" + idAluno, content);

                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<DataAluno>(responseContent);

                    return result.Aluno;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new Aluno();
            }
        }

        public async Task<Aluno> AtivarInativar(int idAluno, int status)
        {
            try
            {
                HttpResponseMessage response = await _httpClient.PutAsync($"http://127.0.0.1:5000/diario/deletar/{idAluno}/{status}" , null);

                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var result = JsonConvert.DeserializeObject<DataAluno>(responseContent);

                    return result.Aluno;
                }
                else
                {
                    throw new Exception("A solicitação à API falhou com o status: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                return new Aluno();
            }
        }

    }
}
