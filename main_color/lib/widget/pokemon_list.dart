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
    var screenSize = MediaQuery.of(context).size;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.2),
      itemCount: list == null ? 0 : list.length,
      controller: MyApp.listBloc.scrollController,
      itemBuilder: (ctx, idx) {
        return
            GestureDetector(
              onTap: ()=>
                  Navigator.of(context).push(createRoute(list[idx])),
              child: Card(
                color: Colors.white.withOpacity(0.87),
                margin: EdgeInsets.all(5.0),
                elevation: 1.0,
                child: Stack(children: <Widget>[
                    Positioned(
                        top: screenSize.height*0.0001,
                        left: screenSize.width*0.23,
                        child: Image.network("https://raw.githubusercontent.com/PokeAPI/"
                            "sprites/master/sprites/pokemon/${list[idx].number}.png",)
                    ),
                    Positioned(
                      top: screenSize.height*0.03,
                      left: screenSize.width*0.02,
                      child: Text(
                        list[idx].name,
                        style: TextStyle(
                          fontSize: 11
                        ),
                      )
                    ),
                ],),
              ),
            );
      });
  }
}