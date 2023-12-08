import 'package:flutter/material.dart';
import 'package:pro_bncc_flutter/tela_atividades_2.dart';
import 'tela_alunos.dart';
import 'tela_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tela_curriculo.dart';

void main() {
  runApp(MaterialApp(
    home: HomeMainScreen(),
  ));
}
class HomeMainScreen extends StatefulWidget {
  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}
class _HomeMainScreenState extends State<HomeMainScreen> {
  int _currentIndex = 0;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    setState(() {
      _user = user;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(fontSize: 30, fontFamily: 'Pacifico', color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: _user != null
                ? Icon(Icons.account_circle, color: Colors.white, size: 30)
                : Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              _showUserInfoDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
        ],
      ),
      body: _getBodyWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.green,
        elevation: 10,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people, size: 30),
            label: 'Alunos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note, size: 30),
            label: 'Frequência',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, size: 30),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, size: 30),
            label: 'Currículo',
          ),
        ],
      ),
    );
  }

  Widget _getBodyWidget() {
    switch (_currentIndex) {
      case 0:
      // Alunos
        return Container();
      case 1:
      // Frequência
        return Center(child: Text('Frequencia'));
      case 2:
      // Atividades
        return TelaAtividades();
      case 3:
      // Currículo
        return TelaCurriculo();
      default:
        return Container();
    }
  }
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlunosScreen()),
        );
      }
    });
  }

  void _showUserInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informações do usuário'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8),
              Text('Email: ${_user?.email ?? 'Não disponível'}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
