import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

Future<Map<String, dynamic>> getFilmeAleatorioPorGenero(int id) async {
  const String apiKey = '39d0df6124fbb8624eb376008182c94e';
  List<Map<String, dynamic>> filmes = [];

  for (int pageNumber = 1; filmes.length < 200; pageNumber++) {
    final String url =
        'https://api.themoviedb.org/3/discover/movie?with_genres=$id&api_key=$apiKey&page=$pageNumber';
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      filmes.addAll(
          (json['results'] as List<dynamic>).cast<Map<String, dynamic>>());
    } else {
      print('Erro ao fazer a solicitação: ${response.statusCode}');
      break;
    }
  }

  if (filmes.isNotEmpty) {
    final random = Random();
    return filmes[random.nextInt(filmes.length)];
  } else {
    return {};
  }
}

void main() async {
  const int idAcao = 28;
  final Map<String, dynamic> filmeAcao =
      await getFilmeAleatorioPorGenero(idAcao);

  if (filmeAcao != {}) {
    print('Título: ${filmeAcao['title']}');
    print('Ano de lançamento: ${filmeAcao['release_date']}');
  } else {
    print('Nenhum filme encontrado.');
  }
}
