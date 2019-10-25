import 'package:flutter/material.dart';

double screenWidth = 0.0;
double screenHeight = 0.0;

const kMarge = 10.0;
const kColorMain = Colors.red;
const kFontSizeMain = 28.0;
const kFontSizeMainSecond = 25.0;
const kFontWeightMain = FontWeight.w700;
const kFontFamily = 'Lobster';
const kAppbarTittle = "Essai pour l'application";

const kListViewFontSize = 20.0;

const kEmail = "flo.pion@orange.fr";

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorMain, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorMain, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
