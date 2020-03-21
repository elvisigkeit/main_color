import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:ui' as ui;
import 'dart:async';

class PokemonColorBloc {
  StreamController<MaterialColor> colorStream = StreamController();
  StreamController<ui.Image> imageStream = StreamController();
  StreamController<int> indexStream = StreamController();
  int indexOfColors = 0;
  PaletteGenerator paletteGenerator;
  ui.Image lastImage;

  PokemonColorBloc() {
    imageStream.stream.listen((widget) async {
      if(widget != null) {
        paletteGenerator = await PaletteGenerator.fromImage(widget);
        addColorInBout();
      }
    });
    indexStream.stream.listen((index) {
      indexOfColors = index;
      addColorInBout();
    });
    colorStream.add(materialFromColor(Colors.red));
  }

  void addColorInBout() {
    int i = 0;
    for (ui.Color color in paletteGenerator.colors) {
      if (i == indexOfColors) {
        colorStream.add(materialFromColor(color));
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
    colorStream.close();
    imageStream.close();
    indexStream.close();
  }
}