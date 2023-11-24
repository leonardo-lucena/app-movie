import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gerador_de_filmes/models/filme.dart';
import 'package:gerador_de_filmes/models/filmes_lista.dart';
import 'package:gerador_de_filmes/utils/constants.dart';
import 'package:provider/provider.dart';
import 'filme_info_request.dart';
import 'tela_favoritos.dart';
import 'tela_de_geracao.dart';
import 'package:http/http.dart' as http;

class DetalhesFilme extends StatefulWidget {
  final String nomeFilme;
  const DetalhesFilme({Key? key, required this.nomeFilme}) : super(key: key);

  @override
  _DetalhesFilmeState createState() => _DetalhesFilmeState();
}

class _DetalhesFilmeState extends State<DetalhesFilme> {
  int _selectedIndex = 0;
  Map<String, dynamic>? filme;
  final _baseURL = Constants.filmesBaseUrl;
  FilmeInfoRequest filmeInfoRequest = FilmeInfoRequest();
  bool isLoading = true;
  bool isFavorito = false;

  @override
  void initState() {
    super.initState();
    _carregarFilme();
  }

  Future<void> _carregarFilme() async {
    try {
      final filme = await filmeInfoRequest.getFilmePorNome(widget.nomeFilme);
      setState(() {
        this.filme = filme;
        isLoading = false;
      });
    } catch (error) {
      _exibirErro('Ocorreu um erro ao carregar o filme.');
    }
  }

/*   Future<void> _salvarFilmeFavorito() async {
    try {
      final filmeFavorito = Filme(
        id: filme?['nome'],
        nome: filme?['nome'],
        ano_de_lancamento: 'teste',
        rating: filme?['rating'],
        descricao: filme?['descricao'],
        thumbnail: filme?['thumbnail'],
      );

      final filmesLista = Provider.of<FilmesLista>(context, listen: false);
      await filmesLista.addFilme(filmeFavorito);

      Navigator.of(context).pop();
      setState(() {
        isFavorito = !isFavorito;
      });
    } catch (error) {
      _exibirErro('Ocorreu um erro ao salvar o filme.');
    }
  } */

  Future<void> _favoritarFilme() async {
    try {
      final response = await http.post(
        Uri.parse(_baseURL),
        body: jsonEncode({
          "nome": filme?['nome'],
          "ano_de_lancamento": filme?['ano_de_lancamento'],
          "rating": filme?['rating'],
          "descricao": filme?['descricao'],
          "thumbnail": filme?['thumbnail'],
        }),
      );
      if (response.statusCode == 200) {
        _exibirMensagem('Filme favoritado com sucesso!');
      } else {
        _exibirErro('Erro ao salvar o filme.');
      }
    } catch (error) {
      _exibirErro('Ocorreu um erro ao salvar o filme.');
    }
  }

  void _exibirMensagem(String mensagem) {
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

  void _exibirErro(String mensagem) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Filme'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isFavorito ? Icons.star : Icons.star_border,
              color: isFavorito ? Colors.yellow : null,
            ),
            onPressed: _favoritarFilme,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 0.0),
                  //Padding(padding: const EdgeInsets.only(top: 5)),
                  Image.network(
                    'https://image.tmdb.org/t/p/original${filme?['thumbnail']}',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Column(
                        children: <Widget>[
                          child,
                          LinearProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ],
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4.0),
                        _detalheFilme('Título do Filme', filme?['nome']),
                        _detalheFilme(
                          'Ano de Lançamento',
                          filme?['ano_de_lancamento'] != null
                              ? '${filme?['ano_de_lancamento'].toString().split('-')[2]}/${filme?['ano_de_lancamento'].toString().split('-')[1]}/${filme?['ano_de_lancamento'].toString().split('-')[0]}'
                              : 'N/A',
                        ),
                        Row(
                          children: [
                            _detalheFilme(
                              'Avaliação',
                              filme?['rating'].toString() ?? 'N/A',
                              tamanhoFonte: 16,
                              negrito: true,
                            ),
                            Spacer(),
                            Icon(Icons.star, color: Colors.amber, size: 35),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        _detalheFilme('Descrição', filme?['descricao']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Gerar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaGeracao()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaFavoritos()),
            );
          }
        },
      ),
    );
  }

  Widget _detalheFilme(String titulo, String? valor,
      {double tamanhoFonte = 16, bool negrito = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Text(
          titulo,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          valor ?? 'N/A',
          style: TextStyle(
            fontSize: tamanhoFonte,
            fontWeight: negrito ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
