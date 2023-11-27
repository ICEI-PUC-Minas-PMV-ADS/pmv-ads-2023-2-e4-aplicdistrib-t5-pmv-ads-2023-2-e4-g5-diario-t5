
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyApp extends StatelessWidget {
  final AtividadeService atividadeService = AtividadeService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Diário Escolar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AddAtividadeForm(atividadeService: atividadeService),
              AtividadeListView(atividadeService: atividadeService),
            ],
          ),
        ),
      ),
    );
  }
}

class AtividadeService {
  Future<List<Atividade>> fetchAtividades() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/diario/atividades'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['lista_total'];

      // Adicione este log para visualizar a resposta
      print('Response from fetchAtividades: $data');

      return List<Atividade>.from(data.map((item) => Atividade(
        id: item['id_materia'],
        descricao: item['descricao_at'],
        turma: item['turma'],
        idAtividade: item['id_atividade'],
        status: item['atv_status'] ? 1 : 0,
        dataCadastro: item['data_cadastro_atv'],
        bimestre: item['bimestre'],
        materia: item['materia'],
      )));
    } else {
      throw Exception('Failed to load atividades');
    }
  }

  Future<void> addAtividade(Map<String, dynamic> atividadeData) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/diario/inserir/atividades'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(atividadeData),
    );

    if (response.statusCode == 200) {
      print("Atividade adicionada com sucesso!");
    } else {
      print("Erro ao adicionar atividade");
    }
  }
}

class AtividadeListView extends StatefulWidget {
  final AtividadeService atividadeService;

  AtividadeListView({required this.atividadeService});

  @override
  _AtividadeListViewState createState() => _AtividadeListViewState();
}

class _AtividadeListViewState extends State<AtividadeListView> {
  List<Atividade> atividades = [];
  final AtividadeService atividadeService = AtividadeService();

  @override
  void initState() {
    super.initState();
    fetchAtividades();
  }

  Future<void> fetchAtividades() async {
    final data = await widget.atividadeService.fetchAtividades();
    setState(() {
      atividades = data;
    });
  }

  Future<void> refreshPage() async {
    await fetchAtividades();
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      header: Text('Lista de Atividades'),
      rowsPerPage: 5,
      columns: [
        DataColumn(label: Text('ID da Atividade')),
        DataColumn(label: Text('Descrição')),
        DataColumn(label: Text('Turma')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Data de Cadastro')),
        DataColumn(label: Text('Bimestre')),
        DataColumn(label: Text('Matéria')),
      ],
      source: _AtividadeDataSource(atividades),
    );
  }
}

class _AtividadeDataSource extends DataTableSource {
  final List<Atividade> _atividades;

  _AtividadeDataSource(this._atividades);

  @override
  DataRow getRow(int index) {
    final atividade = _atividades[index];
    return DataRow(cells: [
      DataCell(Text(atividade.idAtividade.toString())),
      DataCell(Text(atividade.descricao)),
      DataCell(Text(atividade.turma.toString())),
      DataCell(Text(atividade.status.toString())),
      DataCell(Text(atividade.dataCadastro)),
      DataCell(Text(atividade.bimestre)),
      DataCell(Text(atividade.materia)),
    ]);
  }

  @override
  int get rowCount => _atividades.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class AddAtividadeForm extends StatefulWidget {
  final AtividadeService atividadeService;

  AddAtividadeForm({required this.atividadeService});

  @override
  _AddAtividadeFormState createState() => _AddAtividadeFormState();
}

class Bimestre {
  final String displayText;
  final int value;

  Bimestre({required this.displayText, required this.value});
}

class _AddAtividadeFormState extends State<AddAtividadeForm> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  int _selectedTurma = 1;
  int _selectedMateria = 1;
  String _selectedBimestre = '1';

  List<Bimestre> bimestres = [
    Bimestre(displayText: '1° Bimestre', value: 1),
    Bimestre(displayText: '2° Bimestre', value: 2),
    Bimestre(displayText: '3° Bimestre', value: 3),
    Bimestre(displayText: '4° Bimestre', value: 4),
  ];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      print('Descricao: ${_descricaoController.text}');
      print('Turma: $_selectedTurma');
      print('Matéria: $_selectedMateria');
      print('Bimestre: $_selectedBimestre');

      widget.atividadeService.addAtividade({
        'descricao_at': _descricaoController.text,
        'turma': _selectedTurma,
        'id_materia': _selectedMateria,
        'id_bimestre': _selectedBimestre,
      });

      _descricaoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adicionar Nova Atividade',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _descricaoController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a descrição';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            DropdownButtonFormField<int>(
              value: _selectedTurma,
              onChanged: (value) {
                setState(() {
                  _selectedTurma = value!;
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
              value: _selectedMateria,
              onChanged: (value) {
                setState(() {
                  _selectedMateria = value!;
                });
              },
              items: List.generate(
                5,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text('Matéria ${index + 1}'),
                ),
              ),
              decoration: InputDecoration(labelText: 'Matéria'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedBimestre,
              onChanged: (value) {
                setState(() {
                  _selectedBimestre = value!;
                });
              },
              items: bimestres.map((bimestre) {
                return DropdownMenuItem<String>(
                  value: bimestre.value.toString(),
                  child: Text(bimestre.displayText),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Bimestre'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Adicionar Atividade'),
            ),
          ],
        ),
      ),
    );
  }
}

// Adicione a seguinte classe para representar uma atividade
class Atividade {
  final int id;
  final String descricao;
  final int turma;
  final int idAtividade;
  final int status;
  final String dataCadastro;
  final String bimestre;
  final String materia;

  Atividade({
    required this.id,
    required this.descricao,
    required this.turma,
    required this.idAtividade,
    required this.status,
    required this.dataCadastro,
    required this.bimestre,
    required this.materia,
  });
}

