import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maincolor/bloc/pokemon_color_bloc.dart';
import 'package:maincolor/widget/pokemon_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static PokemonColorBloc colorBloc = PokemonColorBloc();
  MyApp();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: colorBloc.colorStream.stream,
      builder: (ctx, snapshot) =>  MyHomePage(themeColor: snapshot.data)
    );
  }
}

class MyHomePage extends StatelessWidget {
  final MaterialColor themeColor;
  MyHomePage({this.themeColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        title: "Pokemon colors",
        theme: ThemeData(
          primarySwatch: themeColor,
          textTheme: GoogleFonts.pressStart2PTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: PokemonScreen(themeColor),
      );
  }
}
