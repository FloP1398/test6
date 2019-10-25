import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:test6/constantes.dart';
import 'package:test6/components/my_drawer.dart';
import 'package:test6/components/TileDetailProduit.dart';
//import 'package:test4/services/networking.dart';

List<dynamic> listData = [];
String url = '';
bool showSpinner = true;

class ProduitDetailScreen extends StatefulWidget {
  ProduitDetailScreen(
      {@required this.numero,
      @required this.data,
      @required this.listData,
      @required this.ville});

  final List<List<dynamic>> listData;
  final List<dynamic> data;
  final int numero;
  final String ville;

  @override
  _ProduitDetailScreenState createState() =>
      _ProduitDetailScreenState(numero, data, listData, ville);
}

class _ProduitDetailScreenState extends State<ProduitDetailScreen> {
  _ProduitDetailScreenState(this.numero, this.data, this.listData, this.ville);
  List<dynamic> data;
  int numero;
  String ville;
  List<dynamic> listData = [];

  @override
  void initState() {
    getData(data, numero);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData(data, numero);
    return Scaffold(
      drawer: new MyDrawer(),
      appBar: AppBar(
        backgroundColor: kColorMain,
        centerTitle: true,
        title: Text(''),
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
      body: SingleChildScrollView(
        child: TileDetailResultState()
            .buildTileDetail(context, numero, url, data, listData, ville),
      ),
    );
  }

  Future getData(data, i) async {
    url = 'http://f1.opcat.fr/$ville/le-pain-de-4-livres/' +
        data[5] +
        '/' +
        data[0] +
        '/_.csv';
//    listData = await NetworkHelper(
//            'http://f1.opcat.fr/$ville/le-pain-de-4-livres/litterature/litterature-francaise/' +
//                data[0] +
//                '/_.csv').getData();
  }
}
