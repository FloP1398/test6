import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test6/constantes.dart';
import 'package:test6/components/my_drawer.dart';

class ProfilScreen extends StatefulWidget {
  ProfilScreen();

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new MyDrawer(),
      appBar: AppBar(
        backgroundColor: kColorMain,
        centerTitle: true,
        title: Text('Votre Profil'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'RETOUR',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(),
      ),
    );
  }
}
