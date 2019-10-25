import 'package:test6/constantes.dart';
import 'package:test6/screens/login_screen.dart';
import 'package:test6/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:test6/components/main_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kColorMain,
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
        padding: EdgeInsets.symmetric(horizontal: 10.0),
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
            SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: 'logo',
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage('images/citymap.png'),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Hero(
              tag: 'seConnecter',
              child: MainFlatButton(
                color: kColorMain,
                textColor: Colors.white,
                title: 'Se Connecter',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: 'enregistrer',
              child: MainFlatButton(
                color: Colors.white,
                textColor: kColorMain,
                title: "S'enregistrer",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RegistrationScreen(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
