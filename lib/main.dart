import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseStreams.dart';
import 'package:railway_work_tracking/backend/Firebase/WorkDataModel.dart';
import 'package:railway_work_tracking/backend/Provider/AddWorkProvider.dart';
import 'package:railway_work_tracking/backend/Provider/ExportasExcelProvider.dart';
import 'package:railway_work_tracking/backend/Provider/UserData.dart';
import 'package:railway_work_tracking/screens/AddWorkScreen.dart';
import 'package:railway_work_tracking/screens/Addworkwithoutdate.dart';
import 'package:railway_work_tracking/screens/ExportasExcel.dart';
import 'package:railway_work_tracking/screens/HomeScreen.dart';
import 'package:railway_work_tracking/screens/LoginScreen.dart';
import 'package:railway_work_tracking/screens/WorkListScreen.dart';
import 'package:railway_work_tracking/screens/WorkPerDayList.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'backend/Firebase/BillNameModel.dart';
import 'backend/Firebase/FirebaseUploadTransactions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref= await SharedPreferences.getInstance();
  bool status = pref.getBool("logInStatus") ?? false;
  runApp(MyApp(status));
}

class MyApp extends StatelessWidget {
  bool status;
  MyApp(this.status);
  @override
  Widget build(BuildContext context) {
    if(status == true) {
      UserData().ConnectionStatus();
    }
    else{
      UserData().ConnectionStatus();
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserData(),
        ),
        ChangeNotifierProvider(create: (context) => AddWorkProvider()),
        ChangeNotifierProvider(create: (context) => ExcelProvider()),
        StreamProvider<List<BillNameModel>>.value(value: FirebaseStreams().GetBillName(), initialData: [BillNameModel(billName: "Loading Bill", bill: false)],),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        initialRoute: status ? HomeScreen.id : LoginScreen.id,
        routes: {
          HomeScreen.id : (context) => HomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          AddWorkScreen.id: (context) => AddWorkScreen(),
          WorkListScreen.id: (context) => WorkListScreen(),
          WorkPerDayList.id: (context) => WorkPerDayList(),
          Addworkwithoutdate.id: (context) => Addworkwithoutdate(),
          ExcelExport.id: (context) => ExcelExport(),
        },
      ),
    );
  }
}
