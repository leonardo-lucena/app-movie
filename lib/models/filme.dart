import 'package:flutter/material.dart';

class Filme {
  String id;
  String nome;
  String ano_de_lancamento;
  String rating;
  String descricao;
  String thumbnail;

  Filme({
    required this.id,
    required this.nome,
    required this.ano_de_lancamento,
    required this.rating,
    required this.descricao,
    required this.thumbnail,
  });

  // Método factory para criar uma instância de Filme a partir de um mapa
  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      ano_de_lancamento: json['ano_de_lancamento'] ?? '',
      rating: json['rating'] ?? '',
      descricao: json['descricao'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}
