import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fetch Student Api",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Student> futureStudent;
  TextEditingController idController = TextEditingController();
  bool showIdInput = true;

  @override
  void initState() {
    super.initState();
    futureStudent = fetchStudent("240");
  }

  Future<Student> fetchStudent(String studentId) async {
    final Uri url = Uri.parse('http://10.0.2.2:5000/diario/aluno/$studentId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final student =
          Student.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return student;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Diário eletrônico Bncc",
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Pacifico',
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showIdInput)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: idController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Id do aluno',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showIdInput = false;
                    futureStudent = fetchStudent(idController.text);
                  });
                },
                child: const Text(
                  'Buscar aluno por id',
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                ),
              ),
              FutureBuilder<Student>(
                future: futureStudent,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasError) {
                    return Text(
                      'Connection error. Please try again.',
                      style: TextStyle(color: Colors.red),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          for (var item
                              in _buildStudentInfoList(snapshot.data!))
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                dense: true,
                              ),
                            ),
                          if (!showIdInput)
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  showIdInput = true;
                                });
                              },
                              child: const Text(
                                'Pesquisar outro aluno',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black54),
                              ),
                            ),
                        ],
                      ),
                    );
                  } else {
                    return Text(
                      'No data available.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<StudentInfo> _buildStudentInfoList(Student student) {
    return [
      StudentInfo(title: 'Nome: ${student.name}'),
      StudentInfo(title: 'Turma: ${student.schoolClass.toString()}'),
      StudentInfo(title: 'Ano: ${student.year}'),
      StudentInfo(
          title: 'Status do aluno: ${student.statusStudent.toString()}'),
      StudentInfo(title: 'Nível do ensino: ${student.level}'),
      StudentInfo(title: 'Idade: ${student.age}'),
      StudentInfo(title: 'Cpf: ${student.cpf}'),
    ];
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
      name: json['data']['nome'] as String? ?? 'Sem nome cadastrado',
      year: json['data']['ano'] as String? ?? 'Sem ano cadastrado',
      cpf: json['data']['cpf'] as String? ?? 'Sem cpf cadastrado',
      idStudent: json['data']['id_aluno'] as int? ?? 0,
      age: json['data']['idade'] as int? ?? 0,
      level: json['data']['nivel_ensino'] as String? ??
          'Nível de ensino não cadastrado',
      statusStudent: json['data']['status_aluno'] as bool? ?? true,
      schoolClass: json['data']['turma'] as int? ?? 0,
    );
  }
}

class StudentInfo {
  final String title;

  const StudentInfo({
    required this.title,
  });
}
