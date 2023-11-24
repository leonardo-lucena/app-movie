import 'package:flutter/material.dart';
import 'package:gerador_de_filmes/views/tela_detalhes.dart';
import 'package:http/http.dart' as http;
import 'package:gerador_de_filmes/utils/constants.dart';

class CustomCardWidget extends StatelessWidget {
  final String imageUrl;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String id;

  CustomCardWidget({
    required this.imageUrl,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.id,
  });

  Future<void> _removerFilme(BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'https://app-movie-368b8-default-rtdb.firebaseio.com/filmes/${id}.json'),
      );

      if (response.statusCode >= 400) {
        _exibirErro(context, 'Erro ao remover o filme. sadadadadd');
      } else {
        _exibirMensagem(context, 'Filme removido com sucesso!');
      }
    } catch (error) {
      print(error);
      _exibirErro(context, 'Ocorreu um erro ao remover o filme falha.');
    }
  }

  void _exibirMensagem(BuildContext context, String mensagem) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sucesso!'),
        content: Text(mensagem),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _exibirErro(BuildContext context, String mensagem) {
    print('Exceção capturada: $mensagem');

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um erro!'),
        content: Text(mensagem),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/original${imageUrl}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(text2 + '\n'),
                  Row(
                    children: <Widget>[
                      Text(
                        'Lançamento: ${text3.split('-')[2] + '/' + text3.split('-')[1] + '/' + text3.split('-')[0]}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Text(
                        '${text4}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.visibility_outlined),
                        color: Colors.orangeAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalhesFilme(nomeFilme: text1),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red.shade500,
                        onPressed: () {
                          _removerFilme(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Builder(
      builder: (context) => Scaffold(
        body: CustomCardWidget(
          imageUrl: 'img', // Substitua pela URL da sua imagem
          text1: 'texto 1',
          text2: 'texto 2',
          text3: 'texto 3',
          text4: 'texto 4',
          id: '',
        ),
      ),
    ),
  ));
}
