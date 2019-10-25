import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:test6/components/ResultatProduitListe.dart';
import 'package:test6/screens/produit_detail_screen.dart';
import 'package:test6/constantes.dart';
import 'package:test6/services/networking.dart';

String imageweb = '';
NetworkHelper networkHelper2;

class TileResult extends StatefulWidget {
  TileResult(
      {@required this.context,
      @required this.i,
      @required this.data,
      @required this.ville});

  final int i;
  final List<List<dynamic>> data;
  final BuildContext context;
  final String ville;

  @override
  TileResultState createState() =>
      TileResultState(context: context, data: data, i: i, ville: ville);
}

class TileResultState extends State<TileResult> {
  TileResultState(
      {@required this.context,
      @required this.data,
      @required this.i,
      @required this.ville});
  final int i;
  final List<List<dynamic>> data;
  final BuildContext context;
  final String ville;

  List<dynamic> listData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData(data, i);
    Provider.of<ListBool>(context).addListResultat();
    return Container(
      height: 130.0,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () async {
          print(data.toString());
          await getDataNext(data, i).then((val) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProduitDetailScreen(
                  numero: i + 1,
                  data: data[i + 1],
                  listData: listData,
                  ville: ville,
                ),
              ),
            );
          });
        },
        child: Card(
          elevation: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: FadeInImage.assetNetwork(
                  placeholder: 'images/no_image.png',
                  image: imageweb,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 35.0,
                    width: 200.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new IconButton(
                          icon: Icon(
                            Feather.getIconData("heart"),
                            color: ((ListBool().getListResultat(i))
                                ? kColorMain
                                : Colors.black12),
                          ),
                          onPressed: () {
                            Provider.of<ListBool>(context).changeBool(i);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 200.0,
                    child: Text(
                      data[i + 1][1],
                      textScaleFactor: 1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Container(
                    height: 10.0,
                  ),
                  Container(
                    width: 200.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(data[i + 1][2].toStringAsFixed(2) + ' €'),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text(data[i + 1][4]),
                        ),
                      ],
                    ),
                  ),
                  //Text(data[i + 1][1]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getData(List<List<dynamic>> data, int i) async {
    imageweb = 'http://f1.opcat.fr/' +
        ville +
        '/' +
        data[i + 1][5] +
        '/' +
        data[i + 1][0] +
        '/_.jpeg';
    new NetworkHelper(imageweb).getData();
  }

  Future getDataNext(List<List<dynamic>> data, int i) async {
    listData = await NetworkHelper('http://f1.opcat.fr/' +
            ville +
            '/' +
            data[i + 1][5] +
            '/' +
            data[i + 1][0] +
            '/_.csv')
        .getData();
    print("getdatanext" + listData.toString());
    print(data[i + 1][0].toString());
  }

//  Image getImage(String imageweb) {
//    networkHelper.getData();
//    if (networkHelper.getStatusCode() != 200) {
//      return Image.asset('images/no_image.png');
//    } else {
//      return Image.network(imageweb);
//    }
//  }
}
