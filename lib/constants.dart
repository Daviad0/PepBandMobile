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

const BoxShadow headerShadow = BoxShadow(
  color: darkTransparent,
  blurRadius: 2,
  spreadRadius: 2,
  offset: Offset(0, 4)
);

const ButtonStyle headerOption = ButtonStyle(
  backgroundColor: MaterialStatePropertyAll(lightColor),
  alignment: Alignment.center,
  padding: MaterialStatePropertyAll(buttonPadding),
  minimumSize: MaterialStatePropertyAll(Size(300, 0))

);

const BoxDecoration headerStyle = BoxDecoration(
  color: primaryColor,
  boxShadow: [headerShadow],
  borderRadius: BorderRadius.only(bottomRight: circle, bottomLeft: circle)
);

const BoxDecoration headerBoxStyle = BoxDecoration(
    color: lightColor,
    borderRadius: BorderRadius.all(circle)
);


const TextStyle largeText = TextStyle(
  color: lightColor,
  fontSize: 32,
  fontWeight: FontWeight.bold

);
const TextStyle mediumText = TextStyle(
    color: lightColor,
    fontSize: 18,
    fontWeight: FontWeight.bold
);

// padding sizes
const EdgeInsets padding = EdgeInsets.all(20);
const EdgeInsets buttonPadding = EdgeInsets.all(10);


const BorderRadius radius = BorderRadius.all(Radius.circular(8));




const double headerMaxHeight = 100;
const double animationDuration = 1;