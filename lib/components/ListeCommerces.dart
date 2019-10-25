import 'package:flutter/cupertino.dart';

class ListeCommerces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List<String> getListResultat() {
    return _listeDesCommerces;
  }
}

List<String> _listeDesCommerces = [
  "boulangerie / pâtisserie",
  "boucherie / charcuteie",
  "chocolaterie",
  "poissonnerie",
  "primeur",
  "épicerie",
  "quincaillerie",
  "menuiserie",
  "plomberie",
  "droguerie",
  "cordonnerie",
  "magasin de bricolage",
  "fleuriste"
];
