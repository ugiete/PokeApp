import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemons/models/pokemon.dart';

class PokeApi {
  static Future<List<Map<String, dynamic>>?> listPokemons(int page, {int limit = 10}) async {
    int offset = page * limit;
    Uri uri = Uri.https("pokeapi.co", "/api/v2/pokemon", {"limit": limit.toString(), "offset": offset.toString()});

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> results = [];

      for (Map<String, dynamic> result in jsonDecode(response.body)['results']) {
        results.add(result);
      }

      return results;
    }

    return null;
  }

  static Future<PokemonModel?> getDetails(String url) async {
    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}