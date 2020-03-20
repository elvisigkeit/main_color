import 'package:flutter/material.dart';

import '../main.dart';

class PokemonImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/149.png",
      frameBuilder:  (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
        Semantics oie = child;
        if (wasSynchronouslyLoaded)
          return child;

        if(oie.child is RawImage){
          RawImage ri = oie.child;
          MyApp.colorBloc.imageStream.add(ri.image);
        }

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