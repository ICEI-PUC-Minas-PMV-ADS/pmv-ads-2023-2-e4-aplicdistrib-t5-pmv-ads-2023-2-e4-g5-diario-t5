import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tela_atividades_2.dart';

class EditAtividadeScreen extends StatefulWidget {
  final Atividade atividade;

  EditAtividadeScreen({required this.atividade});

  @override
  _EditAtividadeScreenState createState() => _EditAtividadeScreenState();
}

class _EditAtividadeScreenState extends State<EditAtividadeScreen> {
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _turmaController = TextEditingController();
  TextEditingController _idMateriaController = TextEditingController();
  TextEditingController _idBimestreController = TextEditingController();

  dynamic teste;

  List<Bimestre> bimestresEdit = [
    Bimestre(displayText: '1° Bimestre', value: 1),
    Bimestre(displayText: '2° Bimestre', value: 2),
    Bimestre(displayText: '3° Bimestre', value: 3),
    Bimestre(displayText: '4° Bimestre', value: 4),
  ];

  List<Materias> materiasEdit = [
    Materias(displayText: 'Português', value: 1),
    Materias(displayText: 'Inglês', value: 2),
    Materias(displayText: 'Artes', value: 3),
    Materias(displayText: 'Matemática', value: 4),
    Materias(displayText: 'Ciências', value: 5),
    Materias(displayText: 'Educação Física', value: 6),
    Materias(displayText: 'Ensino Religioso', value: 7),
    Materias(displayText: 'História', value: 8),
    Materias(displayText: 'Geografia', value: 9),
  ];

  @override
  void initState() {
    super.initState();
    _descricaoController.text = widget.atividade.descricao;
    _turmaController.text = widget.atividade.turma.toString();
    _idMateriaController.text = widget.atividade.id_materia.toString();
    _idBimestreController.text = widget.atividade.id_bimestre.toString();
    teste = materiasEdit.map((e) => e.value == _idMateriaController.text);
    print("TESTEEEEEEEEEEEEEEEEE ${_idMateriaController.text}");
    print("BIMESTREEEEEEEEEE $_idBimestreController");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Atividade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: int.tryParse(_turmaController.text) ?? 1,
              onChanged: (value) {
                setState(() {
                  _turmaController.text = value.toString();
                });
              },
              items: List.generate(
                5,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text('Turma ${index + 1}'),
                ),
              ),
              decoration: InputDecoration(labelText: 'Turma'),
            ),
            DropdownButtonFormField<int>(
              value: materiasEdit
                      .map((e) => e.displayText == _idMateriaController.text)
                      .isEmpty
                  ? null
                  : int.tryParse(_idMateriaController.text),
              onChanged: (value) {
                setState(() {
                  _idMateriaController.text = value.toString();
                });
              },
              items: materiasEdit.map((materia) {
                return DropdownMenuItem<int>(
                  value: materia.value,
                  child: Text(materia.displayText),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Matéria'),
            ),
            DropdownButtonFormField<String>(
              value: bimestresEdit
                      .map((bimestre) => bimestre.value.toString())
                      .contains(_idBimestreController.text)
                  ? _idBimestreController.text
                  : bimestresEdit.first.value.toString(),
              onChanged: (value) {
                setState(() {
                  _idBimestreController.text = value!;
                });
              },
              items: bimestresEdit.map((bimestre) {
                return DropdownMenuItem<String>(
                  value: bimestre.value.toString(),
                  child: Text(bimestre.displayText),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Bimestre'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _updateAtividade();
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateAtividade() async {
    Map<String, dynamic> updatedData = {
      'descricao_at': _descricaoController.text,
      'turma': int.tryParse(_turmaController.text) ?? 0,
      'id_materia': int.tryParse(_idMateriaController.text) ?? 0,
      'id_bimestre': int.tryParse(_idBimestreController.text) ?? 0,
    };

    try {
      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:5000/diario/atualizar/${widget.atividade.id}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        var updatedActivity =
            responseData['data'];

        Atividade atvData = Atividade(
          descricao: updatedActivity["descricao_at"],
          turma: updatedActivity["turma"],
          id_bimestre: updatedActivity["id_bimestre"],
          id_materia: updatedActivity["id_materia"],
          bimestre: widget.atividade.bimestre,
          data: widget.atividade.data,
          materia: widget.atividade.materia,
          status: widget.atividade.status,
          id: widget.atividade.id
        );

        print(
            'Atividade atualizada com sucesso!: ${updatedActivity["id_atividade"]}');

        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AtividadeDetailsScreen(
              atividade: atvData, //
            ),
          ),
        );
      }
    } catch (error) {
      // Handle errors
      print('Erro ao atualizar atividade: $error');
    }
  }
}

//Tela detalhes/Avaliação
class AtividadeDetailsScreen extends StatefulWidget {
  final Atividade atividade;

  AtividadeDetailsScreen({required this.atividade});

  @override
  _AtividadeDetailsScreenState createState() => _AtividadeDetailsScreenState();
}

class _AtividadeDetailsScreenState extends State<AtividadeDetailsScreen> {
  late List<AlunoAvaliacao> students = [];
  late _AlunoDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = _AlunoDataSource(students: students);
    loadStudentsByTurma(widget.atividade.turma, widget.atividade.id);
  }

  int obterCodigoBimestre(String bimestre) {
    switch (bimestre.toLowerCase()) {
      case 'primeiro':
        return 1;
      case 'segundo':
        return 2;
      case 'terceiro':
        return 3;
      case 'quarto':
        return 4;
      default:
        return 0;
    }
  }

  int obterCodigoMateria(String materia) {
    switch (materia.toLowerCase()) {
      case 'portugues':
        return 1;
      case 'ingles':
        return 2;
      case 'artes':
        return 3;
      case 'matematica':
        return 4;
      case 'ciencias':
        return 5;
      case 'educacao_fisica':
        return 6;
      case 'ensino_religioso':
        return 7;
      case 'historia':
        return 8;
      case 'geografia':
        return 9;
      default:
        return 0;
    }
  }

  void _avaliarAlunos() async {
    for (var aluno in students) {
      if (aluno.notaController.text.isNotEmpty) {
        await enviarNota(
            aluno.idAluno, double.parse(aluno.notaController.text));
      }
    }
  }

  Future<void> loadStudentsByTurma(int turma, int idAtividade) async {
    try {
      List<AlunoAvaliacao> alunos = await ListaAvaliacaoAlunos()
          .listarAvaliacoesAlunos(turma, idAtividade);
      setState(() {
        students = alunos;
        print("Avaliações dos Alunos: $students");
      });
    } catch (e) {
      print("Erro ao carregar avaliações dos alunos: $e");
    }
  }

  Future<void> enviarNota(int idAluno, double nota) async {
    final urlInsert = 'http://10.0.2.2:5000/diario/inserir/nota';
    final urlUpdate = 'http://10.0.2.2:5000/diario/atualizar/nota';

    var materia = obterCodigoMateria(widget.atividade.materia);
    var bimestre = obterCodigoBimestre(widget.atividade.bimestre);
    var avaliado = students.firstWhere((element) => element.idAluno == idAluno,
        orElse: () => AlunoAvaliacao(
            idAluno: idAluno,
            nomeCompleto: "nomeCompleto",
            turma: 0,
            total: 0));
    print('Valor de avaliado.turma: ${avaliado.total}');
    final data = {
      'id_aluno': idAluno,
      'id_materia': materia,
      'id_bimestre': bimestre,
      'nota_5': nota,
      'total': nota,
      'id_atividade': widget.atividade.id,
    };

    final jsonData = jsonEncode(data);

    try {
      if (avaliado.total != null) {
        final response = await http.post(
          Uri.parse(urlUpdate),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        if (response.statusCode == 200) {
          print('Avaliação atualizada com sucesso');
          loadStudentsByTurma(widget.atividade.turma, widget.atividade.id);
        } else {
          print('Erro: ${response.statusCode}');
          print('Resposta: ${response.body}');
        }
      } else {
        final response = await http.post(
          Uri.parse(urlInsert),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        if (response.statusCode == 200) {
          print('Avaliação inserida com sucesso');
          _dataSource.updateData(students);
          setState(() {
            print('TESTEEEEEEEE');
            final aluno =
                students.firstWhere((element) => element.idAluno == idAluno);
            aluno.nota5 = nota;
          });
          loadStudentsByTurma(widget.atividade.turma, widget.atividade.id);
        } else {
          print('Erro: ${response.statusCode}');
          print('Resposta: ${response.body}');
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Atividade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'ID: ${widget.atividade.id}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Descrição: ${widget.atividade.descricao}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Turma: ${widget.atividade.turma}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${widget.atividade.status == 1 ? 'Avaliado' : 'Em Avaliação'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Data de Cadastro: ${widget.atividade.data}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Bimestre: ${formatBimestre(widget.atividade.id_bimestre)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Matéria: ${formatMateria(widget.atividade.id_materia)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditAtividadeScreen(atividade: widget.atividade),
                      ),
                    );
                  },
                  child: Text('Editar Atividade'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _avaliarAlunos();
                  },
                  child: Text('Avaliar'),
                ),
              ],
            ),
            SizedBox(height: 16),
            PaginatedDataTable(
              header: const Text('Alunos'),
              rowsPerPage: 5,
              source: _AlunoDataSource(students: students),
              columns: [
                DataColumn(label: Text('Nome Completo')),
                DataColumn(label: Text('Nota')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Id')),
                DataColumn(label: Text('Turma')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AlunoDataSource extends DataTableSource {
  final List<AlunoAvaliacao> students;

  _AlunoDataSource({required this.students});
  void updateData(List<AlunoAvaliacao> newStudents) {
    students.clear();
    students.addAll(newStudents);
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    final aluno = students[index];
    return DataRow(
      cells: [
        DataCell(Text(aluno.nomeCompleto)),
        DataCell(
          Container(
            width: 60,
            height: 30,
            child: TextFormField(
              controller: aluno.notaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        DataCell(Text(aluno.total?.toString() ?? 'N/A')),
        DataCell(Text(aluno.idAluno.toString())),
        DataCell(Text(aluno.turma.toString())),
      ],
    );
  }

  @override
  int get rowCount => students.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

//classes avaliação
class AlunoAvaliacao {
  int idAluno;
  String nomeCompleto;
  int turma;
  double? nota5;
  double? total;
  TextEditingController notaController;

  AlunoAvaliacao({
    required this.idAluno,
    required this.nomeCompleto,
    required this.turma,
    this.nota5,
    this.total,
  }) : notaController = TextEditingController(text: nota5?.toString() ?? '');
}

String formatBimestre(int value) {
  switch (value) {
    case 1:
      return '1° Bimestre';
    case 2:
      return '2° Bimestre';
    case 3:
      return '3° Bimestre';
    case 4:
      return '4° Bimestre';
    default:
      return 'Bimestre Desconhecido';
  }
}

String formatMateria(int value) {
  switch (value) {
    case 1:
      return 'Português';
    case 2:
      return 'Inglês';
    case 3:
      return 'Artes';
    case 4:
      return 'Matemática';
    case 5:
      return 'Ciências';
    case 6:
      return 'Educação Física';
    case 7:
      return 'Ensino Religioso';
    case 8:
      return 'História';
    case 9:
      return 'Geografia';
    default:
      return 'Bimestre Desconhecido';
  }
}

List<Materias> materiasEdit = [
  Materias(displayText: 'Português', value: 1),
  Materias(displayText: 'Inglês', value: 2),
  Materias(displayText: 'Artes', value: 3),
  Materias(displayText: 'Matemática', value: 4),
  Materias(displayText: 'Ciências', value: 5),
  Materias(displayText: 'Educação Física', value: 6),
  Materias(displayText: 'Ensino Religioso', value: 7),
  Materias(displayText: 'História', value: 8),
  Materias(displayText: 'Geografia', value: 9),
];

class ListaAvaliacaoAlunos {
  AvaliacaoService _avaliacaoService = AvaliacaoService();
  AlunoService _alunoService = AlunoService();

  Future<List<AlunoAvaliacao>> listarAvaliacoesAlunos(
      int turma, int idAtividade) async {
    List<Avaliacao> avaliacoes =
        await _avaliacaoService.listarTodosPorAtvId(idAtividade);
    List<Aluno> alunos = await _alunoService.listarTodos();

    List<AlunoAvaliacao> listaAlunos = [];

    for (Aluno aluno
        in alunos.where((x) => x.turma == turma && x.status == true)) {
      AlunoAvaliacao dto = AlunoAvaliacao(
        idAluno: aluno.idAluno,
        nomeCompleto: aluno.nomeCompleto,
        turma: aluno.turma,
      );

      if (avaliacoes.isNotEmpty) {
        Avaliacao? avaliacao = avaliacoes.firstWhere(
            (x) => x.idAluno == aluno.idAluno,
            orElse: () => Avaliacao(
                idAluno: 0,
                idAvaliacao: 0,
                idMateria: 0,
                idAtividade: 0,
                idBimestre: 0));
        if (avaliacao.idAluno != null) {
          dto.nota5 = avaliacao.nota5;
          dto.total = avaliacao.total;
        } else {
          dto.nota5 = null;
          dto.total = null;
        }
      } else {
        dto.nota5 = null;
        dto.total = null;
      }

      listaAlunos.add(dto);
    }
    return listaAlunos;
  }
}

class AvaliacaoService {
  Future<List<Avaliacao>> listarTodosPorAtvId(int idAtividade) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:5000/diario/avaliacao/atividade/$idAtividade'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['lista_total'];
      return data
          .map((json) => Avaliacao(
                idAvaliacao: json["id_avaliacao"],
                idAluno: json['id_aluno'],
                idMateria: json['id_materia'],
                idBimestre: json['id_bimestre'],
                idAtividade: json['id_atividade'],
                nota5: json['nota_5']?.toDouble(),
                total: json['total']?.toDouble(),
              ))
          .toList();
    } else {
      throw Exception('Falha ao carregar avaliações');
    }
  }
}

class Avaliacao {
  int idAvaliacao;
  int idAluno;
  int idMateria;
  int idBimestre;
  int idAtividade;
  double? nota5;
  double? total;

  Avaliacao({
    required this.idAvaliacao,
    required this.idAluno,
    required this.idMateria,
    required this.idBimestre,
    required this.idAtividade,
    this.nota5,
    this.total,
  });
}

class AlunoService {
  Future<List<Aluno>> listarTodos() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/diario'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['lista_total'];
      return data
          .map((json) => Aluno(
              idAluno: json["id_aluno"],
              nome: json["nome"],
              sobrenome: json["sobrenome"],
              nomeCompleto: json["nome_completo"],
              ano: json["ano"],
              nivelEnsino: json["nivel_ensino"],
              idade: json["idade"],
              cpf: json["cpf"],
              turma: json["turma"],
              status: json["status_aluno"],
              dataAln: json["data_cadastro_aln"]))
          .toList();
    } else {
      throw Exception('Falha ao carregar alunos');
    }
  }
}

class Aluno {
  int idAluno;
  String nome;
  String sobrenome;
  String nomeCompleto;
  String ano;
  String? nivelEnsino;
  int? idade;
  String? cpf;
  int turma;
  bool status;
  String dataAln;

  Aluno({
    required this.idAluno,
    required this.nome,
    required this.sobrenome,
    required this.nomeCompleto,
    required this.ano,
    this.nivelEnsino,
    this.idade,
    this.cpf,
    required this.turma,
    this.status = true,
    required this.dataAln,
  });
}
