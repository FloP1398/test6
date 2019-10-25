//import 'dart:convert';
import 'package:test6/screens/boutique_screen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:test6/components/ResultatProduitListe.dart';
import 'package:test6/constantes.dart';
import 'package:test6/services/networking.dart';
import 'package:test6/screens/fullscreen_image_screen.dart';
import 'package:recase/recase.dart';

NetworkHelper networkHelper;
List<dynamic> listBoutique = [];
List<dynamic> listData;
List<dynamic> data;
String imageWeb;
String description;
List<String> urlCut = [];

class TileDetailResult extends StatefulWidget {
  @override
  TileDetailResultState createState() => TileDetailResultState();
}

class TileDetailResultState extends State<TileDetailResult> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Column buildTileDetail(BuildContext context, int i, String url,
      List<dynamic> data, List<dynamic> listData, String ville) {
    getData(ville);
    urlCut = url.split('/');
    listData == null ? description = '' : description = listData[2][1];
    Provider.of<ListBool>(context).addListResultat();
    imageWeb = 'http://f1.opcat.fr/$ville/' +
        data[5] +
        '/' +
        data[0] +
        '/_image/couverture.jpeg';
    networkHelper = NetworkHelper(imageWeb);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
          child: GestureDetector(
            onTap: () {
              if (networkHelper.getStatusCode() == 200) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return FullscreenScreen(
                      imageweb: imageWeb,
                    );
                  }),
                );
              } else {}
            },
            child: FadeInImage.assetNetwork(
              placeholder: 'images/no_image.png',
              image: imageWeb,
            ),
          ),
        ),
        SizedBox(width: kMarge),
        Container(
          height: 10.0,
          width: 190.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
//                new IconButton(
//                  icon: Icon(
//                    Feather.getIconData("heart"),
//                    color: ((ListBool().getListResultat(i))
//                        ? kColorMain
//                        : Colors.black12),
//                  ),
//                  onPressed: () {
//                    Provider.of<ListBool>(context).changeBool(i);
//                  },
//                ),
            ],
          ),
        ),
        Container(
          height: 80.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              SizedBox(width: kMarge),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                child: Text(
                  data[1],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(fontSize: 22.0, fontWeight: kFontWeightMain),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: kMarge),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: kMarge),
              Text(
                'Auteur : ',
                style: TextStyle(fontSize: 19.0),
              ),
              Expanded(
                child: Container(),
              ),
              (listData != null)
                  ? Text(
                      ReCase((listData[4][1]).toLowerCase()).titleCase,
                      style: TextStyle(fontSize: 19.0),
                    )
                  : Text(''),
              SizedBox(width: kMarge),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: kMarge),
              Text(
                'Édition : ',
                style: TextStyle(fontSize: 19.0),
              ),
              Expanded(
                child: Container(),
              ),
              (listData != null)
                  ? Text(
                      ReCase((listData[5][1]).toLowerCase()).titleCase,
                      style: TextStyle(fontSize: 19.0),
                    )
                  : Text(''),
              SizedBox(width: kMarge),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: kMarge),
              Text(
                'Collection : ',
                style: TextStyle(fontSize: 19.0),
              ),
              Expanded(
                child: Container(),
              ),
              (listData != null)
                  ? Text(
                      ReCase((listData[6][1]).toLowerCase()).titleCase,
                      style: TextStyle(fontSize: 19.0),
                    )
                  : Text(''),
              SizedBox(width: kMarge),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: kMarge),
              Text(
                data[4],
                style: TextStyle(fontSize: 19.0),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                data[2].toStringAsFixed(2) + ' ' + data[3],
                style: TextStyle(fontSize: 19.0),
              ),
              SizedBox(width: kMarge),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return BoutiqueScreen(
                    data: data,
                    ville: ville,
                    boutique: urlCut[4],
                  );
                }),
              );
            },
            child: Row(
              children: <Widget>[
                SizedBox(width: kMarge),
                Text(
                  'Disponible chez : ',
                  style: TextStyle(fontSize: 19.0),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  ReCase(urlCut[4].replaceAll(new RegExp(r'-'), ' ')).titleCase,
                  style: TextStyle(fontSize: 19.0, color: kColorMain),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    IconData(58820, fontFamily: 'MaterialIcons'),
                    color: kColorMain,
                    size: 20,
                  ),
                ),
                SizedBox(width: kMarge),
              ],
            ),
          ),
        ),
        SizedBox(height: kMarge),
        Divider(
          indent: 30.0,
          endIndent: 30.0,
          height: 5.0,
          thickness: 1.5,
          color: kColorMain,
        ),
        SizedBox(height: kMarge),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kMarge),
          child: Text(
            description,
            style: TextStyle(fontSize: 15.0),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: kMarge)
      ],
    );
  }

  Future getData(String ville) async {
    listBoutique = await NetworkHelper(
            'http://f1.opcat.fr/$ville/le-pain-de-4-livres/_.csv')
        .getData();
  }
}
