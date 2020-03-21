import 'dart:convert';
import 'package:http/http.dart' as http;

class Pokemon {
  String name;
  String url;
  String number;
  Pokemon(this.name, this.url, this.number);
}

class NetworkManager {
  static Future<List<Pokemon>> requireListPokemons(int index) async {
    List<Pokemon> resultList = List();
    int offset = index*20;
    var response = await http.get("https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=20");
    var resJson = json.decode(response.body);
    for (var item in resJson['results']){
      String url = item['url'];
      String number = url.substring(34);
      number = number.substring(0, number.length-1);
      resultList.add(Pokemon(item['name'].toUpperCase(), url, number));
    }
    return resultList;
  }
}