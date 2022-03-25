import 'package:flutter/material.dart';
import 'package:pokemons/views/pages/home_page.dart';

class PokeApp extends StatelessWidget {
  const PokeApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PokeApp',
      home: HomePage(),
    );
  }
}