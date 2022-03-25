import 'package:flutter/material.dart';
import 'package:pokemons/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonCard({required this.pokemon, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(pokemon.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width: 160,
            height: 160,
            child: Image.network(pokemon.sprite, fit: BoxFit.contain)
          )
        ],
      ),
    );
  }
}