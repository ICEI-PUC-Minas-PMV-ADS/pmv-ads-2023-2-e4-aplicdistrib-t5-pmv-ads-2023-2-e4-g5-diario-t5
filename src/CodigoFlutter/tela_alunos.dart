import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pro_bncc_flutter/tela_inserir_aluno.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alunos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlunosScreen(),
    );
  }
}

class AlunosScreen extends StatefulWidget {
  @override
  _AlunosScreenState createState() => _AlunosScreenState();
}

class _AlunosScreenState extends State<AlunosScreen> {
  List<Student> _students = [];

  int _selectedTurma = 1;

  void _navigateToCadastroAluno() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CadastrarAlunoScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar por filtros',
            style: TextStyle(color: Colors.white, fontFamily: 'Pacifico')),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),

            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white
            ),
onPressed: (){print('oi');},

          )],
      ),
      drawer: _buildTurmaDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(text: 'Buscar'),
            //dar um jeito de melhorar a aba cadastrar depois
            Tab(text: 'Cadastrar'),
          ],
          onTap: (index) {
            if (index == 1) {
              _navigateToCadastroAluno();
            }
          },
        ),
        body: TabBarView(
          children: [
            _buildBuscarAlunos(),
            Center(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget _buildTurmaDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                "Filtros",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Turma', style: TextStyle(fontSize: 16.0)),
                DropdownButton<int>(
                  value: _selectedTurma,
                  onChanged: (int? value) {
                    if (value != null) {
                      _selectTurma(value);
                    }
                  },
                  items: List.generate(5, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text('Turma ${index + 1}'),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuscarAlunos() {
    return Column(
      children: [
        SizedBox(height: 16.0),
        Expanded(
          child: Container(
            child: FutureBuilder<List<Student>>(
              future: fetchStudents(_selectedTurma),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return _buildPaginatedDataTable(snapshot.data!);
                } else {
                  return Center(child: Text('Sem dados'));
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaginatedDataTable(List<Student> students) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        header: Text('Alunos'),
        rowsPerPage: _calculateRowsPerPage(),
        columns: [
          DataColumn(
            label: Text(
              'Nome Completo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Ano',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        source: _StudentDataSource(students, _showStudentDialog),
      ),
    );
  }

  int _calculateRowsPerPage() {
    double screenHeight = MediaQuery.of(context).size.height;
    double rowHeight = 56.0;
    int calculatedRowsPerPage = (screenHeight / rowHeight).floor();
    return calculatedRowsPerPage;
  }

  Future<List<Student>> fetchStudents(int turma) async {
    final Uri url = Uri.parse('http://10.0.2.2:5000/diario/?turma=$turma');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> studentsData = jsonDecode(response.body)["data"];
      final List<Student> students = studentsData
          .map((data) => Student.fromJson(data as Map<String, dynamic>))
          .toList();
      return students;
    } else {
      throw Exception(response.body);
    }
  }
  void _selectTurma(int turma) {
    setState(() {
      _selectedTurma = turma;
    });
  }

  void _showStudentDialog(Student student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalhes do Aluno'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nome: ${student.fullName}'),
              Text('Ano: ${student.year}'),
              Text('Idade: ${student.age}'),
              Text('CPF: ${student.cpf}'),
              Text('Status: ${student.statusStudent ? 'Ativo' : 'Inativo'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}

class _StudentDataSource extends DataTableSource {
  final List<Student> _students;
  final Function(Student)
  _onRowTap; // Adicionar callback para tratar toques na linha
  _StudentDataSource(this._students, this._onRowTap);
  @override
  DataRow getRow(int index) {
    final student = _students[index];
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Colors.transparent;
      }),
      cells: [
        DataCell(
          InkWell(
            onLongPress: () => _onRowTap(student),
            child: Container(
              color: Colors.transparent,
              child: Text(student.fullName),
            ),
            splashColor: Colors.lightBlue, // Cor de destaque ao toque
            highlightColor: Colors.cyan,
            autofocus: true,// Cor de fundo quando pressionado
          ),
        ),
        DataCell(
          InkWell(
            onTap: () => _onRowTap(student),
            child: Container(
              color: Colors.transparent,
              child: Text(student.year),
            ),
            splashColor: Colors.red,
            highlightColor: Colors.transparent,
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _students.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class Student {
  final String name;
  final String surname;
  final String fullName;
  final String year;
  final String cpf;
  final int idStudent;
  final int age;
  final String level;
  final bool statusStudent;
  final int schoolClass;

  const Student({
    required this.name,
    required this.surname,
    required this.fullName,
    required this.year,
    required this.cpf,
    required this.idStudent,
    required this.age,
    required this.level,
    required this.statusStudent,
    required this.schoolClass,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['nome'] as String? ?? 'Sem nome cadastrado',
      surname: json['sobrenome'] as String? ?? 'Sem sobrenome cadastrado',
      fullName:
      json['nome_completo'] as String? ?? 'Sem nome completo cadastrado',
      year: json['ano'] as String? ?? 'Sem ano cadastrado',
      cpf: json['cpf'] as String? ?? 'Sem cpf cadastrado',
      idStudent: json['id_aluno'] as int? ?? 0,
      age: json['idade'] as int? ?? 0,
      level:
      json['nivel_ensino'] as String? ?? 'Nível de ensino não cadastrado',
      statusStudent: json['status_aluno'] as bool? ?? true,
      schoolClass: json['turma'] as int? ?? 0,
    );
  }
}

Future<void> _updateStudent(Student student, String newName) async {
  final String apiUrl = 'http://10.0.2.2:5000/diario/atualizar/${student.idStudent}';
  final Map<String, String> data = {
    'nome': newName,
    'sobrenome': student.surname,
    'nome_completo': student.fullName,
    'ano': student.year,
    'cpf': student.cpf,
    'idade': student.age.toString(),
    'nivel_ensino': student.level,
    'status_aluno': student.statusStudent.toString()


  };
  try {
    final http.Response response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print('Estudante atualizado com sucesso!');
    } else {
      print('Falha ao atualizar o estudante. Código de resposta: ${response.statusCode}');
    }
  } catch (error) {
    print('Erro ao fazer a solicitação de atualização: $error');
  }
}
