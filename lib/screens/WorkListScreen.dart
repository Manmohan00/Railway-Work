import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseDeleteTransactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseStreams.dart';
import 'package:railway_work_tracking/backend/Firebase/WorkDataModel.dart';
import 'package:railway_work_tracking/backend/Provider/AddWorkProvider.dart';
import 'package:railway_work_tracking/screens/AddWorkScreen.dart';
import 'package:railway_work_tracking/screens/UI/UiFunctions.dart';
import 'package:railway_work_tracking/screens/WorkPerDayList.dart';

class WorkListScreen extends StatelessWidget {
  static const String id = 'WorkListScreen';

  @override
  Widget build(BuildContext context) {
    Map arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String billName = arguments['Name'];
    return StreamProvider<List<WorkData>>.value(value: FirebaseStreams().getWorkDate(billName),
      initialData: [],
      child: ShowList(),
    );
  }
}

class ShowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List getWork = Provider.of<List<WorkData>>(context);
    Map arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String billName = arguments['Name'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextBoxforAll(billName, 2.0, 16.0, TextAlign.start),
      ),
      body: ListView.builder(
          itemCount: getWork.length,
          itemBuilder: (BuildContext context, int index) {
            String finalDate = DateFormat('dd/MMM/yy').format(getWork[index].date.toDate());
            String dateforFB = DateFormat('yyyy/MM/dd').format(getWork[index].date.toDate());
            String Day = DateFormat('EEEE, dd/MMM/yy').format(getWork[index].date.toDate());
            List finalDay = Day.split(",");
            String toDelete = DateFormat('yyyy-MM-dd').format(getWork[index].date.toDate());
            return Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1.5, color: Colors.orange),
              )),
              child: ListTile(
                title: TextBoxforAll("${finalDate.toUpperCase()}", 2.0, 15, TextAlign.start),
                subtitle: TextBoxforAll("${finalDay[0]}", 2.0, 12, TextAlign.start),
                trailing: Icon(Icons.navigate_next),
                onLongPress: (){
                  showModalBottomSheet(
                    elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))
                      ),
                      context: context,
                      builder: (context){
                        return ConfirmDelete(billName, toDelete, finalDate);
                      });
                },
                onTap: () {
                   Navigator.pushNamed(context, WorkPerDayList.id,
                       arguments: {
                     'dateforFB' : dateforFB,
                     'Name': billName,
                         'Date': finalDate,
                         'Day' : finalDay[0]
                       });
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AddWorkProvider>(context, listen: false).month
          = DateFormat('MMMM').format(DateTime.now());
          Navigator.pushNamed(context, AddWorkScreen.id, arguments: {
            'Bill': billName,
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class ConfirmDelete extends StatelessWidget {
  String billName;
  String date;
  String displayDate;

  ConfirmDelete(this.billName, this.date, this.displayDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 100 * 20,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
        //    border: Border.all(color: Colors.black54, width: 2.0)
          ),
          height:MediaQuery.of(context).size.height / 100 * 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: TextBoxforAll(
                    "Do you want to delete $displayDate from $billName?",
                    2.0, 15, TextAlign.center),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width /
                        100 *
                        30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15)),
                      ),
                      onPressed: () async {
                        var checkConnection =
                        await (Connectivity().checkConnectivity());
                        if (checkConnection == ConnectivityResult.none) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBarInternetError);
                        }
                        FirebaseDeleteTransactions().DeleteDoc(billName,date);
                        Navigator.pop(context);
                      },
                      child: TextBoxforAll("Delete", 3.0, 14.0, TextAlign.center),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width /
                        100 *
                        30,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 1.0,
                      color: Colors.yellow[300],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: TextBoxforAll("Cancel", 2.0, 12.0, TextAlign.center),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
