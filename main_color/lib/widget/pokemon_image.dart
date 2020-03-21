import 'package:flutter/material.dart';

import '../main.dart';

class PokemonImage extends StatelessWidget{
  final String pokemonNumber;
  PokemonImage(this.pokemonNumber);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonNumber.png",
      frameBuilder:  (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
        Semantics sem = child;
        if(sem.child is RawImage){
          RawImage ri = sem.child;
          if(MyApp.colorBloc.lastImage != ri.image){
            MyApp.colorBloc.lastImage = ri.image;
            MyApp.colorBloc.imageStream.add(ri.image);
          }
        }

        if (wasSynchronouslyLoaded)
          return child;

        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      },
    );;
  }
}