import 'package:flutter/material.dart';
import 'package:maincolor/main.dart';
import 'package:maincolor/model/pokemon.dart';
import 'package:maincolor/widget/pokemon_list.dart';

class PokemonListScreen extends StatelessWidget{
  final MaterialColor themeColor;

  PokemonListScreen(this.themeColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POKEMONS!!",
        style: Theme.of(context).textTheme.subtitle2,
      ),),
      body: StreamBuilder<List<Pokemon>>(
        stream: MyApp.listBloc.listStream.stream,
        builder: (context, snapshot) {
          return PokemonList(snapshot.data);
        }
      ),
    );
  }

}