import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maincolor/widget/pokemon_list.dart';

import '../network_manager.dart';

class ListBloc {
  ScrollController scrollController = ScrollController();
  StreamController<List<Pokemon>> listStream = StreamController();
  StreamController requestStream = StreamController();

  List<Pokemon> list = List();
  int listIndex = 0;

  ListBloc() {
    scrollController.addListener(() {
      if (scrollController.offset >= scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        requestStream.add("go");
      }
    });
    requestStream.stream.listen((event) async {
      List<Pokemon> listReceived = await NetworkManager.requireListPokemons(listIndex);
      listReceived.insertAll(0, list);
      list = listReceived;
      listStream.add(list);
      listIndex++;
    });
    requestStream.add("go");
  }

}

class PokemonListScreen extends StatelessWidget{
  static ListBloc listBloc = ListBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POKEMONS!!",
        style: Theme.of(context).textTheme.subtitle2,
      ),),
      body: StreamBuilder<List<Pokemon>>(
        stream: listBloc.listStream.stream,
        builder: (context, snapshot) {
          return PokemonList(snapshot.data);
        }
      ),
    );
  }

}