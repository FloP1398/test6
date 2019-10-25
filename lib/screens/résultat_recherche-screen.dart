import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test6/constantes.dart';
import 'package:test6/components/my_drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:test6/components/TileResultatRecherche.dart';

int tour = 0;
bool showSpinner = true;

class ResultatScreen extends StatefulWidget {
  ResultatScreen(
      {@required this.villeRecherche,
      @required this.objetRecherche,
      @required this.data});

  final String villeRecherche;
  final String objetRecherche;
  final List<List<dynamic>> data;

  @override
  _ResultatScreenState createState() =>
      _ResultatScreenState(villeRecherche, objetRecherche, data);
}

class _ResultatScreenState extends State<ResultatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _ResultatScreenState(this.villeRecherche, this.objetRechercheMain, this.data);

  final String villeRecherche;
  final String objetRechercheMain;
  final List<List<dynamic>> data;

  int present = 0;
  int perPage = 15;
  var nbItems = List<List<dynamic>>();

//  FocusNode _focusNode = new FocusNode();
//  static TextEditingController _controller =
//      new TextEditingController.fromValue(
//    new TextEditingValue(
//      text: _objetRecherche,
//      selection:
//          new TextSelection.collapsed(offset: _objetRecherche.length - 1),
//    ),
//  );

  @override
  void initState() {
    super.initState();
    loadMore();
  }

  void loadMore() {
    if ((present + perPage) >= data.length) {
      nbItems.addAll(data.getRange(present, data.length - 1));
    } else {
      nbItems.addAll(data.getRange(present, present + perPage));
    }
    present = present + perPage;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: new MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size(100.0, 55.0),
        child: Builder(
          builder: (BuildContext context) {
            return new AppBar(
              backgroundColor: kColorMain,
              centerTitle: true,
              title: Text(''),
//              actions: <Widget>[
//                Material(
//                  type: MaterialType.transparency,
//                  child: Container(
//                    width: 250.0,
//                    child: Padding(
//                      padding: const EdgeInsets.symmetric(
//                          horizontal: 10, vertical: 5.0),
//                      child: TextField(
//                        controller: _controller,
//                        cursorColor: Colors.white,
//                        decoration: InputDecoration(
//                          contentPadding: EdgeInsets.all(10.0),
//                          filled: true,
//                          hintText: (_rechercheHint),
//                          enabledBorder: UnderlineInputBorder(
//                            borderSide: BorderSide(color: Colors.white),
//                          ),
//                          focusedBorder: UnderlineInputBorder(
//                            borderSide: BorderSide(color: Colors.white),
//                          ),
//                        ),
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          fontSize: 25,
//                          color: Colors.white,
//                        ),
//                        onChanged: (texte) {
//                          _objetRechercheFuture = texte;
//                        },
//                        focusNode: _focusNode,
//                      ),
//                    ),
//                  ),
//                ),
//                IconButton(
//                  icon: Icon(
//                    Icons.search,
//                    color: Colors.white,
//                  ),
//                  onPressed: () async {
//                    FocusScope.of(context).unfocus();
//                    setState(() {
//                      showSpinner = true;
//                    });
//                    if (_objetRechercheFuture == '') {
//                      setState(() {
//                        showSpinner = false;
//                      });
//                      final snackBar = SnackBar(
//                        content: Text('Veuillez entrer une recherche.'),
//                        action: SnackBarAction(
//                          label: 'Fermer',
//                          onPressed: () {},
//                        ),
//                      );
//                      Scaffold.of(context).showSnackBar(snackBar);
//                    } else {
//                      try {
//                        await getData();
//                        if (networkHelperFuture.getStatusCode() != 200 &&
//                            networkHelperFuture.getStatusCode() != 0) {
//                          print(networkHelperFuture.getStatusCode().toString() +
//                              'pas de résultat');
//                          if (networkHelperFuture.getStatusCode() == 404) {
//                            final snackBar = SnackBar(
//                              content: Text(
//                                  'Pas de résultat. \nVeuillez réessayer.'),
//                              action: SnackBarAction(
//                                label: 'Fermer',
//                                onPressed: () {},
//                              ),
//                            );
//                            Scaffold.of(context).showSnackBar(snackBar);
//                          } else {
//                            final snackBar = SnackBar(
//                              content: Text(
//                                  'Oups, un problème est survenu. \nVeuillez réessayer.'),
//                              action: SnackBarAction(
//                                label: 'Fermer',
//                                onPressed: () {},
//                              ),
//                            );
//                            Scaffold.of(context).showSnackBar(snackBar);
//                          }
//                          setState(() {
//                            showSpinner = false;
//                          });
//                        } else {
//                          listDataFuture = await dataFuture;
//                          setState(() {
//                            showSpinner = false;
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (BuildContext context) =>
//                                    ResultatScreen(
//                                  objetRecherche: _objetRechercheFuture,
//                                  data: listDataFuture,
//                                ),
//                              ),
//                            );
//                          });
//                        }
//                      } catch (e) {
//                        print(e);
//                      }
//                    }
//                  },
//                )
//              ],
            );
          },
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: false, //showSpinner,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: (present < data.length)
                    ? nbItems.length + 1
                    : nbItems.length,
                itemBuilder: (context, i) {
                  return (i == nbItems.length && present < data.length)
                      ? Container(
                          color: kColorMain,
                          child: Column(
                            children: <Widget>[
                              FlatButton(
                                  child: Text(
                                    "Plus d'articles",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: kFontWeightMain,
                                        fontSize: 19.0),
                                  ),
                                  onPressed: () {
                                    print("press " +
                                        present.toString() +
                                        " data.lenght " +
                                        data.length.toString());
                                    if (present < data.length) {
                                      setState(() {
                                        if ((present + perPage) >
                                            data.length - 1) {
                                          nbItems.addAll(data.getRange(
                                              present, data.length - 1));
                                        } else {
                                          nbItems.addAll(data.getRange(
                                              present, present + perPage));
                                        }
                                        present = present + perPage;
                                      });
                                    }
                                    print("fin " + present.toString());
                                  }),
                            ],
                          ),
                        )
                      : TileResult(
                          context: context,
                          data: data,
                          i: i,
                          ville: villeRecherche);
                },
              ),
            ),
            //myFakeContainer(),
          ],
        ),
      ),
    );
  }

  myFakeContainer() {
    setState(() {
      showSpinner = false;
    });
    return Container();
  }
//  Future<List<List>> getData() async {
//    var url =
//        'http://f1.opcat.fr/$villeRecherche/le-pain-de-4-livres/_search/$objetRechercheMain/0.csv';
//    networkHelperFuture = NetworkHelper(url);
//    dataFuture = networkHelperFuture.getData();
//    return networkHelperFuture.getData();
//  }
}
