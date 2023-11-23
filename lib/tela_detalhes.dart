import 'package:flutter/material.dart';
import 'package:gerador_de_filmes/gerar_filme.dart';
import 'filme_info_request.dart';
import 'tela_favoritos.dart';
import 'tela_de_geracao.dart';

//void main() => runApp(const DetalhesFilme());

class DetalhesFilme extends StatefulWidget {
  final String nomeFilme;
  const DetalhesFilme({Key? key, required this.nomeFilme}) : super(key: key);

  @override
  _DetalhesFilmeState createState() => _DetalhesFilmeState();
}

class _DetalhesFilmeState extends State<DetalhesFilme> {
  int _selectedIndex = 0;
  Map<String, dynamic>? filme;
  FilmeInfoRequest filmeInfoRequest = FilmeInfoRequest();
  bool isLoading = true;
  bool isFavorito = false;

  @override
  void initState() {
    super.initState();
    filmeInfoRequest.getFilmePorNome(widget.nomeFilme).then((filme) {
      setState(() {
        this.filme = filme;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Filme'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isFavorito ? Icons.star : Icons.star_border,
              color: isFavorito ? Colors.yellow : null,
            ),
            onPressed: () {
              setState(() {
                isFavorito = !isFavorito;
              });
              final snackBar = SnackBar(
                content: Text(isFavorito
                    ? 'Adicionado aos favoritos!'
                    : 'Removido dos favoritos!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 5)),
                // Centralize a imagem
                Expanded(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/original${filme?['thumbnail']}',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Column(
                        children: <Widget>[
                          child,
                          LinearProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Alinhe o conteúdo restante à direita
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        // Título do filme
                        const SizedBox(height: 5.0),
                        Text(
                          'Título do filme: ${filme?['nome']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 5.0),
                        // Ano de lançamento do filme
                        Text(
                          'Ano de lançamento: ${filme?['ano_de_lancamento']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5.0),
                        // Avaliação do filme
                        Text(
                          'Avaliação: ${filme?['rating']}',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5.0),
                        // Descrição
                        Text(
                          'Descrição: ${filme?['descricao']}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
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
          onTap: (index) {
            if (index == 0) {
              // Redireciona o usuário para a tela de favoritos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaGeracao()),
              );
            }
            if (index == 1) {
              // Redireciona o usuário para a tela de favoritos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaFavoritos()),
              );
            }
          }),
    );
  }
}
