import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tela_editar_avaliacao.dart';


class TelaAtividades extends StatefulWidget {
  @override
  _TelaAtividadesState createState() => _TelaAtividadesState();
}
class _TelaAtividadesState extends State<TelaAtividades> {
  bool todasSelecionadas = false;
  int? turmaSelecionada;
  List<Atividade> atividades = [];
  final AtividadeService atividadeService = AtividadeService();

  void _navigateToAtividadeDetails(Atividade atividade) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AtividadeDetailsScreen(atividade: atividade),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Text('Atividades'),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Listar Atividades',

              ),
              Tab(
                text: 'Lançar Atividades',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Conteúdo da aba "Listar Atividades"
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: todasSelecionadas,
                        onChanged: (value) {
                          setState(() {
                            todasSelecionadas = value!;
                          });
                          if (todasSelecionadas) {
                            carregarAtividades();
                          } else {
                            setState(() {
                              atividades.clear();
                            });
                          }
                        },
                      ),
                      Text('Todas'),
                    ],
                  ),
                  DropdownButtonFormField<int>(
                    value: turmaSelecionada,
                    items: [1, 2, 3, 4, 5].map((int turma) {
                      return DropdownMenuItem<int>(
                        value: turma,
                        child: Text('Turma $turma'),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        turmaSelecionada = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Selecionar Turma',
                    ),
                  ),
                  if (todasSelecionadas)
                    SingleChildScrollView(
                      child: PaginatedDataTable(
                        header: Text('Atividades'),
                        columns: [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Nome')),
                          DataColumn(label: Text('Data')),
                        ],
                        source: AtividadeDataSource(
                          atividades: atividades,
                          onRowTap: _navigateToAtividadeDetails,
                        ),                        
                        rowsPerPage: 5,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: AddAtividadeForm(
                    atividadeService: atividadeService,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void carregarAtividades() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5000/diario/atividades'));
      print(' $response');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        if (responseData.containsKey('lista_total')) {
          List<Atividade> listaAtividades =
              (responseData['lista_total'] as List)
                  .map((item) => Atividade.fromJson(item))
                  .toList();

          listaAtividades.sort((a, b) => b.id.compareTo(a.id));

          setState(() {
            atividades = listaAtividades;
          });
          print('Erro ao carregar lista: ${listaAtividades}');
        } else {
          print('Resposta nao contem o Lista total');
        }
      } else {
        print('Erro ao carregar lista: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Erro ao carregar as atividades');
    }
  }
}

class AtividadeService {
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

//formulario
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

  List<Materias> materias = [
    Materias(displayText: 'Português', value: 1),
    Materias(displayText: 'Inglês', value: 2),
    Materias(displayText: 'Artes', value: 3),
    Materias(displayText: 'Matemática', value: 4),
    Materias(displayText: 'Ciências', value: 5),
    Materias(displayText: 'Educação Fisíca', value: 6),
    Materias(displayText: 'Ensino Religioso', value: 7),
    Materias(displayText: 'História', value: 8),
    Materias(displayText: 'Geografia', value: 9),
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
      setState(() {});
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
              items: materias.map((materia) {
                return DropdownMenuItem<int>(
                  value: materia.value,
                  child: Text(materia.displayText),
                );
              }).toList(),
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

class Materias {
  final String displayText;
  final int value;

  Materias({required this.displayText, required this.value});
}

class Atividade {
  final int id;
  final String descricao;
  final String data; 
  final int turma; 
  final bool status; 
  final String bimestre; 
  final String materia; 
  final int id_materia; 
  final int id_bimestre; 

  Atividade({required this.id, required this.descricao, required this.data, required this.turma, required this.status, required this.bimestre, required this.materia, required this.id_materia, required this.id_bimestre});

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade(
      id: json['id_atividade'] as int,
      descricao: json['descricao_at'] as String,
      data: json['data_cadastro_atv'] as String,
      turma: json['turma'] as int,
      status: json['atv_status'] as bool,
      bimestre: json['bimestre'] as String,
      materia: json['materia'] as String,
      id_materia: json['id_materia'] as int,
      id_bimestre: json['id_bimestre'] as int,
    );
  }
}

// Classe que implementa DataTableSource para fornecer dados para a tabela paginada
class AtividadeDataSource extends DataTableSource {
  final List<Atividade> atividades;
  final Function(Atividade) onRowTap;

  AtividadeDataSource({required this.atividades, required this.onRowTap});

  @override
  DataRow getRow(int index) {
    final atividade = atividades[index];
    return DataRow(
      cells: [
        DataCell(
          GestureDetector(
            onTap: () => onRowTap(atividade),
            child: Container(
              width: 30,
              child: Center(
                child: Text(
                  atividades[index].id.toString(),
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
        DataCell(Text(atividades[index].descricao)),
        DataCell(Text(atividades[index].data)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => atividades.length;

  @override
  int get selectedRowCount => 0;
}




