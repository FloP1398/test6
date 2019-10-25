import 'package:flutter/material.dart';
import 'package:test6/screens/recherche_screen.dart';
import 'package:test6/components/main_button.dart';
import 'package:test6/constantes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kColorMain,
        leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Material(
          type: MaterialType.transparency,
          child: Container(
            child: Text(
              kAppbarTittle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: kFontWeightMain,
                  fontFamily: kFontFamily,
                  fontSize: kFontSizeMain),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'textMain',
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  child: Text(
                    'Tout ce que vous cherchez est autour de vous!',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: kFontSizeMain,
                      fontWeight: kFontWeightMain,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image(
                    image: AssetImage('images/citymap.png'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Password')),
            SizedBox(
              height: 15.0,
            ),
            Hero(
              tag: 'seConnecter',
              child: MainFlatButton(
                title: 'Se Connecter',
                color: kColorMain,
                textColor: Colors.white,
                onPressed: () async {
//                setState(() {
//                  showSpinner = true;
//                });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RechercheScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
