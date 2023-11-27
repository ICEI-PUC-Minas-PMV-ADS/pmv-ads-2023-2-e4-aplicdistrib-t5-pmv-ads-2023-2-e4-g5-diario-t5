import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tela_login.dart';
import 'tela_home.dart';
import 'tela_cadastro.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool successMessageVisible = false;
  bool errorMessageVisible = false;
  String errorMessage = "";

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

  void _signUp() async {
    String email = emailController.text;
    String senha = passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);

      setState(() {
        successMessageVisible = true;
        errorMessageVisible = false;
        _controller.reverse();
      });

      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      });
    } catch (error) {
      print("Erro ao cadastrar: $error");
      setState(() {
        errorMessageVisible = true;
        errorMessage = "Email inválido. Digite outro.";
      });
    }
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
              colors: [Colors.blue, Colors.white],
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
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: successMessageVisible
                        ? 200
                        : MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _signUp();
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
                                'Usuário criado com sucesso!',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                                : Center(
                              child: Text(
                                'Cadastrar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        if (errorMessageVisible)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        SizedBox(height: 10),
                        CupertinoButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.symmetric(vertical: 20),
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Voltar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
