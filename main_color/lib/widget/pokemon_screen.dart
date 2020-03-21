import 'package:flutter/material.dart';
import 'package:maincolor/model/pokemon.dart';
import 'package:maincolor/widget/pokemon_image.dart';

import '../main.dart';

class PokemonScreen extends StatelessWidget {
  final Pokemon pokemon;
  PokemonScreen(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${pokemon.name} Colors",
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(flex:1, child: Container(),),
            Flexible(flex:4,
              child: Container(
                child: Transform.scale(
                  scale: 2.0,
                  child: PokemonImage(pokemon.number),
                ),
              ),
            ),
            Flexible(flex:1, child: Container(),),
            Flexible(flex:1, child:
            Row(children: <Widget>[
              Flexible(flex:1, child: Container(),),
              ButtonBar(children: <Widget>[
                RaisedButton(
                  child: Text("Theme1"),
                  color: Theme.of(context).primaryColor,
                  onPressed: ()=>MyApp.colorBloc.indexStream.add(0),
                ),
                RaisedButton(
                  child: Text("Theme2"),
                  color: Theme.of(context).primaryColor,
                  onPressed: ()=>MyApp.colorBloc.indexStream.add(1),
                ),
                RaisedButton(
                  child: Text("Theme3"),
                  color: Theme.of(context).primaryColor,
                  onPressed: ()=>MyApp.colorBloc.indexStream.add(2),
                ),
              ],),
              Flexible(flex:1, child: Container(),),
            ],)),
            Flexible(flex:1, child: Container(),),
          ],
        ),
      ),
    );
  }

}