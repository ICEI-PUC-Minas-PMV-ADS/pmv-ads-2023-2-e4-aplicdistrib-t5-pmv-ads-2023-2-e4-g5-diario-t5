import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Importa a biblioteca Cupertino
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tela_login.dart';
import 'tela_home.dart';
import 'tela_cadastro.dart';
import 'tela_home.dart';
import 'tela_inserir_aluno.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }
}
