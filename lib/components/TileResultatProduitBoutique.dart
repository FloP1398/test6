import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:test6/constantes.dart';
import 'package:test6/components/ResultatProduitListe.dart';
import 'package:test6/screens/produit_detail_screen.dart';
import 'package:test6/services/networking.dart';

NetworkHelper networkHelper;
String imageweb = '';
int tour = 0;
List<List<dynamic>> listData = [];

class TileResultPB extends StatefulWidget {
  TileResultPB(
      {@required this.context,
      @required this.i,
      @required this.data,
      this.ville});

  final int i;
  final List<dynamic> data;
  final BuildContext context;
  final String ville;

  @override
  TileResultPBState createState() =>
      TileResultPBState(context: context, data: data, i: i, ville: ville);
}

class TileResultPBState extends State<TileResultPB> {
  TileResultPBState(
      {@required this.context,
      @required this.data,
      @required this.i,
      this.ville});
  final int i;
  final List<dynamic> data;
  final BuildContext context;
  final String ville;

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
          print(data[i + 1].toString());
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
//              Container(
//                (networkHelper.getStatusCode() != 200)
//                    ? Image.asset('images/no_image.png')
//                    : Image.network(imageweb),
//              ),
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
                      'oui',
                      //data[i + 1][1],
                      textScaleFactor: 1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Container(
                    width: 200.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //Text(data[i + 1][2].toStringAsFixed(2) + ' €'),
                        //Text(data[i + 1][4]),
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

  void getData(List<dynamic> data, int i) async {
//    imageweb =
//        'http://f1.opcat.fr/$ville/le-pain-de-4-livres/litterature/litterature-francaise/' +
//            data[i + 1] +
//            '/_.jpeg';
    networkHelper = new NetworkHelper(imageweb);
    //networkHelper.getData();
  }

  Image getImage(String imageweb) {
    networkHelper.getData();
    if (networkHelper.getStatusCode() != 200) {
      return Image.asset('images/no_image.png');
    } else {
      return Image.network(imageweb);
    }
  }
}
