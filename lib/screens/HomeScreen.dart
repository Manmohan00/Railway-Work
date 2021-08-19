import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Authentication.dart';
import 'package:railway_work_tracking/backend/Firebase/BillNameModel.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseUploadTransactions.dart';
import 'package:railway_work_tracking/backend/Provider/ExportasExcelProvider.dart';
import 'package:railway_work_tracking/backend/Provider/UserData.dart';
import 'package:railway_work_tracking/screens/ExportasExcel.dart';
import 'package:railway_work_tracking/screens/LoginScreen.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';
import 'package:railway_work_tracking/screens/UI/UiFunctions.dart';
import 'package:railway_work_tracking/screens/WorkListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/HomeScreenUI.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'homescreen';

  @override
  Widget build(BuildContext context) {
    //UpdateUserData(context);
    Size size = MediaQuery.of(context).size;
    var getUserData = Provider.of<UserData>(context);
    List getBill = Provider.of<List<BillNameModel>>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Track Work Record"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              signOut();
              Navigator.popAndPushNamed(context, LoginScreen.id);
            },
            icon: Icon(Icons.logout)),
      ),
      //
      body: getBill.isEmpty
          ? Center(
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/railway-work-tracking.appspot.com/o/CodeImages%2FHome.jpg?alt=media&token=49ba4aef-6cd7-4302-ae01-bb2152e0b765",
                width: MediaQuery.of(context).size.width / 100 * 50,
              ),
            )
          : SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getBill.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.5, color: Colors.orange),
                              )),
                              child: ListTile(
                                title: TextBoxforAll("${getBill[index].billName}",
                                    2.0, 15, TextAlign.start),
                                trailing: Icon(Icons.navigate_next),
                                onLongPress: () {
                                  showModalBottomSheet(
                                      elevation: 8.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20))),
                                      context: context,
                                      builder: (context) {
                                        return ConfirmDeleteCollection(
                                            getBill[index].billName);
                                      });
                                },
                                onTap: () async {
                                  String bill = getBill[index].billName;
                                  UpdateUserData(context);

                                  Navigator.pushNamed(context, WorkListScreen.id,
                                      arguments: {'Name': bill});
                                  await FirebaseUploadTransactions()
                                      .AddCollectionToFirebase(bill);
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ExcelExport.id);
                    Provider.of<ExcelProvider>(context, listen: false).setfilevisible = false;
                  },
                  elevation: 2.0,
                  splashColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  child: TextBoxforAll("Export as Excel", 1.5, 13, TextAlign.center),
                  color: Colors.greenAccent.shade700,
                )
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (ctx) => WorkName());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void UpdateUserData(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Provider.of<UserData>(context, listen: false).setUserName =
        pref.getString(SharedPrefName.UserName);
    Provider.of<UserData>(context, listen: false).setUserEmail =
        pref.getString(SharedPrefName.Email);
  }

  Future<void> signOut() async {
    setloginStatusfalse();
    await Authentication().signOut();
  }

  setloginStatusfalse() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("logInStatus", false);
  }
}

final snackBarloginError = SnackBar(
  content: Text(
    "Work Name cannot be empty",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    ),
  ),
);
