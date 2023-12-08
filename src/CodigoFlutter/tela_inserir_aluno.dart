import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastrarAlunoScreen extends StatefulWidget {
  @override
  _CadastrarAlunoScreenState createState() => _CadastrarAlunoScreenState();
}

class _CadastrarAlunoScreenState extends State<CadastrarAlunoScreen> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  String? anoSelecionado;
  int turmaSelecionada = 1;
  List<String> opcoesAno = ['6º ano', '7º ano', '8º ano', '9º ano'];

  Future<void> inserirAluno() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/diario/inserir/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "nome": nomeController.text,
        "sobrenome": sobrenomeController.text,
        "idade": int.parse(idadeController.text),
        "ano": converterAnoParaApi(anoSelecionado),
        "nivel_ensino": "ef",
        "cpf": "123456789",
        "id_turma": turmaSelecionada,
      }),
    );
        if (response.statusCode == 200) {
      nomeController.clear();
      sobrenomeController.clear();
      idadeController.clear();
      anoSelecionado = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Aluno cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print('Erro ao inserir aluno: ${response.statusCode}');
      print(response.body);
    }
  }

  String converterAnoParaApi(String? ano) {
    switch (ano) {
      case '6º ano':
        return 'sexto';
      case '7º ano':
        return 'setimo';
      case '8º ano':
        return 'oitavo';
      case '9º ano':
        return 'nono';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar aluno',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Pacifico',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDropdown('Ano', opcoesAno, anoSelecionado, (value) {
                    setState(() {
                      anoSelecionado = value;
                    });
                  }),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButton<int>(
                      value: turmaSelecionada,
                      isExpanded: true,
                      isDense: true,
                      onChanged: (value) {
                        setState(() {
                          turmaSelecionada = value!;
                        });
                      },
                      dropdownColor: Colors.grey[200],
                      items: List.generate(5, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text('Turma ${index + 1}'),
                        );
                      }),
                    ),
                  ),
                ],
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
                  'Cadastrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
