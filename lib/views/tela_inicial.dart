import 'package:flutter/material.dart';
import '../routers/routers.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TelaInicial> {
  String _usuario = "";
  String _telefone = "";

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
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.clear),
                  labelText: "Usuário",
                  hintText: 'Nome de Usuário',
                  helperText: 'Insira seu nome de Usuário'),
              onChanged: (text) {
                _usuario = text;
              },
            ),
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                suffixIcon: Icon(Icons.clear),
                labelText: "Telefone",
                hintText: 'Telefone',
                helperText: 'Insira seu telefone',
              ),
              onChanged: (text) {
                _telefone = text;
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
                    // Gerar um novo filme
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.telaGeracao,
                    );
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
