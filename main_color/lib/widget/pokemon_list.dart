import 'package:flutter/material.dart';
import 'package:maincolor/main.dart';
import 'package:maincolor/widget/pokemon_list_screen.dart';
import 'package:maincolor/widget/pokemon_screen.dart';

import '../network_manager.dart';

class PokemonList extends StatelessWidget{
  final List<Pokemon> list;
  MaterialColor themeColor;
  PokemonList(this.list, this.themeColor);

  Route createRoute(Pokemon pokemon) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PokemonScreen(pokemon, themeColor),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        controller: MyApp.listBloc.scrollController,
        itemBuilder: (ctx, idx) {
          return Container(
              height: 50.0,
              child: OutlineButton(
                child: Center(child: Text(list[idx].name)),
                onPressed: ()=>
                    Navigator.of(context).push(createRoute(list[idx])),
              )
          );
        });
  }
}