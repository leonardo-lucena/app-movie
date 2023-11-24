import 'package:flutter/material.dart';
import 'package:gerador_de_filmes/routers/routers.dart';

import 'views/tela_de_geracao.dart';
import 'views/tela_detalhes.dart';
import 'views/tela_favoritos.dart';
import 'views/tela_filme_gerado.dart';
import 'views/tela_inicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Filmes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.purple,
          secondary: Colors.deepOrange,
        ),
        fontFamily: 'Lato',
      ),
      //home: TelaInicial(),
      routes: {
        AppRoutes.home: (ctx) => const TelaInicial(),
        AppRoutes.telaGeracao: (ctx) => TelaGeracao(),
        AppRoutes.detalhes: (ctx) => const DetalhesFilme(
              nomeFilme: '',
            ),
        AppRoutes.favoritos: (ctx) => const TelaFavoritos(),
        AppRoutes.filmeGerado: (ctx) => const FilmeGerado(),
      },
      // debugShowCheckedModeBanner: false,
    );
  }
}
