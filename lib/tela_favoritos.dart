import 'package:flutter/material.dart';
import 'package:gerador_de_filmes/tela_de_geracao.dart';

/// Flutter code sample for custom list items.

void main() {
  runApp(const TelaFavoritos());
}

class TelaFavoritos extends StatefulWidget {
  const TelaFavoritos({super.key});

  @override
  State<TelaFavoritos> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Favoritos')),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        itemExtent: 106.0,
        children: <CustomListItem>[
          CustomListItem(
            imdb: 'Flutter',
            descricao: '999000',
            thumbnail: Container(
              decoration: const BoxDecoration(color: Colors.blue),
            ),
            titulo: 'The Flutter YouTube Channel',
          ),
          CustomListItem(
            imdb: 'Dash',
            descricao: 'descricao',
            thumbnail: Container(
              decoration: const BoxDecoration(color: Colors.yellow),
            ),
            titulo: 'Announcing Flutter 1.0',
          ),
        ],
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
              // Redireciona o usuário para a tela de favoritos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaGeracao()),
              );
            }
          }),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.thumbnail,
    required this.titulo,
    required this.imdb,
    required this.descricao,
  });

  final Widget thumbnail;
  final String titulo;
  final String imdb;
  final String descricao;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _VideoDescription(
              titulo: titulo,
              imdb: imdb,
              descricao: descricao,
            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    required this.titulo,
    required this.imdb,
    required this.descricao,
  });

  final String titulo;
  final String imdb;
  final String descricao;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            imdb,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            descricao,
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
