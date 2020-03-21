import 'package:flutter/material.dart';
import 'package:maincolor/main.dart';
import 'package:maincolor/model/pokemon.dart';
import 'package:maincolor/widget/pokemon_screen.dart';


class PokemonList extends StatelessWidget{
  final List<Pokemon> list;
  PokemonList(this.list);

  Route createRoute(Pokemon pokemon) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PokemonScreen(pokemon),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
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