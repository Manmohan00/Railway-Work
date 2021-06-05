import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Authentication.dart';
import 'package:railway_work_tracking/backend/Firebase/BillNameModel.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseDeleteTransactions.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseUploadTransactions.dart';
import 'package:railway_work_tracking/backend/Provider/AddWorkProvider.dart';
import 'package:railway_work_tracking/backend/Provider/UserData.dart';
import 'package:railway_work_tracking/screens/LoginScreen.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';
import 'package:railway_work_tracking/screens/UI/UiFunctions.dart';
import 'package:railway_work_tracking/screens/WorkListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'homescreen';

  @override
  Widget build(BuildContext context) {
    //UpdateUserData(context);
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
          : ListView.builder(
              shrinkWrap: true,
              itemCount: getBill.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1.5, color: Colors.orange),
                  )),
                  child: ListTile(
                    title: TextBoxforAll("${getBill[index].billName}", 2.0, 15, TextAlign.start),
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
                            return ConfirmDeleteCollection(getBill[index].billName);
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
                );
              }),
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

class WorkName extends StatelessWidget {
  TextEditingController work = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AddWorkProvider setDay = Provider.of<AddWorkProvider>(context);
    return Container(
      child: AlertDialog(
        content: Container(
            margin:
                EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0, top: 20.0),
            width: MediaQuery.of(context).size.width / 100 * 20,
            child: TextField(
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: work.text,
                  selection: TextSelection.collapsed(
                    offset: work.text.length,
                  ),
                ),
              ),
              onChanged: (value) {
                work.text = value;
                setDay.Bill = work.text;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Bill Name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.5, color: Colors.orange),
                    borderRadius: BorderRadius.circular(15),
                  )),
            )),
        actions: <Widget>[
          MaterialButton(
            elevation: 2.0,
            color: Colors.amber,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
            ),
            onPressed: () async{
              var checkConnection =
              await (Connectivity().checkConnectivity());
              if (checkConnection == ConnectivityResult.none) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarInternetError);
              }
              if (work.text != '') {
                String workName = setDay.Bill;
                FirebaseUploadTransactions().AddBillToFirebase(workName);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(snackBarloginError);
              }
            },
            child: TextBoxforAll("Save", 3.0, 14.0, TextAlign.center),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 1.0,
            color: Colors.yellow[300],
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextBoxforAll("Cancel", 2.0, 12.0, TextAlign.center),
          ),
        ],
      ),
    );
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
}


class ConfirmDeleteCollection extends StatelessWidget {
  String billName;

  ConfirmDeleteCollection(this.billName);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 100 * 20,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          height:MediaQuery.of(context).size.height / 100 * 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: TextBoxforAll(
                    "Do you want to delete $billName?",
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
                        FirebaseDeleteTransactions().DeleteCollection(billName);
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
