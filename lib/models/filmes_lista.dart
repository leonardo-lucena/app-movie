import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gerador_de_filmes/models/filme.dart';
import 'package:gerador_de_filmes/utils/constants.dart';
import 'package:http/http.dart' as http;

class FilmesLista with ChangeNotifier {
  final List<Filme> _items = [];

  List<Filme> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constants.filmesBaseUrl}.json'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((filmeId, filmeData) {
      _items.add(
        Filme(
          id: filmeId,
          nome: filmeData['nome'],
          ano_de_lancamento: filmeData['ano_de_lancamento'],
          rating: filmeData['rating'],
          descricao: filmeData['descricao'],
          thumbnail: filmeData['thumbnail'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> salvarFilme(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final filme = Filme(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      nome: data['nome'] as String,
      ano_de_lancamento: data['ano_de_lancamento'] as String,
      rating: data['rating'] as String,
      descricao: data['descricao'] as String,
      thumbnail: data['thumbnail'] as String,
    );

    if (hasId) {
      return atualizarFilme(filme);
    } else {
      return addFilme(filme);
    }
  }

  Future<void> addFilme(Filme filme) async {
    final response = await http.post(
      Uri.parse('${Constants.filmesBaseUrl}.json'),
      body: jsonEncode(
        {
          "nome": filme.nome,
          "ano_de_lancamento": filme.ano_de_lancamento,
          "rating": filme.rating,
          "descricao": filme.descricao,
          "thumbnail": filme.thumbnail,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Filme(
      id: id,
      nome: filme.nome,
      ano_de_lancamento: filme.ano_de_lancamento,
      rating: filme.rating,
      descricao: filme.descricao,
      thumbnail: filme.thumbnail,
    ));
    notifyListeners();
  }

  Future<void> atualizarFilme(Filme filme) async {
    int index = _items.indexWhere((p) => p.id == filme.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.filmesBaseUrl}/${filme.id}.json'),
        body: jsonEncode(
          {
            "nome": filme.nome,
            "ano_de_lancamento": filme.ano_de_lancamento,
            "rating": filme.rating,
            "descricao": filme.descricao,
            "thumbnail": filme.thumbnail,
          },
        ),
      );

      _items[index] = filme;
      notifyListeners();
    }
  }

  Future<void> removerFilme(Filme filme) async {
    int index = _items.indexWhere((p) => p.id == filme.id);

    if (index >= 0) {
      final filme = _items[index];
      _items.remove(filme);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.filmesBaseUrl}/${filme.id}.json'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, filme);
        notifyListeners();
      }
    }
  }
}
