import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getFilmePorNome(String nome) async {
  const String apiKey = '39d0df6124fbb8624eb376008182c94e';
  final String url =
      'https://api.themoviedb.org/3/search/movie?query=$nome&api_key=$apiKey&language=pt-BR';
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> resultado = json['results'][0];

    // Obtenha o ID do filme
    final int filmeId = resultado['id'];

    // Crie uma URL para a solicitação de classificação
    final String urlRating =
        'https://api.themoviedb.org/3/movie/$filmeId?api_key=$apiKey&language=pt-BR';

    // Faça a solicitação de classificação
    final http.Response responseRating = await http.get(Uri.parse(urlRating));

    // Decodifique a resposta
    final Map<String, dynamic> jsonRating = jsonDecode(responseRating.body);

    // Obtenha a classificação do filme
    final double rating = jsonRating['vote_average'];

    return {
      'thumbnail': resultado['poster_path'],
      'nome': resultado['title'],
      'ano_de_lancamento': resultado['release_date'],
      'rating': rating,
      'descricao': resultado['overview'],
    };
  } else {
    print('Erro ao fazer a solicitação: ${response.statusCode}');
    return {};
  }
}

void main() async {
  const String nomeFilme = 'The Batman';
  final Map<String, dynamic> filme = await getFilmePorNome(nomeFilme);

  print('Thumbnail: ${filme['thumbnail']}');
  print('Nome: ${filme['nome']}');
  print('Ano de lançamento: ${filme['ano_de_lancamento']}');
  print('Classificação: ${filme['rating']}');
  print('Descrição: ${filme['descricao']}');
}
