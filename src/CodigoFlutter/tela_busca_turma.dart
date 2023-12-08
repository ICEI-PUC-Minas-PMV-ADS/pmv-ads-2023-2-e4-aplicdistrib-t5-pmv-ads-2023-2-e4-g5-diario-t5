import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro_bncc_flutter/tela_login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _selectedTurma = 1;
  List<String> _turmas = ['Turma 1', 'Turma 2', 'Turma 3', 'Turma 4', 'Turma 5'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Diário BNCC',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Pacifico',
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blueAccent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),


      ),
      body: _buildBody(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  "Selecione a turma",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Turma 1'),
              onTap: () {
                _selectTurma(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Turma 2'),
              onTap: () {
                _selectTurma(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Turma 3'),
              onTap: () {
                _selectTurma(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Turma 4'),
              onTap: () {
                _selectTurma(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Turma 5'),
              onTap: () {
                _selectTurma(5);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
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
                      return Center(child: Text('No data available.'));
                    }
                  },
                ),
              ),
            ),
          ],
        );
      case 1:
        return Center(
          child: Text('Record Attendance'),
        );
      case 2:
        return Center(
          child: Text('Record Activities'),
        );
      default:
        return Container();
    }
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
              'Turma',
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
        source: _StudentDataSource(students),
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
      fullName: json['nome_completo'] as String? ?? 'Sem nome completo cadastrado',
      year: json['ano'] as String? ?? 'Sem ano cadastrado',
      cpf: json['cpf'] as String? ?? 'Sem cpf cadastrado',
      idStudent: json['id_aluno'] as int? ?? 0,
      age: json['idade'] as int? ?? 0,
      level: json['nivel_ensino'] as String? ?? 'Nível de ensino não cadastrado',
      statusStudent: json['status_aluno'] as bool? ?? true,
      schoolClass: json['turma'] as int? ?? 0,
    );
  }
}
class _StudentDataSource extends DataTableSource {
  final List<Student> _students;

  _StudentDataSource(this._students);

  @override
  DataRow getRow(int index) {
    final student = _students[index];
    return DataRow(cells: [
      DataCell(Text(student.fullName)),
      DataCell(Text(student.schoolClass.toString())),
      DataCell(Text(student.year)),
    ]);
  }

  @override
  int get rowCount => _students.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}