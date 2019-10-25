import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:test3/constantes.dart';
//import 'package:test3/components/my_drawer.dart';
//import 'package:test3/components/TileDetailProduit.dart';
import 'package:test6/constantes.dart';
import 'package:test6/services/networking.dart';
//import 'package:test6/components/TileResultatProduitBoutique.dart';
import 'package:recase/recase.dart';
import 'package:url_launcher/url_launcher.dart';

List<dynamic> listProduit = [];
List<List<dynamic>> listInfoBoutique = [];
List<List<dynamic>> listInfoVille = [];
List<dynamic> listCategories = [];
List<String> listCategoriesStringValue = [];
List<String> listCategoriesStringText = [];
List<dynamic> listSSCategories = [];
List<DropdownMenuItem<String>> menuItems = List();

String coordonnees = ' ';

class BoutiqueScreen extends StatefulWidget {
  BoutiqueScreen(
      {@required this.data, @required this.ville, @required this.boutique});

  final String boutique;
  final List<dynamic> data;
  final String ville;

  @override
  _BoutiqueScreenState createState() =>
      _BoutiqueScreenState(data, ville, boutique);
}

class _BoutiqueScreenState extends State<BoutiqueScreen>
    with TickerProviderStateMixin {
  _BoutiqueScreenState(this.data, this.ville, this.nomBoutique);
  List<dynamic> data;
  String ville;
  String nomBoutique;

  List<dynamic> listData;
  bool showSpinner = true;

  @override
  void initState() {
    getDataBoutique(ville, nomBoutique).then((result) {
      setState(() {
        coordonnees = listInfoBoutique[5][1];
      });
    });
    getData(data).then((result) {
      setState(() {});
    });
    getCat(ville).then((resultat) {
      print('listCategories' + listCategories.toString());
      for (int i = 1; i < listCategories.length - 1; i++) {
        listCategoriesStringValue.add(listCategories[i][0].toString());
        listCategoriesStringText.add(listCategories[i][1].toString());
      }
      for (int i = 0; i < listCategoriesStringText.length; i++) {
        menuItems.add(DropdownMenuItem<String>(
          child: Text(listCategoriesStringText[i]),
          value: listCategoriesStringValue[i],
        ));
      }
      print(listCategoriesStringText.toString());
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: DefaultTabController(
        length: 2,
        child: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                expandedHeight: 200.0,
                //title: Text('Boutique'),
                pinned: true,
                floating: false,
                //forceElevated: innerBoxIsScrolled,
                //<-- forceElevated to innerBoxIsScrolled
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(0.0),
                  centerTitle: true,
                  title: Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        colors: [kColorMain.withOpacity(0), kColorMain],
                        //stops: [0.5, 0.8],
                      ),
                    ),
                    //color: kColorMain.withOpacity(0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 50.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            ReCase(nomBoutique.replaceAll(
                                    new RegExp(r'-'), ' '))
                                .sentenceCase,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: kFontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  background:
//                Image.network(
//                  "http://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",

                      new Image.asset(
                    'images/lepainde4livres.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              Container(
                color: kColorMain,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 5.0),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 3.5,
                      ),
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: listInfoBoutique.length < 3
                          ? Text('')
                          : Text(
                              listInfoBoutique[3][1],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: kFontWeightMain,
                                  color: Colors.white,
                                  fontSize: 22.0),
                            ),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: _openMap,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        (MediaQuery.of(context).size.width /
                                            3.5) -
                                        2 * kMarge -
                                        20,
                                    child: listInfoBoutique.length < 3
                                        ? Text('')
                                        : Text(
                                            listInfoBoutique[4][1],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: kFontWeightMain,
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                  ),
                                  RotatedBox(
                                    quarterTurns: 2,
                                    child: Icon(
                                      IconData(58820,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: kMarge),
                            GestureDetector(
                              onTap: null,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        (MediaQuery.of(context).size.width /
                                            3.5) -
                                        2 * kMarge -
                                        20,
                                    child: listInfoVille.length < 2
                                        ? Text('')
                                        : Text(
                                            listInfoVille[2][1] +
                                                ' ' +
                                                listInfoVille[1][1],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: kFontWeightMain,
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                  ),
                                  RotatedBox(
                                    quarterTurns: 2,
                                    child: Icon(
                                      IconData(58820,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 5.0),
                  ],
                ),
              ),
              Container(
                height: kMarge,
                width: MediaQuery.of(context).size.width,
                color: kColorMain,
              ),
              Container(
                color: kColorMain,
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: new DropdownButton<String>(
                  items: menuItems,
                  onChanged: (value) {},
                ),
              ),
//              Expanded(
//                child: Container(
//                  child: new ListView.builder(
//                    itemCount: listProduit.length - 1,
//                    itemBuilder: (context, i) {
//                      return TileResultPB(
//                          context: context,
//                          data: listProduit,
//                          i: i,
//                          ville: ville);
//                    },
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }

  //child: TileDetailResultState()
//            .buildTileDetail(context, numero, url, data, listData),

  Future getDataBoutique(ville, nomBoutique) async {
    listInfoVille =
        await NetworkHelper('http://f1.opcat.fr/' + ville + '/_.csv').getData();
    listInfoBoutique = await NetworkHelper(
            'http://f1.opcat.fr/' + ville + '/' + nomBoutique + '/_.csv')
        .getData();
    print(listInfoVille);
    print(listInfoBoutique);
  }

  Future getData(data) async {
    listProduit =
        await NetworkHelper('http://f1.opcat.fr/' + ville + data[5] + '/_.csv')
            .getData();
    print(listProduit);
  }

  Future getCat(ville) async {
    print('http://f1.opcat.fr/yerres/le-pain-de-4-livres/0.csv');
    print('http://f1.opcat.fr/' + ville + '/' + nomBoutique + '/0.csv');
    //listCategories = await NetworkHelper('f1.opcat.fr/' + ville + '/' + nomBoutique + '/0.csv').getData();
    listCategories = await NetworkHelper(
            'http://f1.opcat.fr/yerres/le-pain-de-4-livres/litterature/0.csv')
        .getData();
    setState(() {});
  }

  Future getSSCat(ville) async {
    listSSCategories = await NetworkHelper(
            'http://f1.opcat.fr/' + ville + '/' + data[5] + '/0.csv')
        .getData();
  }

  _openMap() async {
    // Android
    String url = 'geo:$coordonnees';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // iOS
      String url = 'http://maps.apple.com/?ll=$coordonnees';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
