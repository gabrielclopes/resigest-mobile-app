import 'package:flutter/material.dart';

import 'Decoration.dart';



class MainButton extends StatelessWidget {
  static final Color colorPri = Color(0xFF01A6E8); //azul claro
  static final Color colorSec = Color(0xFF014891);

  final String text;
  final Function onPressed;
  final double? size;


  const MainButton({required this.onPressed, required this.text, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorPri, colorSec],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Container(
          width: 25 * size!,
          height: 5 * size!,
          alignment: Alignment.center,
          child: Text(this.text, style: TextStyle(fontSize: 2*size!),
          ),
        ),
      ),
      style: DecorationClass().buttonStyle(),



    );
  }
}

