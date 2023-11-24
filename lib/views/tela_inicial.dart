import 'package:flutter/material.dart';
import 'tela_de_geracao.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TelaInicial> {
  String _usuario = "";
  String _telefone = "";

  @override
  void initState() {
    super.initState();
    _loadUserData().then((_) {
      if (_usuario.isNotEmpty && _telefone.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TelaGeracao()),
          );
        });
      }
    });
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usuario = (prefs.getString('usuario') ?? "");
      _telefone = (prefs.getString('telefone') ?? "");
    });
  }

  _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usuario', _usuario);
    prefs.setString('telefone', _telefone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerador e Favoritador de Filmes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: TextEditingController(text: _usuario),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.clear),
                  labelText: "Usuário",
                  hintText: 'Nome de Usuário',
                  helperText: 'Insira seu nome de Usuário'),
              onChanged: (text) {
                _usuario = text;
                _saveUserData();
              },
            ),
            TextField(
              controller: TextEditingController(text: _telefone),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                suffixIcon: Icon(Icons.clear),
                labelText: "Telefone",
                hintText: 'Telefone',
                helperText: 'Insira seu telefone',
              ),
              onChanged: (text) {
                _telefone = text;
                _saveUserData();
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_usuario.isNotEmpty && _telefone.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaGeracao()),
                      );
                    } else {
                      // Mostrar uma mensagem para o usuário preencher os campos
                    }
                  },
                  child: const Text("Avançar"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
