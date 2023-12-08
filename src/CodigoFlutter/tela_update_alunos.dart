import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MinhaPagina(),
  ));
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

class MinhaPagina extends StatefulWidget {

  @override
  _MinhaPaginaState createState() => _MinhaPaginaState();
}
class _MinhaPaginaState extends State<MinhaPagina> {
  Future<void> updateEstudante(int idEstudante) async {
    final String apiUrl = 'http://10.0.2.2:5000/diario/atualizar/$idEstudante';

    Map<String, dynamic> dadosAtualizados = {
      'nome': 'Novo Nome',
      'sobrenome': 'Novo Sobrenome',
      'ano': 'Novo Ano',
      'nivel_ensino': 'Novo Nível de Ensino',
      'idade': 25,
      'cpf': 'Novo CPF',
      'turma': 1,
      'status_aluno': true
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(dadosAtualizados),
      );

      if (response.statusCode == 200) {
        print('Estudante $idEstudante atualizado com sucesso!');
      } else {
        print('Erro ao atualizar estudante. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao realizar a solicitação: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Página'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            updateEstudante(240);
          },
          child: Text('Atualizar Estudante'),
        ),
      ),
    );
  }
}
