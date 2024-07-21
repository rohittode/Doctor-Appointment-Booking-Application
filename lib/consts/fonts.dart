// import 'package:mediapp/consts/colors.dart';
import 'package:mediapp/consts/consts.dart';

class AppFonts {
  static String nunito = "nunito", nunitoBold = "nunito_bold";
}

class AppSizes {
  static const size12 = 12.0, size14 = 14.0, size16 = 16.0, size18 = 18.0, size20 = 20.0, size22 = 22.0, size34 = 34.0; 
}

// day -1 
// class AppStyles {
//   static TextStyle bold({double? size}) {
//     return TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: size,
//     );
//   }

  // Define other text styles here if needed
// }

class AppStyles {
  static normal({required String title, Color? color = Colors.black, double? size = 14, TextAlign? alignment}){
    return title.text.size(size).color(color).make();
  }

  static bold({required String title, Color? color = Colors.black, double? size = 14, TextAlign alignment = TextAlign.left}){
    return title.text.size(size).color(color).fontFamily(AppFonts.nunitoBold).align(alignment).make();
  }
}