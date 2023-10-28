using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Puc.Diario.ApiData.Interface;
using Puc.Diario.ApiData.Repository;
using Puc.Diario.Services.Interface;
using Puc.Diario.Services.Services;

namespace Puc.Diario.Infra.InjecaoDependencia
{
    public static class ResolveInjecao
    {
        public static IServiceCollection DepInjection(this IServiceCollection services, IConfiguration configuration)
        {

            #region Repositorio
            services.AddTransient<IAlunosRepository, AlunosRepository>();
            services.AddTransient<IAtividadeRepository, AtividadeRepository>();
            services.AddTransient<IAvaliacaoRepository, AvaliacaoRepository>();
            #endregion

            #region Services
            services.AddTransient<IAlunoService, AlunoService>();
            services.AddTransient<IAtividadeService, AtividadeService>();
            services.AddTransient<IAvaliacaoService, AvaliacaoService>();           
            #endregion            

            return services;
        }
    }
}
