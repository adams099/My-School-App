import 'package:flutter/material.dart';

class IconState with ChangeNotifier {
  bool _isTrue = true;
  bool _istrue = true;

  bool get getisTrue {
    return _isTrue;
  }

  bool get getistrue {
    return _istrue;
  }

  IconData get getIcon {
    return _isTrue ? Icons.visibility_off : Icons.visibility;
  }

  IconData get getIcons {
    return _istrue ? Icons.visibility_off : Icons.visibility;
  }

  set setIcon(bool value) {
    _isTrue = value;
    notifyListeners();
  }

  set setIcons(bool value) {
    _istrue = value;
    notifyListeners();
  }
}
