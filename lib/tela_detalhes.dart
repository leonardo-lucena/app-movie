import 'package:flutter/material.dart';
import 'filme_info_request.dart';

//void main() => runApp(const DetalhesFilme());

class DetalhesFilme extends StatefulWidget {
  final String nomeFilme;
  const DetalhesFilme({Key? key, required this.nomeFilme}) : super(key: key);

  @override
  _DetalhesFilmeState createState() => _DetalhesFilmeState();
}

class _DetalhesFilmeState extends State<DetalhesFilme> {
  Map<String, dynamic>? filme;
  FilmeInfoRequest filmeInfoRequest = FilmeInfoRequest();

  @override
  void initState() {
    super.initState();
    filmeInfoRequest.getFilmePorNome(widget.nomeFilme).then((filme) {
      setState(() {
        this.filme = filme;
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
      ),
      body: Column(
        children: [
          // Centralize a imagem
          Expanded(
            child: Image(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/original${filme?['thumbnail']}'),
            ),
          ),

          // Alinhe o conteúdo restante à direita
          Expanded(
            child: Container(
              child: Column(
                children: [
                  // Título do filme
                  Text(
                    'Título do filme: ${filme?['nome']}',
                    style: TextStyle(fontSize: 20),
                  ),

                  // Ano de lançamento do filme
                  Text(
                    'Ano de lançamento: ${filme?['ano_de_lancamento']}',
                    style: TextStyle(fontSize: 16),
                  ),

                  // Avaliação do filme
                  Text(
                    'Avaliação: ${filme?['rating']}',
                    style: TextStyle(fontSize: 14),
                  ),

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
    );
  }
}
