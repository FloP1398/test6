import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:test3/components/CustomRadioButton.dart';
import 'package:test6/components/ensure_visible_when_focus.dart';
import 'package:test6/constantes.dart';
import 'package:test6/components/main_button.dart';
import 'package:test6/screens/résultat_recherche-screen.dart';
import 'package:test6/components/my_drawer.dart';
import 'package:test6/services/networking.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:test6/components/ListeVilles.dart';
import 'package:test6/components/ListeProduits.dart';
import 'package:test6/components/ListeCommerces.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

NetworkHelper networkHelper;
Future<List<List<dynamic>>> data;
List<List<dynamic>> listData = [];
List<List<dynamic>> listeDesVilles = [];
List<String> listeDesProduits = [];
List<String> listeDesCommerces = [];

List<String> _getSuggestionsVille(String query) {
  List<String> matches = List();
  for (int i = 0; i < listeDesVilles.length; i++) {
    matches.add(listeDesVilles[i][1]);
  }
  matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  return matches;
}

List<String> _getSuggestions(String query) {
  List<String> matches = List();
  matches.addAll(listeDesProduits);
  matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  return matches;
}

class RechercheScreen extends StatefulWidget {
  @override
  _RechercheScreenState createState() => _RechercheScreenState();
}

class _RechercheScreenState extends State<RechercheScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _recherche = '';
  String _villeChoisie = '';

  final TextEditingController _typeAheadControllerRecherche =
      TextEditingController();
  final TextEditingController _typeAheadControllerVille =
      TextEditingController();

  bool showSpinner = false;
  FocusNode _focusNode = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();

  @override
  void initState() {
    ListeVilles().getData();
    listeDesVilles = ListeVilles().getListResultat();
    listeDesCommerces = ListeCommerces().getListResultat();
    listeDesProduits = ListeProduits().getListResultat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: new MyDrawer(),
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
      body: Builder(
        builder: (context) => ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (MediaQuery.of(context).size.height > 150
                    ? MediaQuery.of(context).size.height - 50.0
                    : 100),
              ),
              child: Form(
                key: this._formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Hero(
                        tag: 'textMain',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            child: Text(
                              'Tout ce que vous cherchez est autour de vous!',
                              style: TextStyle(
                                fontWeight: kFontWeightMain,
                                fontSize: kFontSizeMain,
                                fontFamily: kFontFamily,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'logo',
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width,
                          child: Image(
                            image: AssetImage('images/citymap.png'),
                          ),
                        ),
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: _focusNode2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Text(
                            'Vous êtes dans la ville de :',
                            style: TextStyle(
                              fontWeight: kFontWeightMain,
                              fontSize: kFontSizeMainSecond,
                              fontFamily: kFontFamily,
                            ),
                          ),
                        ),
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: _focusNode2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TypeAheadFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              textAlign: TextAlign.center,
                              focusNode: _focusNode2,
                              controller: this._typeAheadControllerVille,
                              style: TextStyle(fontSize: kFontSizeMainSecond),
                            ),
                            suggestionsCallback: (pattern) {
                              return _getSuggestionsVille(pattern);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (suggestion) {
                              this._typeAheadControllerVille.text = suggestion;
                            },
                            validator: (val) =>
                                val.isEmpty ? 'Sélectioner une ville' : null,
                            onSaved: (val) {
                              int indice = -1;
                              for (int i = 0; i < listeDesVilles.length; i++) {
                                if (listeDesVilles[i].indexWhere(
                                        (ville) => ville.startsWith(val)) !=
                                    -1) {
                                  indice = i;
                                }
                              }
                              print(indice.toString());
                              setState(() => this._villeChoisie =
                                  listeDesVilles[indice][0]);
                              print(_villeChoisie);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      EnsureVisibleWhenFocused(
                        focusNode: _focusNode,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Text(
                            'Vous recherchez :',
                            style: TextStyle(
                              fontWeight: kFontWeightMain,
                              fontSize: kFontSizeMainSecond,
                              fontFamily: kFontFamily,
                            ),
                          ),
                        ),
                      ),
//                      CustomRadioButton(
//                        selectedColor: kColorMain,
//                        buttonColor: Colors.white,
//                        fontFam: 'Lobster',
//                        fontS: 25,
//                        buttonLabels: [
//                          "un produit",
//                          "un commerce",
//                        ],
//                        buttonValues: [
//                          "produit",
//                          "commerce",
//                        ],
//                        radioButtonValue: (value) {
//                          setState(() {
//                            produitOuCommerce = !produitOuCommerce;
//                          });
//                        },
//                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: _focusNode,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Hero(
                              tag: 'barreRecherche',
                              child: TypeAheadFormField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  focusNode: _focusNode,
                                  textAlign: TextAlign.center,
                                  controller: _typeAheadControllerRecherche,
                                  style:
                                      TextStyle(fontSize: kFontSizeMainSecond),
                                ),
                                suggestionsCallback: (pattern) {
                                  return _getSuggestions(pattern);
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(suggestion),
                                  );
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected: (suggestion) {
                                  _typeAheadControllerRecherche.text =
                                      suggestion;
                                },
                                validator: (val) => val.isEmpty
                                    ? 'Sélectioner une recherche'
                                    : null,
                                onSaved: (val) {
                                  _recherche = val;
                                },
                              )),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        child: MainFlatButton(
                            title: "C'est parti!",
                            color: kColorMain,
                            textColor: Colors.white,
                            onPressed: () async {
                              if (this._formKey.currentState.validate()) {
                                this._formKey.currentState.save();
                                setState(() {
                                  showSpinner = true;
                                });
                                FocusScope.of(context).unfocus();
                                if (_recherche == '' || _villeChoisie == '') {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  final snackBar = SnackBar(
                                    content:
                                        Text('Veuillez entrer une recherche.'),
                                    action: SnackBarAction(
                                      label: 'Fermer',
                                      onPressed: () {},
                                    ),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  try {
                                    await getData();
                                    if (networkHelper.getStatusCode() != 200 &&
                                        networkHelper.getStatusCode() != 0) {
                                      print(networkHelper
                                              .getStatusCode()
                                              .toString() +
                                          'pas de résultat');
                                      if (networkHelper.getStatusCode() ==
                                          404) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Pas de résultat. \nVeuillez réessayer.'),
                                          action: SnackBarAction(
                                            label: 'Fermer',
                                            onPressed: () {},
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Oups, un problème est survenu. \nVeuillez réessayer.'),
                                          action: SnackBarAction(
                                            label: 'Fermer',
                                            onPressed: () {},
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } else {
                                      listData = await data;
                                      setState(
                                        () {
                                          showSpinner = false;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ResultatScreen(
                                                villeRecherche:
                                                    this._villeChoisie,
                                                objetRecherche: this._recherche,
                                                data: listData,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              }
                            }),
                      ),
                      SizedBox(height: 10.0),
                      EnsureVisibleWhenFocused(
                        focusNode: _focusNode2,
                        child: SizedBox(
                          height: 0.0,
                        ),
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: _focusNode,
                        child: SizedBox(
                          height: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<List>> getData() async {
    var url =
        'http://f1.opcat.fr/' + _villeChoisie + '/_search/$_recherche/0.csv';
    networkHelper = NetworkHelper(url);
    data = networkHelper.getData();
    return networkHelper.getData();
  }
}
