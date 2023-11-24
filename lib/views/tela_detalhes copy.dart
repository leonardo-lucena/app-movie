import 'package:flutter/material.dart';
import 'filme_info_request.dart';

//void main() => runApp(const DetalhesFilme());

class DetalhesFilmeCopy extends StatefulWidget {
  final Map<String, dynamic> filme;
  const DetalhesFilmeCopy({Key? key, required this.filme}) : super(key: key);

  @override
  _DetalhesFilmeState createState() => _DetalhesFilmeState();
}

class _DetalhesFilmeState extends State<DetalhesFilmeCopy> {
  Map<String, dynamic>? filme;
  FilmeInfoRequest filmeInfoRequest = FilmeInfoRequest();

  @override
  void initState() {
    super.initState();
    filmeInfoRequest.getFilmePorNome('${filme}').then((filme) {
      setState(() {
        this.filme = filme;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do Filme'),
          leading: BackButton(),
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
      ),
    );
  }
}
