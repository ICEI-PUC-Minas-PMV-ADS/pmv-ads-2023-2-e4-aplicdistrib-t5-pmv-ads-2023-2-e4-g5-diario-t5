import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaCurriculo(),
    );
  }
}

class TelaCurriculo extends StatefulWidget {
  @override
  _TelaCurriculoState createState() => _TelaCurriculoState();
}

class _TelaCurriculoState extends State<TelaCurriculo> {
  String jsonResult = '';

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/apibncc/bncc_lingua_portuguesa_ef'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar currículo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await fetchData();
              },
              child: Text('Press to Fetch Data'),
            ),
            SizedBox(height: 20),
            Text('JSON Result:'),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  jsonResult,
                  style: TextStyle(fontFamily: 'Courier New', fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
