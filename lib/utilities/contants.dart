import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Colors
const cwhite = Color(0xFFEAEBF3);
const cblue = Color(0xFF0A3068);

//icons
const options = "assets/icons/options.svg";
const play = "assets/icons/play.svg";
const previous = "assets/icons/previous.svg";
const next = "assets/icons/next.svg";
const back = "assets/icons/back.svg";
//images
const button = "assets/images/button.png";
const disk = "assets/images/disk.png";
const albumart = "assets/images/center.jpg";
Widget cbutton(String symbol) {
  return Container(
    padding: EdgeInsets.fromLTRB(25, 25, 20, 20),
    height: 80,
    width: 80,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(button),
      ),
    ),
    child: SvgPicture.asset(symbol),
  );
}

Widget dbutton(IconData icon) {
  return Container(
    padding: EdgeInsets.fromLTRB(25, 25, 20, 20),
    height: 80,
    width: 80,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(button),
      ),
    ),
    child: Icon(icon, color: cblue)
  );
}
