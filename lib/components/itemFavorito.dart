import 'package:flutter/material.dart';
import 'package:gerador_de_filmes/components/item.dart';
import 'package:gerador_de_filmes/models/filme.dart';

class ItemFavorito extends StatelessWidget {
  final Filme filme;

  const ItemFavorito(this.filme);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: CustomCardWidget(
          imageUrl: filme.thumbnail,
          text1: filme.nome,
          text2: filme.descricao,
          text3: filme.ano_de_lancamento,
          text4: filme.rating,
          id: filme.id,
        ),
      ),
    );
  }
}
