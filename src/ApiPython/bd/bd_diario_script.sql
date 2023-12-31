USE [master]
GO
/****** Object:  Database [bncc]    Script Date: 30/09/2023 16:57:29 ******/
CREATE DATABASE [bncc]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'bncc', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\bncc.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'bncc_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\bncc_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [bncc] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [bncc].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [bncc] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [bncc] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [bncc] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [bncc] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [bncc] SET ARITHABORT OFF 
GO
ALTER DATABASE [bncc] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [bncc] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [bncc] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [bncc] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [bncc] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [bncc] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [bncc] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [bncc] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [bncc] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [bncc] SET  DISABLE_BROKER 
GO
ALTER DATABASE [bncc] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [bncc] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [bncc] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [bncc] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [bncc] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [bncc] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [bncc] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [bncc] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [bncc] SET  MULTI_USER 
GO
ALTER DATABASE [bncc] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [bncc] SET DB_CHAINING OFF 
GO
ALTER DATABASE [bncc] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [bncc] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [bncc] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [bncc] SET QUERY_STORE = OFF
GO
USE [bncc]
GO
/****** Object:  Table [dbo].[bncc_artes_ef]    Script Date: 30/09/2023 16:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bncc_artes_ef](
	[column1] [int] NOT NULL,
	[componente] [nvarchar](50) NOT NULL,
	[ano_faixa] [nvarchar](50) NOT NULL,
	[unidades_tematicas] [nvarchar](50) NOT NULL,
	[objetos_conhecimento] [nvarchar](50) NOT NULL,
	[habilidades] [nvarchar](450) NOT NULL,
	[cod_hab] [nvarchar](50) NOT NULL,
	[descricao_cod] [nvarchar](400) NOT NULL,
	[primeiro_ef] [bit] NOT NULL,
	[segundo_ef] [bit] NOT NULL,
	[terceiro_ef] [bit] NOT NULL,
	[quarto_ef] [bit] NOT NULL,
	[quinto_ef] [bit] NOT NULL,
	[sexto_ef] [bit] NOT NULL,
	[setimo_ef] [bit] NOT NULL,
	[oitavo_ef] [bit] NOT NULL,
	[nono_ef] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bncc_ciencias_ef]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bncc_ciencias_ef](
	[column1] [int] NOT NULL,
	[componente] [nvarchar](50) NOT NULL,
	[ano_faixa] [nvarchar](50) NOT NULL,
	[unidades_tematicas] [nvarchar](50) NOT NULL,
	[objetos_conhecimento] [nvarchar](200) NOT NULL,
	[habilidades] [nvarchar](350) NOT NULL,
	[cod_hab] [nvarchar](50) NOT NULL,
	[descricao_cod] [nvarchar](350) NOT NULL,
	[primeiro_ef] [bit] NOT NULL,
	[segundo_ef] [bit] NOT NULL,
	[terceiro_ef] [bit] NOT NULL,
	[quarto_ef] [bit] NOT NULL,
	[quinto_ef] [bit] NOT NULL,
	[sexto_ef] [bit] NOT NULL,
	[setimo_ef] [bit] NOT NULL,
	[oitavo_ef] [bit] NOT NULL,
	[nono_ef] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bncc_educacao_fisica_ef]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bncc_educacao_fisica_ef](
	[column1] [int] NOT NULL,
	[componente] [nvarchar](50) NOT NULL,
	[ano_faixa] [nvarchar](50) NOT NULL,
	[unidades_tematicas] [nvarchar](50) NOT NULL,
	[objetos_conhecimento] [nvarchar](150) NOT NULL,
	[habilidades] [nvarchar](350) NOT NULL,
	[cod_hab] [nvarchar](50) NOT NULL,
	[descricao_cod] [nvarchar](350) NOT NULL,
	[primeiro_ef] [bit] NOT NULL,
	[segundo_ef] [bit] NOT NULL,
	[terceiro_ef] [bit] NOT NULL,
	[quarto_ef] [bit] NOT NULL,
	[quinto_ef] [bit] NOT NULL,
	[sexto_ef] [bit] NOT NULL,
	[setimo_ef] [bit] NOT NULL,
	[oitavo_ef] [bit] NOT NULL,
	[nono_ef] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bncc_ensino_religioso_ef]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bncc_ensino_religioso_ef](
	[column1] [int] NOT NULL,
	[componente] [nvarchar](50) NOT NULL,
	[ano_faixa] [nvarchar](50) NOT NULL,
	[unidades_tematicas] [nvarchar](50) NOT NULL,
	[objetos_conhecimento] [nvarchar](100) NOT NULL,
	[habilidades] [nvarchar](250) NOT NULL,
	[cod_hab] [nvarchar](50) NOT NULL,
	[descricao_cod] [nvarchar](250) NOT NULL,
	[primeiro_ef] [bit] NOT NULL,
	[segundo_ef] [bit] NOT NULL,
	[terceiro_ef] [bit] NOT NULL,
	[quarto_ef] [bit] NOT NULL,
	[quinto_ef] [bit] NOT NULL,
	[sexto_ef] [bit] NOT NULL,
	[setimo_ef] [bit] NOT NULL,
	[oitavo_ef] [bit] NOT NULL,
	[nono_ef] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bncc_geografia_ef]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bncc_geografia_ef](
	[column1] [int] NOT NULL,
	[componente] [nvarchar](50) NOT NULL,
	[ano_faixa] [nvarchar](50) NOT NULL,
	[unidades_tematicas] [nvarchar](50) NOT NULL,
	[objetos_conhecimento] [nvarchar](150) NOT NULL,
	[habilidades] [nvarchar](450) NOT NULL,
	[cod_hab] [nvarchar](50) NOT NULL,
	[descricao_cod] [nvarchar](400) NOT NULL,
	[primeiro_ef] [bit] NOT NULL,
	[segundo_ef] [bit] NOT NULL,
	[terceiro_ef] [bit] NOT NULL,
	[quarto_ef] [bit] NOT NULL,
	[quinto_ef] [bit] NOT NULL,
	[sexto_ef] [bit] NOT NULL,
	[setimo_ef] [bit] NOT NULL,
	[oitavo_ef] [bit] NOT NULL,
	[nono_ef] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bncc_historia_ef]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bncc_historia_ef](
	[column1] [int] NOT NULL,
	[componente] [nvarchar](50) NOT NULL,
	[ano_faixa] [nvarchar](50) NOT NULL,
	[unidades_tematicas] [nvarchar](100) NOT NULL,
	[objetos_conhecimento] [nvarchar](450) NOT NULL,
	[habilidades] [nvarchar](300) NOT NULL,
	[cod_hab] [nvarchar](150) NOT NULL,
	[descricao_cod] [nvarchar](300) NOT NULL,
	[primeiro_ef] [bit] NOT NULL,
	[segundo_ef] [bit] NOT NULL,
	[terceiro_ef] [bit] NOT NULL,
	[quarto_ef] [bit] NOT NULL,
	[quinto_ef] [bit] NOT NULL,
	[sexto_ef] [bit] NOT NULL,
	[setimo_ef] [bit] NOT NULL,
	[oitavo_ef] [bit] NOT NULL,
	[nono_ef] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bncc_lingua_inglesa_ef]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bncc_lingua_inglesa_ef](
	[column1] [int] NOT NULL,
	[componente] [nvarchar](50) NOT NULL,
	[ano_faixa] [nvarchar](50) NOT NULL,
	[eixo] [nvarchar](50) NOT NULL,
	[unidades_tematicas] [nvarchar](100) NOT NULL,
	[objetos_conhecimento] [nvarchar](100) NOT NULL,
	[habilidades] [nvarchar](400) NOT NULL,
	[cod_hab] [nvarchar](100) NOT NULL,
	[descricao_cod] [nvarchar](350) NOT NULL,
	[primeiro_ef] [tinyint] NOT NULL,
	[segundo_ef] [tinyint] NOT NULL,
	[terceiro_ef] [tinyint] NOT NULL,
	[quarto_ef] [tinyint] NOT NULL,
	[quinto_ef] [tinyint] NOT NULL,
	[sexto_ef] [bit] NOT NULL,
	[setimo_ef] [bit] NOT NULL,
	[oitavo_ef] [bit] NOT NULL,
	[nono_ef] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bncc_lingua_portuguesa_ef]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bncc_lingua_portuguesa_ef](
	[column1] [int] NOT NULL,
	[componente] [nvarchar](50) NOT NULL,
	[ano_faixa] [nvarchar](50) NOT NULL,
	[campo_atuacao] [nvarchar](50) NOT NULL,
	[praticas_linguagem] [nvarchar](150) NOT NULL,
	[objetos_conhecimento] [nvarchar](250) NOT NULL,
	[habilidades] [nvarchar](4000) NOT NULL,
	[cod_hab] [nvarchar](1050) NOT NULL,
	[descricao_cod] [nvarchar](4000) NOT NULL,
	[primeiro_ef] [bit] NOT NULL,
	[segundo_ef] [bit] NOT NULL,
	[terceiro_ef] [bit] NOT NULL,
	[quarto_ef] [bit] NOT NULL,
	[quinto_ef] [bit] NOT NULL,
	[sexto_ef] [bit] NOT NULL,
	[setimo_ef] [bit] NOT NULL,
	[oitavo_ef] [bit] NOT NULL,
	[nono_ef] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bncc_matematica_ef]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bncc_matematica_ef](
	[column1] [int] NOT NULL,
	[componente] [nvarchar](50) NOT NULL,
	[ano_faixa] [nvarchar](50) NOT NULL,
	[unidades_tematicas] [nvarchar](50) NOT NULL,
	[objetos_conhecimento] [nvarchar](300) NOT NULL,
	[habilidades] [nvarchar](400) NOT NULL,
	[cod_hab] [nvarchar](300) NOT NULL,
	[descricao_cod] [nvarchar](400) NOT NULL,
	[primeiro_ef] [bit] NOT NULL,
	[segundo_ef] [bit] NOT NULL,
	[terceiro_ef] [bit] NOT NULL,
	[quarto_ef] [bit] NOT NULL,
	[quinto_ef] [bit] NOT NULL,
	[sexto_ef] [bit] NOT NULL,
	[setimo_ef] [bit] NOT NULL,
	[oitavo_ef] [bit] NOT NULL,
	[nono_ef] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[competencias_area_em]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[competencias_area_em](
	[column1] [tinyint] NOT NULL,
	[competencias] [nvarchar](500) NULL,
	[area] [nvarchar](50) NULL,
 CONSTRAINT [PK_competencias_area_em] PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[competencias_especificas_por_area_ef]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[competencias_especificas_por_area_ef](
	[column1] [int] NOT NULL,
	[competencias] [nvarchar](400) NOT NULL,
	[conteudo] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[competencias_gerais_em]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[competencias_gerais_em](
	[column1] [tinyint] NOT NULL,
	[competencias] [nvarchar](450) NULL,
	[area] [nvarchar](50) NULL,
 CONSTRAINT [PK_competencias_gerais_em] PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[corpo_gestos_ed_inf]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[corpo_gestos_ed_inf](
	[column1] [int] NOT NULL,
	[campo_exp] [nvarchar](50) NULL,
	[faixa_etaria] [nvarchar](100) NULL,
	[obj] [nvarchar](4000) NULL,
	[cod_apr] [nvarchar](50) NULL,
	[descricao_cod] [nvarchar](4000) NULL,
	[idade_anos_inicial] [tinyint] NULL,
	[idade_meses_inicial] [tinyint] NULL,
	[idade_anos_final] [tinyint] NULL,
	[idade_meses_final] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[df_edu_inf]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[df_edu_inf](
	[column1] [int] NOT NULL,
	[campo_exp] [nvarchar](100) NULL,
	[faixa_etaria] [nvarchar](100) NULL,
	[cod_apr] [nvarchar](50) NULL,
	[descricao_cod] [nvarchar](4000) NULL,
	[idade_anos_inicial] [tinyint] NULL,
	[idade_meses_inicial] [tinyint] NULL,
	[idade_anos_final] [tinyint] NULL,
	[idade_meses_final] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[df_habilidades_em]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[df_habilidades_em](
	[column1] [tinyint] NOT NULL,
	[ano_faixa] [nvarchar](50) NULL,
	[cod_hab] [nvarchar](50) NULL,
	[habilidades] [nvarchar](800) NULL,
	[primeiro_ano] [nvarchar](50) NULL,
	[segundo_ano] [nvarchar](50) NULL,
	[terceiro_ano] [nvarchar](50) NULL,
	[area] [nvarchar](50) NULL,
	[competencias_esp] [nvarchar](50) NULL,
	[campos_atuacao] [nvarchar](50) NULL,
 CONSTRAINT [PK_df_habilidades_em] PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[escuta_fala_ed_inf]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[escuta_fala_ed_inf](
	[column1] [int] NOT NULL,
	[campo_exp] [nvarchar](50) NULL,
	[faixa_etaria] [nvarchar](100) NULL,
	[obj] [nvarchar](4000) NULL,
	[cod_apr] [nvarchar](50) NULL,
	[descricao_cod] [nvarchar](4000) NULL,
	[idade_anos_inicial] [tinyint] NULL,
	[idade_meses_inicial] [tinyint] NULL,
	[idade_anos_final] [tinyint] NULL,
	[idade_meses_final] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[espaco_tempo_ed_inf]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[espaco_tempo_ed_inf](
	[column1] [int] NOT NULL,
	[campo_exp] [nvarchar](100) NULL,
	[faixa_etaria] [nvarchar](100) NULL,
	[obj] [nvarchar](4000) NULL,
	[cod_apr] [nvarchar](50) NULL,
	[descricao_cod] [nvarchar](4000) NULL,
	[idade_anos_inicial] [tinyint] NULL,
	[idade_meses_inicial] [tinyint] NULL,
	[idade_anos_final] [tinyint] NULL,
	[idade_meses_final] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[eu_outro_nos_ed_inf]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eu_outro_nos_ed_inf](
	[column1] [int] NOT NULL,
	[campo_exp] [nvarchar](50) NOT NULL,
	[faixa_etaria] [nvarchar](100) NOT NULL,
	[obj] [nvarchar](4000) NOT NULL,
	[cod_apr] [nvarchar](50) NOT NULL,
	[descricao_cod] [nvarchar](4000) NOT NULL,
	[idade_anos_inicial] [tinyint] NOT NULL,
	[idade_meses_inicial] [tinyint] NULL,
	[idade_anos_final] [tinyint] NOT NULL,
	[idade_meses_final] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[column1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tabela_alunos]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tabela_alunos](
	[nome] [nvarchar](50) NULL,
	[sobrenome] [nvarchar](50) NULL,
	[nome_completo] [nvarchar](100) NULL,
	[ano] [nvarchar](50) NULL,
	[nivel_ensino] [nvarchar](50) NULL,
	[idade] [tinyint] NULL,
	[cpf] [nvarchar](50) NULL,
	[turma] [int] NULL,
	[id_aluno] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tabela_alunos] PRIMARY KEY CLUSTERED 
(
	[id_aluno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tabela_avaliacao]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tabela_avaliacao](
	[id_aluno] [int] NULL,
	[id_materia] [int] NULL,
	[id_bimestre] [int] NULL,
	[nota_1] [int] NULL,
	[nota_2] [int] NULL,
	[nota_3] [int] NULL,
	[nota_4] [int] NULL,
	[nota_5] [int] NULL,
	[total] [int] NULL,
	[id_avaliacao] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tabela_avaliacao] PRIMARY KEY CLUSTERED 
(
	[id_avaliacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tabela_bimestre]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tabela_bimestre](
	[bimestre] [nvarchar](100) NULL,
	[id_bimestre] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tabela_bimestre] PRIMARY KEY CLUSTERED 
(
	[id_bimestre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tabela_materias]    Script Date: 30/09/2023 16:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tabela_materias](
	[id_materia] [int] IDENTITY(1,1) NOT NULL,
	[materia] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_materia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tabela_avaliacao]  WITH CHECK ADD  CONSTRAINT [FK_identifica_aluno] FOREIGN KEY([id_aluno])
REFERENCES [dbo].[tabela_alunos] ([id_aluno])
GO
ALTER TABLE [dbo].[tabela_avaliacao] CHECK CONSTRAINT [FK_identifica_aluno]
GO
ALTER TABLE [dbo].[tabela_avaliacao]  WITH CHECK ADD  CONSTRAINT [FK_identifica_bimestre] FOREIGN KEY([id_bimestre])
REFERENCES [dbo].[tabela_bimestre] ([id_bimestre])
GO
ALTER TABLE [dbo].[tabela_avaliacao] CHECK CONSTRAINT [FK_identifica_bimestre]
GO
ALTER TABLE [dbo].[tabela_avaliacao]  WITH CHECK ADD  CONSTRAINT [FK_identifica_materia] FOREIGN KEY([id_materia])
REFERENCES [dbo].[tabela_materias] ([id_materia])
GO
ALTER TABLE [dbo].[tabela_avaliacao] CHECK CONSTRAINT [FK_identifica_materia]
GO
USE [master]
GO
ALTER DATABASE [bncc] SET  READ_WRITE 
GO
