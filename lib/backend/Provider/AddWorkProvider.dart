
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';

class AddWorkProvider extends ChangeNotifier{

  String? _Day;
  String? _Year;
  String _billName = '';
  String? _workName;
  String? _quantity;
  String? _comment;
  bool _load = false;
  String _Month = DateFormat('MMMM').format(DateTime.now());
  int _activeButtonRoadLoop = 0;
  String _roadLoop = 'UpRoad';



  AddWorkProvider(){
    _workName = WorkListName.ERC;
    _Month = DateFormat('MMMM').format(DateTime.now());
  }

//*************************SETTERS********************
  set day(String day) {
    this._Day = day;
    notifyListeners();
  }
  set month(String month){
    this._Month= month;
    notifyListeners();
  }

  set year(String year) {
    this._Year = year;
    notifyListeners();
  }

  set Bill(String bill) {
    this._billName = bill;
    notifyListeners();
  }

  set work(String? work){
    this._workName = work;
    notifyListeners();
  }

  set quantity(String quantity){
    this._quantity = quantity;
    notifyListeners();
  }
  
  set Comment(String? comment){
    this._comment = comment;
  }

  set Loading(bool load){
    this._load = load;
    notifyListeners();
  }

  set isRoadandLoopactive(int active){
    this._activeButtonRoadLoop = active;
    notifyListeners();
  }

  set roadandLoop(String road){
    this._roadLoop = road;
    if(road ==  FirebaseNames.roadup){
      _activeButtonRoadLoop = 0;
    }
    if(road ==  FirebaseNames.roadmid){
      _activeButtonRoadLoop = 1;
    }
    if(road ==  FirebaseNames.roaddown){
      _activeButtonRoadLoop = 2;
    }
    if(road ==  FirebaseNames.loopup){
      _activeButtonRoadLoop = 3;
    }
    if(road ==  FirebaseNames.loopmid){
      _activeButtonRoadLoop = 4;
    }
    if(road ==  FirebaseNames.loopdown){
      _activeButtonRoadLoop = 5;
    }
    notifyListeners();
  }

  
  //***********************************GETTERS***************** 
  String? get getday {
    return _Day;
  }

  String? get getWork {
    return _workName;
  }

  String get getmonth {
    return _Month;
  }

  String get Bill {
    return _billName;
  }

  String? get getyear {
    return _Year;
  }

  String? get getQuantity{
    return _quantity;
  }
  
  String? get getComment{
    return _comment;
  }

  bool get LoadingStatus{
    return _load;
  }

  int get getisRoadorLoopactive{
    return _activeButtonRoadLoop;
  }

  String get getRoadLoop{
    return _roadLoop;
  }


}