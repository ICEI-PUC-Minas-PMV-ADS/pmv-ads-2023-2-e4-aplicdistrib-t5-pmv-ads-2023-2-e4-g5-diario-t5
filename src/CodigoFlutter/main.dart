import 'package:flutter/material.dart';
import 'package:pro_bncc_flutter/tela_curriculo.dart';
import 'package:pro_bncc_flutter/tela_login.dart';
import 'tela_busca_alunos.dart';
import 'tela_home.dart';
import 'tela_alunos.dart';
import 'tela_inserir_aluno.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tela_update_alunos.dart';
import 'tela_atividades_2.dart';
import 'tela_curriculo.dart';
import 'tela_editar_avaliacao.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SignInPage(),
  ));
}

