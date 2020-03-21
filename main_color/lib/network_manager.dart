import 'dart:convert';

import 'package:http/http.dart' as http;

class Pokemon {
  String name;
  String url;
  Pokemon(this.name, this.url);
}

class NetworkManager {
  static Future<List<Pokemon>> requireListPokemons(int index) async {
    List<Pokemon> resultList = List(); 
    int offset = index*20;
    var response = await http.get("https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=20");
    var resJson = json.decode(response.body);
    for (var item in resJson['results'])
      resultList.add(Pokemon(item['name'], item['url']));
    return resultList;
  }
}