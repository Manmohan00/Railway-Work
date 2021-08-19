
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Firebase/BillNameModel.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseStreams.dart';
import 'package:railway_work_tracking/backend/Provider/ExportasExcelProvider.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';
import 'package:railway_work_tracking/screens/UI/UiFunctions.dart';


class ExcelExport extends StatelessWidget {
  static const String id = 'ExcelExport';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<BillNameModel>>.value(
            value: FirebaseStreams().GetBillName(),
            initialData: [],
        ),
      ],
      child: ExportasExcel(),
    );
  }
}

class ExportasExcel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List billList = Provider.of<List<BillNameModel>>(context);
    ExcelProvider ex = Provider.of<ExcelProvider>(context);
    List<String> billlistSr = [];

    for (int i = 0;i < billList.length ; i++){
      billlistSr.add(billList[i].billName);
    }

    return ex.getload ? Scaffold(
      appBar: AppBar(
        title: Text("Export data as Excel"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.deepOrange,
              strokeWidth: 2.0,
            ),
            Container(
              margin: EdgeInsets.all(5.0),
                child: TextBoxforAll("${ex.getloadingtext}",1.5, 13, TextAlign.center)),
          ],
        ),),
    ) : WillPopScope(
      onWillPop: () async{
        ex.setfile = 'Not available';
        ex.setloadtext = "Let's do this!";
        ex.setbillname = null;

        Navigator.pop(context);
        return false;
      },
        child: Scaffold(
        appBar: AppBar(
          title: Text("Export data as Excel"),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextBoxforAll("Select bill Name: ", 1.0, 13, TextAlign.center),
                    DropdownButton(
                      hint: Text("BillName"),
                      iconSize: 23,
                      iconEnabledColor: Colors.blue.shade800,
                      value: ex.getbillname,
                      icon: Icon(Icons.arrow_drop_down_sharp),
                      items: billlistSr.map((String bill) {
                        return DropdownMenuItem(
                            value: bill,
                            child: Text(bill));
                      }).toList(),
                      onChanged: (String? newval) {
                        print(newval);
                       ex.setbillname = newval;
                      },
                    ),
                  ],
                ),
                MaterialButton(
                    onPressed:()async{
                      String billname = ex.getbillname ?? 'none';
                      if(billname != 'none') {
                        var checkConnection =
                        await (Connectivity().checkConnectivity());
                        if (checkConnection == ConnectivityResult.none) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBarInternetError);
                        }
                        else{
                          ex.setloading = true;
                          ExportDatatoCSV(billname, ex);
                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(snackBarBillError);
                      }
                    },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                child: TextBoxforAll("Export", 1.5, 13, TextAlign.center),
                color: Colors.greenAccent.shade700,),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Visibility(
                    visible: ex.getfilevisible,
                      child: TextBoxforAll("File Location - ${ex.getfile}",
                          1.0, 13, TextAlign.center, colors: Colors.blueGrey.shade700,)),
                )
              ],
            ),
          ),
        ),
    ),
      );
  }
}


void ExportDatatoCSV(billname,ExcelProvider ex) async{

  ex.setloadtext = 'Reciving and processing data';
  FirebaseFirestore _db = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot =  await _db.collection(billname).get();
  List date = querySnapshot.docs.map((doc) => doc.id).toList();

  int removeIndex  = date.length - 1;
  date.removeAt(removeIndex);
  List subdocs = [];


  for(int i = 0; i < date.length ; i++){
    QuerySnapshot querySnapshot = await _db.collection(billname)
        .doc(date[i]).collection('Work_done')
        .get();
    subdocs.add(querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  ex.setloadtext = 'Decorating the data for Excel';

  List<List<String>> csvData = [
    ['$billname'],
    ["Date", WorkListName.ERC, '', '', WorkListName.MBS,'', '', WorkListName.RH,'', '', WorkListName.Paint,'', '',
      WorkListName.ERCHeat,'', '', WorkListName.DressBox,'', '', WorkListName.Gas,'', '', WorkListName.NewMBC,'', '',
      WorkListName.Crib,'', '', WorkListName.TRRprep,'', '',WorkListName.TRR,'', '', WorkListName.Partner, '', '',
      WorkListName.Drill,'', '', WorkListName.Destress,'', '', WorkListName.DestressTensor,'', '',
      WorkListName.Railunload,'', '', WorkListName.MBCReplace,'', '', WorkListName.Lift,'', '',
      WorkListName.Pack,'', '', WorkListName.Generate,'', '', WorkListName.SEJ,'', '', WorkListName.RailPrep,'', '',
      WorkListName.LBR,'', '', WorkListName.Payment,'', '', WorkListName.Extra],
    ['','CMT','NOs','Road', 'CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road',
      'CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road',
      'CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road',
      'CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road','CMT','NOs','Road',
      'CMT','NOs','Road'],
  ];

  for(int u=0; u < date.length; u++){
    csvData.add(['${date[u]}','${subdocs[u][2]['${WorkListShort.ERC}-CMT']}','${subdocs[u][3]['${WorkListShort.ERC}-Nos']}','${subdocs[u][4]['${WorkListShort.ERC}_Road']}',
      '${subdocs[u][2]['${WorkListShort.MBS}-CMT']}','${subdocs[u][3]['${WorkListShort.MBS}-Nos']}','${subdocs[u][4]['${WorkListShort.MBS}_Road']}',
      '${subdocs[u][2]['${WorkListShort.RH}-CMT']}','${subdocs[u][3]['${WorkListShort.RH}-Nos']}','${subdocs[u][4]['${WorkListShort.RH}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Paint}-CMT']}','${subdocs[u][3]['${WorkListShort.Paint}-Nos']}','${subdocs[u][4]['${WorkListShort.Paint}_Road']}',
      '${subdocs[u][2]['${WorkListShort.ERCHeat}-CMT']}','${subdocs[u][3]['${WorkListShort.ERCHeat}-Nos']}','${subdocs[u][4]['${WorkListShort.ERCHeat}_Road']}',
      '${subdocs[u][2]['${WorkListShort.DressBox}-CMT']}','${subdocs[u][3]['${WorkListShort.DressBox}-Nos']}','${subdocs[u][4]['${WorkListShort.DressBox}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Gas}-CMT']}','${subdocs[u][3]['${WorkListShort.Gas}-Nos']}','${subdocs[u][4]['${WorkListShort.Gas}_Road']}',
      '${subdocs[u][2]['${WorkListShort.NewMBC}-CMT']}','${subdocs[u][3]['${WorkListShort.NewMBC}-Nos']}','${subdocs[u][4]['${WorkListShort.NewMBC}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Crib}-CMT']}','${subdocs[u][3]['${WorkListShort.Crib}-Nos']}','${subdocs[u][4]['${WorkListShort.Crib}_Road']}',
      '${subdocs[u][2]['${WorkListShort.TRRprep}-CMT']}','${subdocs[u][3]['${WorkListShort.TRRprep}-Nos']}','${subdocs[u][4]['${WorkListShort.TRRprep}_Road']}',
      '${subdocs[u][2]['${WorkListShort.TRR}-CMT']}','${subdocs[u][3]['${WorkListShort.TRR}-Nos']}','${subdocs[u][4]['${WorkListShort.TRR}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Partner}-CMT']}','${subdocs[u][3]['${WorkListShort.Partner}-Nos']}','${subdocs[u][4]['${WorkListShort.Partner}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Drill}-CMT']}','${subdocs[u][3]['${WorkListShort.Drill}-Nos']}','${subdocs[u][4]['${WorkListShort.Drill}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Destress}-CMT']}','${subdocs[u][3]['${WorkListShort.Destress}-Nos']}','${subdocs[u][4]['${WorkListShort.Destress}_Road']}',
      '${subdocs[u][2]['${WorkListShort.DestressTensor}-CMT']}','${subdocs[u][3]['${WorkListShort.DestressTensor}-Nos']}','${subdocs[u][4]['${WorkListShort.DestressTensor}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Railunload}-CMT']}','${subdocs[u][3]['${WorkListShort.Railunload}-Nos']}','${subdocs[u][4]['${WorkListShort.Railunload}_Road']}',
      '${subdocs[u][2]['${WorkListShort.MBCReplace}-CMT']}','${subdocs[u][3]['${WorkListShort.MBCReplace}-Nos']}','${subdocs[u][4]['${WorkListShort.MBCReplace}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Lift}-CMT']}','${subdocs[u][3]['${WorkListShort.Lift}-Nos']}','${subdocs[u][4]['${WorkListShort.Lift}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Pack}-CMT']}','${subdocs[u][3]['${WorkListShort.Pack}-Nos']}','${subdocs[u][4]['${WorkListShort.Pack}_Road']}',
      '${subdocs[u][2]['${WorkListShort.SEJ}-CMT']}','${subdocs[u][3]['${WorkListShort.SEJ}-Nos']}','${subdocs[u][4]['${WorkListShort.SEJ}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Generate}-CMT']}','${subdocs[u][3]['${WorkListShort.Generate}-Nos']}','${subdocs[u][4]['${WorkListShort.Generate}_Road']}',
      '${subdocs[u][2]['${WorkListShort.RailPrep}-CMT']}','${subdocs[u][3]['${WorkListShort.RailPrep}-Nos']}','${subdocs[u][4]['${WorkListShort.RailPrep}_Road']}',
      '${subdocs[u][2]['${WorkListShort.LBR}-CMT']}','${subdocs[u][3]['${WorkListShort.LBR}-Nos']}','${subdocs[u][4]['${WorkListShort.LBR}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Payment}-CMT']}','${subdocs[u][3]['${WorkListShort.Payment}-Nos']}','${subdocs[u][4]['${WorkListShort.Payment}_Road']}',
      '${subdocs[u][2]['${WorkListShort.Extra}-CMT']}','${subdocs[u][3]['${WorkListShort.Extra}-Nos']}','${subdocs[u][4]['${WorkListShort.Extra}_Road']}',
    ],);
  }
  csv(csvData, ex);
}

void csv(listdata, ExcelProvider ex) async{
  ex.setloadtext = 'Preparing the Excel file';
   var directory =  (await getExternalStorageDirectories());
   String dir = directory![0].path;
  final path = "$dir/${ex.getbillname}-${DateTime.now()}.csv";

  String csvData = ListToCsvConverter().convert(listdata);

   File file = File(path);
   await file.writeAsString(csvData);
   ex.setloadtext = "Done!";
   ex.setloading = false;
   ex.setfilevisible = true;
   ex.setfile = path;
   print("DONE");
}

final snackBarBillError = SnackBar(
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
  ),
  behavior: SnackBarBehavior.floating,
  duration: Duration(seconds: 2),
  backgroundColor: Colors.grey.shade400,
  margin: EdgeInsets.all(15.0),
  content: Text(
    "Please Select the Bill name",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    ),
  ),
);