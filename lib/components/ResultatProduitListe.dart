import 'package:flutter/cupertino.dart';

List<bool> _listResultat = List<bool>();

// ignore: must_be_immutable
class ListBool extends StatelessWidget with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  bool getListResultat(int i) {
    return _listResultat[i];
  }

  void addListResultat() {
    _listResultat.add(false);
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }

  void changeBool(int i) {
    _listResultat[i] = !_listResultat[i];
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }
}
