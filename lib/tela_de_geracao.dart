import 'package:flutter/material.dart';
import 'tela_filme_gerado.dart';
import 'tela_favoritos.dart';

class TelaGeracao extends StatefulWidget {
  @override
  _TelaGeracaoState createState() => _TelaGeracaoState();
}

class _TelaGeracaoState extends State<TelaGeracao> {
  int _selectedIndex = 0;
  String? categoriaSelecionada;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerador e Favoritador de Filmes"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecione uma categoria',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            DropdownButton<String>(
              items: [
                DropdownMenuItem<String>(
                  value: 'acao',
                  child: Text('Ação'),
                ),
                DropdownMenuItem<String>(
                  value: 'aventura',
                  child: Text('Aventura'),
                ),
                DropdownMenuItem<String>(
                  value: 'comedia',
                  child: Text('Comédia'),
                ),
                DropdownMenuItem<String>(
                  value: 'suspense',
                  child: Text('Suspense'),
                ),
              ],
              onChanged: (String? selectedCategory) {
                // Atualiza a variável com a categoria selecionada
                categoriaSelecionada = selectedCategory;
                // Rebuild para refletir a mudança na UI
                setState(() {});
              },
              hint: Text('Escolha uma categoria'),
              // Exibe o valor escolhido no texto do dropdown
              value: categoriaSelecionada,
            ),
            const SizedBox(height: 20.0),
            if (_selectedIndex == 0)
              ElevatedButton(
                onPressed: () {
                  // Redireciona o usuário para a tela de filme gerado
                  // Passando a categoria selecionada como parâmetro
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        //builder: (context) => FilmeGerado(
                        //categoriaSelecionada: categoriaSelecionada!,
                        //),
                        builder: (context) => FilmeGerado()),
                  );
                },
                child: const Text("Gerar"),
              ),
            if (_selectedIndex == 1)
              TextButton(
                onPressed: () {
                  // Acessar a lista de favoritos
                },
                child: const Text("Favoritos"),
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
          selectedItemColor: Colors.blue,
          onTap: (index) {
            if (index == 1) {
              // Redireciona o usuário para a tela de favoritos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaFavoritos()),
              );
            }
          }),
    );
  }

  // Função para rebuild da UI após a seleção da categoria
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
