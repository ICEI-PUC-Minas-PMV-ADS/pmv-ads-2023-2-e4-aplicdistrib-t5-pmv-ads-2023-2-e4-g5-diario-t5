import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InsertStudents extends StatefulWidget {
  @override
  _InsertStudentsState createState() => _InsertStudentsState();
}

class _InsertStudentsState extends State<InsertStudents> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController anoController = TextEditingController();
  TextEditingController turmaController = TextEditingController();

  Future<void> inserirAluno() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/diario/inserir/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "nome": nomeController.text,
        "sobrenome": sobrenomeController.text,
        "idade": int.parse(idadeController.text),
        "ano": anoController.text,
        "nivel_ensino": "ef", // ajuste conforme necessário
        "cpf": "123456789", // ajuste conforme necessário
        "id_turma": int.parse(turmaController.text),
      }),
    );

    if (response.statusCode == 201) {
      // Inserção bem-sucedida, você pode tratar a resposta aqui
      print('Aluno inserido com sucesso');
      print(response.body);
    } else {
      // Algo deu errado ao inserir o aluno
      print('Erro ao inserir aluno: ${response.statusCode}');
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inserir Aluno',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              TextField(
                controller: sobrenomeController,
                decoration: InputDecoration(
                  labelText: 'Sobrenome',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              TextField(
                controller: idadeController,
                decoration: InputDecoration(
                  labelText: 'Idade',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              TextField(
                controller: anoController,
                decoration: InputDecoration(
                  labelText: 'Ano',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              TextField(
                controller: turmaController,
                decoration: InputDecoration(
                  labelText: 'Turma',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: inserirAluno,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Inserir Aluno',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
