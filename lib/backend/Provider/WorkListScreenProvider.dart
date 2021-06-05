
//USELESS FOR NOW
import 'package:flutter/cupertino.dart';

class WorkListScreenProvider extends ChangeNotifier{
  bool _isVisible = false;

  bool get Loaded{
    return _isVisible;
  }

  set setLoaded(bool state){
    this._isVisible = state;

    notifyListeners();
  }
}