import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test6/screens/recherche_screen.dart';
import 'package:provider/provider.dart';
import 'constantes.dart';
import 'components/ResultatProduitListe.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListBool>(
      builder: (_) => ListBool(),
      child: MaterialApp(
        title: 'Test 6',
        theme: ThemeData(
          primarySwatch: kColorMain,
        ),
        home: RechercheScreen(),
      ),
    );
  }
}
