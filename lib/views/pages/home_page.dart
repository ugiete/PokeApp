import 'package:flutter/material.dart';
import 'package:pokemons/components/pokemon_card.dart';
import 'package:pokemons/models/pokemon.dart';
import 'package:pokemons/services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  void nextPage() {
    setState(() {
      _currentPage++;
    });
  }

  void previousPage() {
    setState(() {
      _currentPage--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeApp'),
        actions: [
          IconButton(onPressed: previousPage, icon: const Icon(Icons.arrow_back)),
          IconButton(onPressed: nextPage, icon: const Icon(Icons.arrow_forward)),
        ],
      ),
      body: FutureBuilder(
        future: PokeApi.listPokemons(_currentPage),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Icon(Icons.error_outline, color: Colors.redAccent));
          }

          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Center(child: Icon(Icons.error_outline, color: Colors.yellowAccent));
            }
            else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: PokeApi.getDetails(snapshot.data![index]['url']),
                    builder: (BuildContext context, AsyncSnapshot<PokemonModel?> pokeSnapshot) {
                      if (pokeSnapshot.hasError) {
                        return ListTile(
                          title: Text(snapshot.data![index]['name']),
                          trailing: const Icon(Icons.warning_amber, color: Colors.red),
                        );
                      }

                      if (pokeSnapshot.hasData) {
                        if (pokeSnapshot.data == null) {
                          return ListTile(
                            title: Text(snapshot.data![index]['name']),
                            trailing: const Icon(Icons.warning_amber, color: Colors.yellow),
                          );
                        }
                        else {
                          return PokemonCard(pokemon: pokeSnapshot.data!);
                        }
                      }

                      return ListTile(
                        title: Text(snapshot.data![index]['name']),
                        subtitle: const LinearProgressIndicator(),
                      );
                    }
                  );
                }
              );
            }
          }

          return const CircularProgressIndicator();
        }
      ),
    );
  }
}