import 'package:flutter/material.dart';

/// Flutter code sample for custom list items.

void main() => runApp(const FilmeGerado());

class FilmeGerado extends StatefulWidget {
  const FilmeGerado({super.key});

  @override
  State<FilmeGerado> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<FilmeGerado> {
  int _selectedIndex = 0;
  List<Filme> filmes = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filme Gerado')),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              decoration: const BoxDecoration(color: Colors.blue),
            ),
            title: Text(filmes[index].titulo),
            subtitle: Text(
              'Código IMDb: ${filmes[index].imdb ?? 'N/A'}',
            ),
            onTap: () => _onItemTapped(index),
          );
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
        onTap: _onItemTapped,
      ),
    );
  }

  // Gera um novo filme
  void _gerarFilme() {
    // Gera um título aleatório
    String titulo = 'Filme gerado';
    // Gera um código IMDb aleatório
    String imdb = 'tt9999999';

    // Cria um novo filme
    Filme filme = Filme(titulo: titulo, imdb: imdb);

    // Adiciona o filme à lista
    filmes.add(filme);

    // Redireciona o usuário para a tela de favoritos
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilmeGerado(),
      ),
    );
  }
}

class Filme {
  final String titulo;
  final String? imdb;

  const Filme({
    required this.titulo,
    this.imdb,
  });
}
