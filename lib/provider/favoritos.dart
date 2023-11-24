import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerador_de_filmes/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../models/filme.dart';

class Users with ChangeNotifier {
  final Map<String, Filme> _items = {};
  final _baseURL = Constants.filmesBaseUrl;

  List<Filme> get all {
    return [..._items.values];
  }

  void addFavorito(Filme filme) {
    http.post(Uri.parse('$_baseURL/favoritos.json'),
        body: jsonEncode({
          "nome": filme.nome,
          "ano_de_lancamento": filme.ano_de_lancamento,
          "rating": filme.rating,
          "descricao": filme.descricao,
          "thumbnail": filme.thumbnail,
        }));
  }

  int get count {
    return _items.length;
  }

  Filme byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Filme filme) {
    if (filme == null) {
      return;
    }

    if (filme.id != null &&
        filme.id.trim().isNotEmpty &&
        _items.containsKey(filme.id)) {
      _items.update(
          filme.id,
          (_) => Filme(
                id: filme.id,
                nome: filme.nome,
                ano_de_lancamento: filme.ano_de_lancamento,
                rating: filme.rating,
                descricao: filme.descricao,
                thumbnail: filme.thumbnail,
              ));
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
          id,
          () => Filme(
                id: filme.id,
                nome: filme.nome,
                ano_de_lancamento: filme.ano_de_lancamento,
                rating: filme.rating,
                descricao: filme.descricao,
                thumbnail: filme.thumbnail,
              ));
    }

    notifyListeners();
  }

  void remove(Filme filme) {
    if (filme != null && filme.id != null) {
      _items.remove(filme.id);
      notifyListeners();
    }
  }
}
