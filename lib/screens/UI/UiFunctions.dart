import 'package:flutter/material.dart';

class TextBoxforAll extends StatelessWidget {
  String text;
  double spacing;
  double size;
  TextAlign align;
  Color colors;
  FontWeight weight;

  TextBoxforAll(this.text, this.spacing, this.size, this.align,
      {this.colors = Colors.black, this.weight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: align,
      style: TextStyle(

        color: colors,
          fontWeight: weight, letterSpacing: spacing,
      fontSize: size),
    );
  }
}


final snackBarInternetError = SnackBar(
    content: Text(
      "Please Connect the Internet",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
    ),
  );

//
// class ConstButton extends StatelessWidget {
//   VoidCallback onPressed;
//   double elevation;
//   String childText;
//   Color color;
//
//   ConstButton(this.elevation, this.childText, this.onPressed, this.color);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15)),
//       elevation: elevation,
//       //color: childText.contains('Cancel') ? Colors.yellow[300] :
//       onPressed: onPressed,
//       child: TextBoxforAll(childText, 2.0, 12.0, TextAlign.center),
//     );
//   }
// }




