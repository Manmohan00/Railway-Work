import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseDeleteTransactions.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseUploadTransactions.dart';
import 'package:railway_work_tracking/backend/Provider/AddWorkProvider.dart';

import '../HomeScreen.dart';
import 'UiFunctions.dart';

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
            width: MediaQuery
                .of(context)
                .size
                .width / 100 * 20,
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
            onPressed: () async {
              var checkConnection =
              await (Connectivity().checkConnectivity());
              if (checkConnection == ConnectivityResult.none) {
                ScaffoldMessenger.of(context).showSnackBar(
                    snackBarInternetError);
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
