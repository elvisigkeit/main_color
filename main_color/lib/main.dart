import 'dart:async';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

class Bloc {
  StreamController<MaterialColor> bout = StreamController();
  StreamController<ui.Image> bin = StreamController();
  StreamController<int> indexin = StreamController();
  int indexOfColors = 0;
  PaletteGenerator paletteGenerator;

  Bloc() {
    bin.stream.listen((widget) async {
      if(widget != null) {
        int i = 0;
        paletteGenerator = await PaletteGenerator.fromImage(widget);
        addColorInBout();
      }
    });
    indexin.stream.listen((index) {
      indexOfColors = index;
      addColorInBout();
    });
  }

  void addColorInBout() {
    int i = 0;
    for (ui.Color color in paletteGenerator.colors) {
      if (i == indexOfColors) {
        bout.add(materialFromColor(color));
      }
      i++;
    }
  }

  MaterialColor materialFromColor(ui.Color color) {
    int intColor = color.value;
    Map<int, Color> colorCodes = {
      50: color.withOpacity(.1),
      100: color.withOpacity(.2),
      200: color.withOpacity(.3),
      300: color.withOpacity(.4),
      400: color.withOpacity(.5),
      500: color.withOpacity(.6),
      600: color.withOpacity(.7),
      700: color.withOpacity(.8),
      800: color.withOpacity(.9),
      900: color.withOpacity(1.0),
    };
    return MaterialColor(intColor, colorCodes);
  }

  void dispose() {
    bout.close();
    bin.close();
    indexin.close();
  }
}

class MyApp extends StatelessWidget {
  static Bloc bloc = Bloc();
  MyApp();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.bout.stream,
      builder: (ctx, snapshot) =>  MyHomePage(newColor: snapshot.data)
    );
  }
}

class MyHomePage extends StatelessWidget {
  final MaterialColor newColor;
  MyHomePage({this.newColor = Colors.green});

  final Image image = Image.network(
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/149.png",
    frameBuilder:  (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
      Semantics oie = child;
      if (wasSynchronouslyLoaded)
        return child;

      if(oie.child is RawImage){
        RawImage ri = oie.child;
        MyApp.bloc.bin.add(ri.image);
      }

      return AnimatedOpacity(
        child: child,
        opacity: frame == null ? 0 : 1,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        title: 'matapp title',
        theme: ThemeData(
          primarySwatch: newColor,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("scaffold title"),
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
                      child: image,
                    ),
                  ),
                ),
                Flexible(flex:1, child: Container(),),
                Flexible(flex:1, child:
                  Row(children: <Widget>[
                    Flexible(flex:1, child: Container(),),
                    ButtonBar(children: <Widget>[
                      RaisedButton(
                        child: Text("Theme 1"),
                        color: newColor == null ? Colors.black : newColor.shade900,
                        onPressed: ()=>MyApp.bloc.indexin.add(0),
                      ),
                      RaisedButton(
                        child: Text("Theme 2"),
                        color: newColor == null ? Colors.black : newColor.shade900,
                        onPressed: ()=>MyApp.bloc.indexin.add(1),
                      ),
                      RaisedButton(
                        child: Text("Theme 3"),
                        color: newColor == null ? Colors.black : newColor.shade900,
                        onPressed: ()=>MyApp.bloc.indexin.add(2),
                      ),
                    ],),
                    Flexible(flex:1, child: Container(),),
                  ],)),
                Flexible(flex:1, child: Container(),),
              ],
            ),
          ),
        )
      );
  }
}
