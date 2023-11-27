import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário BNCC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<bool> _turmaSelection = List.generate(5, (index) => false);

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: _buildBody(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.users),
            label: 'Alunos',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clipboardList),
            label: 'Frequência',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.tasks),
            label: 'Atividades',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return Column(
          children: [
            _buildTurmaSelection(),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.grey[300]!, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: FutureBuilder<List<Student>>(
                  future: fetchStudents(_turmaSelection.indexOf(true) + 1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return _buildStudentList(snapshot.data!);
                    } else {
                      return Center(child: Text('Nenhum dado disponível.'));
                    }
                  },
                ),
              ),
            ),
          ],
        );
      case 1:
        return Center(
          child: Text('Lançar Frequência'),
        );
      case 2:
        return Center(
          child: Text('Lançar Atividades'),
        );
      default:
        return Container();
    }
  }

  Widget _buildStudentList(List<Student> students) {
    return ListView.separated(
      itemCount: students.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.grey[400], thickness: 1.0);
      },
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            'Nome: ${students[index].name}',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            'Turma: ${students[index].schoolClass}',
            style: TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }

  Widget _buildTurmaSelection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 1; i <= 3; i++)
                Row(
                  children: [
                    Text(
                      'Turma $i',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      value: _turmaSelection[i - 1],
                      onChanged: (value) {
                        setState(() {
                          _turmaSelection[i - 1] = value!;
                        });
                      },
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 4; i <= 5; i++)
                Row(
                  children: [
                    Text(
                      'Turma $i',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      value: _turmaSelection[i - 1],
                      onChanged: (value) {
                        setState(() {
                          _turmaSelection[i - 1] = value!;
                        });
                      },
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
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
}

class Student {
  final String name;
  final String year;
  final String cpf;
  final int idStudent;
  final int age;
  final String level;
  final bool statusStudent;
  final int schoolClass;

  const Student({
    required this.name,
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
