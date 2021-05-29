import 'package:flutter/cupertino.dart';

class Constants {

  static const String youTubeURL = 'https://www.youtube.com/watch?v=';
  ///Dynamic Width
  static double dynamicWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  ///Dynamic height
  static double dynamicHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
