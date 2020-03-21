import 'package:flutter/material.dart';
import 'package:maincolor/widget/pokemon_list_screen.dart';

import '../network_manager.dart';

class PokemonList extends StatelessWidget{
  final List<Pokemon> list;
  PokemonList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        controller: PokemonListScreen.listBloc.scrollController,
        itemBuilder: (ctx, idx) {
          return Container(
              height: 50.0,
              child: OutlineButton(
                child: Center(child: Text(list[idx].name)),
                onPressed: ()=>
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(list[idx].name))
                    ),
              )
          );
        });
  }
}