import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gerador_de_filmes/components/itemFavorito.dart';
import 'package:gerador_de_filmes/models/filme.dart';
import 'package:gerador_de_filmes/utils/constants.dart';
import 'package:gerador_de_filmes/views/tela_de_geracao.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const TelaFavoritos());
}

class TelaFavoritos extends StatefulWidget {
  const TelaFavoritos({Key? key}) : super(key: key);

  @override
  State<TelaFavoritos> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  int _selectedIndex = 1;
  List<Filme> filmes = [];

  @override
  void initState() {
    super.initState();
    carregarFavoritos();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void erroAoCarregar() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um erro!'),
        content: const Text('Erro ao carregar os filmes.'),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> carregarFavoritos() async {
    try {
      final response = await http.get(Uri.parse(Constants.filmesBaseUrl));

      if (response.statusCode == 200) {
        if (response.body == 'null') return;

        Map<String, dynamic> data = jsonDecode(response.body);

        List<Filme> listaFilmes = [];

        data.forEach((filmeId, filmeData) {
          print(filmeData);
          listaFilmes.add(Filme(
            id: filmeId,
            nome: filmeData['nome'],
            ano_de_lancamento: filmeData['ano_de_lancamento'],
            rating: filmeData['rating'].toString(),
            descricao: filmeData['descricao'].substring(
                    0,
                    (filmeData['descricao'].length >= 250
                            ? filmeData['descricao'].length / 3
                            : filmeData['descricao'].length)
                        .round()) +
                '...',
            thumbnail: filmeData['thumbnail'],
          ));
        });

        setState(() {
          filmes = listaFilmes;
        });
      } else {
        print('Erro na solicitação: ${response.statusCode}');
        erroAoCarregar();
      }
    } catch (error) {
      print('Exceção: $error');
      erroAoCarregar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Favoritos')),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          Filme filme = filmes[index];
          return ItemFavorito(filme);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Gerar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaGeracao()),
            );
          }
        },
      ),
    );
  }
}
