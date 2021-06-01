import 'package:flutter/cupertino.dart';

const kSecondaryColor = Color(0xFF8B94BC);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFFC1C1C1);
const kBlackColor = Color(0xFF101010);
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const double kDefaultPadding = 20.0;

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
