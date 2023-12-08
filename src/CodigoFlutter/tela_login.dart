import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro_bncc_flutter/main.dart';
import 'package:pro_bncc_flutter/tela_busca_turma.dart';
import 'package:pro_bncc_flutter/tela_home.dart';
import 'tela_cadastro.dart';
import 'tela_busca_turma.dart';
import 'main.dart';
import 'tela_home.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool successMessageVisible = false;
  bool errorMessageVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.9).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _signIn() async {
    String email = emailController.text;
    String senha = passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);

      String userEmail = userCredential.user?.email ?? "Email não disponível";

      print("Logar usuário: sucesso!! E-mail: $userEmail");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeMainScreen()));

      setState(() {
        successMessageVisible = true;
        errorMessageVisible = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print("Logar usuário: erro " + error.toString());

      setState(() {
        errorMessageVisible = true;
        successMessageVisible = false;
      });
    }
  }

  void _resetPassword() async {
    String email = emailController.text;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      print("Redefinição de senha: e-mail enviado com sucesso!");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Link de redefinição de senha enviado para o e-mail!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print("Redefinição de senha: erro " + error.toString());
    }
  }

  void _showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Esqueceu sua senha?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Digite seu e-mail para redefinir sua senha:'),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetPassword();
              },
              child: Text('Enviar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.white],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animation.value,
                        child: Container(
                          height: 300,
                          width: 300,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        _controller.reverse();
                        successMessageVisible = false;
                        errorMessageVisible = false;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        _controller.reverse();
                        successMessageVisible = false;
                        errorMessageVisible = false;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  errorMessageVisible
                      ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Usuário e/ou senha incorreto(s)',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                      : SizedBox(),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: successMessageVisible
                        ? 200
                        : MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        _signIn();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.0)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: successMessageVisible
                            ? Center(
                          child: Text(
                            'Logado com sucesso!',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                            : Center(
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.lightBlue],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _showResetPasswordDialog,
                    child: Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
