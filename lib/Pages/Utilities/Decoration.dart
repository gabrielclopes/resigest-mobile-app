import 'package:flutter/material.dart';

import '../../appController.dart';
import 'MyButtons.dart';



//-------------DECORATION----------------
class DecorationClass {

  static Color whiteColor = Colors.white;

  BoxDecoration boxDecoration() {
    return BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 1,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
        gradient: buildGradient(),
        borderRadius: BorderRadius.circular(15));
  }

  LinearGradient buildGradient() {
    return LinearGradient(
      colors: [MainButton.colorSec, MainButton.colorPri],
      begin: Alignment.topLeft,
      end: Alignment.topRight,
    );
  }


  BoxDecoration buttonsDecoration() {
    return BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 4,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(15));
  }

  AppBar appBar(String title) {
    final double radius = 10;
    return AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius))),
        actions: [Image.asset("assets/images/eletrocardio_icone.png")],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
            gradient: DecorationClass().buildGradient(),
          ),
        )
    );
  }


  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
        shadowColor: Colors.black,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
  }
}

class BrightnessSwitch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: AppController.instance.isDartTheme,
        onChanged: (value) {
          AppController.instance.changeTheme();
        });
  }
}


class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height = 50, this.width = 50, this.defaultPadding = 5}) : super(key: key);
  final double defaultPadding;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius:
          BorderRadius.all(Radius.circular(defaultPadding))),
    );
  }
}