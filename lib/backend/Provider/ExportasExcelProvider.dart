

import 'package:flutter/cupertino.dart';

class ExcelProvider extends ChangeNotifier{
  String? _billvalue;
  bool _loading = false;
  String _loadingText = 'Lets do this!';
  bool _filelocationvisible = false;
  String _fileLocation = 'Not available';

  set setfilevisible(bool load){ //file visibility
    this._filelocationvisible = load;
    notifyListeners();
  }
  bool get getfilevisible{
    return _filelocationvisible;
  }

  set setfile(String file){ //File location
    this._fileLocation = file;
    notifyListeners();
  }
  String get getfile{
    return _fileLocation;
  }

  set setloadtext(String text){ //loading text
    this._loadingText = text;
    notifyListeners();
  }
  String get getloadingtext{
    return _loadingText;
  }

  set setloading(bool load){ //loading
    this._loading = load;
    notifyListeners();
  }
  bool get getload{
    return _loading;
  }

  set setbillname(String? bill){ //billname
    this._billvalue = bill;
    notifyListeners();
  }
  String? get getbillname{
    return _billvalue;
  }
}