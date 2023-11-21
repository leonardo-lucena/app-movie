import 'package:flutter/material.dart';

void main() => runApp(const DetalhesFilme());

class DetalhesFilme extends StatelessWidget {
  const DetalhesFilme({super.key});

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
                image: AssetImage('imagem.png'),
              ),
            ),

            // Alinhe o conteúdo restante à direita
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    // Título do filme
                    Text(
                      'Título do filme',
                      style: TextStyle(fontSize: 20),
                    ),

                    // Ano de lançamento do filme
                    Text(
                      'Ano de lançamento',
                      style: TextStyle(fontSize: 16),
                    ),

                    // Avaliação do filme
                    Text(
                      'Avaliação',
                      style: TextStyle(fontSize: 14),
                    ),

                    // Descrição
                    Text(
                      'Descrição',
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
