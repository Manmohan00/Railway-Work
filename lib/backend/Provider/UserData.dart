
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends ChangeNotifier{
 String? _UserName;
 String? _Email;
 bool _connected = false;

   bool get connectionStatus{
     return _connected;
   }

   String? get userName{
     return _UserName;
   }

 String? get email{
   return _Email;
 }

  set setUserName(name){
    this._UserName = name;
    notifyListeners();
  }

  set setUserEmail(email){
    this._Email = email;
    notifyListeners();
  }


  void ConnectionStatus() async{
    var checkConnection = await (Connectivity().checkConnectivity());
    if(checkConnection == ConnectivityResult.none){
      this._connected = false;
    }
    else{
      this._connected = true;
    }
  }
}