import 'package:flutter/material.dart';

const Radius circle = Radius.circular(8);

// colors
const Color primaryColor = Color.fromARGB(255, 255, 206, 0);
const Color secondaryColor = Color.fromARGB(255, 214, 194, 121);
const Color darkColor = Color.fromARGB(255, 0, 0, 0);
const Color lightColor = Color.fromARGB(255, 255, 255, 255);
const Color darkTransparent = Color.fromARGB(50, 0, 0, 0);
const BoxShadow shadow = BoxShadow(
  color: darkTransparent,
  blurRadius: 8,
  spreadRadius: 5
);

const BoxDecoration headerStyle = BoxDecoration(
  color: primaryColor,
  boxShadow: [shadow],
  borderRadius: BorderRadius.only(bottomRight: circle, bottomLeft: circle)
);

const BoxDecoration headerBoxStyle = BoxDecoration(
    color: lightColor,
    borderRadius: BorderRadius.all(circle)
);


const TextStyle largeText = TextStyle(
  color: lightColor,
  fontSize: 36,
  fontWeight: FontWeight.bold

);
const TextStyle mediumText = TextStyle(
    color: lightColor,
    fontSize: 24,
    fontWeight: FontWeight.bold
);

// padding sizes
const EdgeInsets padding = EdgeInsets.all(20);


const BorderRadius radius = BorderRadius.all(Radius.circular(8));




const double headerMaxHeight = 100;
const double animationDuration = 1;