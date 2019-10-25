import 'package:flutter/cupertino.dart';
import 'package:test6/services/networking.dart';

List<List<dynamic>> listData;
List<List<dynamic>> _listeDesVilles = [];

class ListeVilles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List<List<dynamic>> getListResultat() {
    return _listeDesVilles;
  }

  Future getData() async {
    listData = await NetworkHelper('http://f1.opcat.fr/0.csv').getData();
    print(listData.toString());
    if (listData == null) {
      _listeDesVilles = [];
    } else {
      for (int i = 1; i < listData.length; i++)
        _listeDesVilles.add(listData[i]);
    }
  }
}
