import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseUploadTransactions.dart';
import 'package:railway_work_tracking/backend/Provider/AddWorkProvider.dart';
import 'package:railway_work_tracking/backend/Provider/UserData.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';
import 'package:railway_work_tracking/screens/UI/UiFunctions.dart';

class Addworkwithoutdate extends StatelessWidget {
  static const String id = 'Addworkwithoutdate';

  @override
  Widget build(BuildContext context) {
    AddWorkProvider workProvider = Provider.of<AddWorkProvider>(context);
    UserData userName = Provider.of<UserData>(context);

    Map arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String billName = arguments['Bill'];
    String date = arguments['Date'];
    String displayDate = arguments['displayDate'];

    return workProvider.LoadingStatus
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.deepOrange,
              strokeWidth: 5.0,
              backgroundColor: Colors.orange,
            )),
          )
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: TextBoxforAll(displayDate, 2.0, 18, TextAlign.start),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WorkList(),
                        Quantity(),
                        RoadorLoop(),
                        Comment(),
                        Container(
                          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /
                                    100 *
                                    40,
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
                                    else {
                                      String quantity =
                                          workProvider.getQuantity ?? '';
                                      String work = workProvider.getWork ?? '';
                                      String comment =
                                          workProvider.getComment ?? '';
                                      String user = userName.userName ?? '';
                                      String _roadorLoop = workProvider
                                          .getRoadLoop;

                                      if (quantity.isEmpty == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarNosError);
                                      } else {
                                        workProvider.Loading = true;
                                        if (comment.isEmpty) {
                                          comment = 'None';
                                        }
                                        bool doesNotexists =
                                        await FirebaseUploadTransactions()
                                            .AddworkToFirebase(
                                            date,
                                            work,
                                            quantity,
                                            comment,
                                            billName,
                                            user,
                                            _roadorLoop
                                        );

                                        if (doesNotexists == false) {
                                          workProvider.Loading = false;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              snackBaralreadyAddedError);
                                        } else {
                                          workProvider.quantity = '';
                                          workProvider.work = WorkListName.ERC;
                                          workProvider.roadandLoop =
                                              FirebaseNames.roadup;
                                          workProvider.Comment = '';
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(DataAdded);
                                          workProvider.Loading = false;
                                          Navigator.pop(context);
                                        }
                                      }
                                    }
                                  },
                                  child: TextBoxforAll(
                                      "Save", 3.0, 14.0, TextAlign.center),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width /
                                    100 *
                                    40,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 1.0,
                                  color: Colors.yellow[300],
                                  onPressed: () {
                                    workProvider.quantity = '';
                                    workProvider.work = WorkListName.ERC;
                                    workProvider.Comment = '';
                                    workProvider.roadandLoop = FirebaseNames.roadup;
                                    Navigator.pop(context);
                                  },
                                  child: TextBoxforAll(
                                      "Cancel", 2.0, 12.0, TextAlign.center),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class WorkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddWorkProvider workProvider = Provider.of<AddWorkProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width / 100 * 80,
      padding: EdgeInsets.all(5.0),
      child: DropdownButton<String>(
        icon: Icon(Icons.directions_railway),
        hint: Text("Work Name"),
        value: workProvider.getWork,
        onChanged: (value) {
          workProvider.work = value;
        },
        isExpanded: true,
        items: <String>[
          WorkListName.ERC,
          WorkListName.MBS,
          WorkListName.RH,
          WorkListName.Paint,
          WorkListName.ERCHeat,
          WorkListName.DressBox,
          WorkListName.Gas,
          WorkListName.NewMBC,
          WorkListName.Crib,
          WorkListName.TRRprep,
          WorkListName.TRR,
          WorkListName.Partner,
          WorkListName.Drill,
          WorkListName.Destress,
          WorkListName.DestressTensor,
          WorkListName.Railunload,
          WorkListName.MBCReplace,
          WorkListName.Lift,
          WorkListName.Pack,
          WorkListName.Generate,
          WorkListName.SEJ,
          WorkListName.RailPrep,
          WorkListName.LBR,
          WorkListName.Payment,
          WorkListName.Extra
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
    );
  }
}

class Quantity extends StatefulWidget {
  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  TextEditingController quantity = TextEditingController();

  @override
  void dispose() {
    quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddWorkProvider quanTity = Provider.of<AddWorkProvider>(context);
    return Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0, top: 20.0),
        width: MediaQuery.of(context).size.width / 100 * 20,
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            quantity.text = value;
            print(quantity.text);
            quanTity.quantity = value;
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: quantity.text,
              selection: TextSelection.collapsed(
                offset: quantity.text.length,
              ),
            ),
          ),
          decoration: InputDecoration(
              labelText: "Nos",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.orange),
                borderRadius: BorderRadius.circular(15),
              )),
        ));
  }
}

class Comment extends StatefulWidget {
  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  TextEditingController comment = TextEditingController();

  @override
  void dispose() {
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddWorkProvider Comment = Provider.of<AddWorkProvider>(context);
    return Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0, top: 20.0),
        width: MediaQuery.of(context).size.width / 100 * 90,
        child: TextField(
          textAlignVertical: TextAlignVertical.top,
          maxLines: 3,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            comment.text = value;
            print(comment.text);
            Comment.Comment = value;
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: comment.text,
              selection: TextSelection.collapsed(
                offset: comment.text.length,
              ),
            ),
          ),
          decoration: InputDecoration(
              labelText: "Optional Comments",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.orange),
                borderRadius: BorderRadius.circular(15),
              )),
        ));
  }
}

class RoadorLoop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddWorkProvider _wp = Provider.of<AddWorkProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            AnimatedOpacity(
              opacity: _wp.getisRoadorLoopactive == 0 ? 1 : 0.5,
              duration: Duration(milliseconds: 500),
              child: MaterialButton(
                  elevation: _wp.getisRoadorLoopactive == 0 ? 1.5 : 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: _wp.getisRoadorLoopactive == 0
                      ? Colors.orangeAccent
                      : Colors.orangeAccent.shade100,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_upward_rounded,
                        size: 15,
                      ),
                      TextBoxforAll(FirebaseNames.roadup, 1.5, 12, TextAlign.center)
                    ],
                  ),
                  onPressed: () {
                    _wp.roadandLoop = FirebaseNames.roadup;
                  }),
            ),
            AnimatedOpacity(
              opacity: _wp.getisRoadorLoopactive == 1 ? 1 : 0.5,
              duration: Duration(milliseconds: 500),
              child: MaterialButton(
                  elevation: _wp.getisRoadorLoopactive == 1 ? 1.5 : 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: _wp.getisRoadorLoopactive == 1
                      ? Colors.orangeAccent
                      : Colors.orangeAccent.shade100,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_road,
                        size: 15,
                      ),
                      TextBoxforAll(FirebaseNames.roadmid, 1.5, 12, TextAlign.center)
                    ],
                  ),
                  onPressed: () {
                    _wp.roadandLoop = FirebaseNames.roadmid;
                  }),
            ),
            AnimatedOpacity(
              opacity: _wp.getisRoadorLoopactive == 2 ? 1 : 0.5,
              duration: Duration(milliseconds: 500),
              child: MaterialButton(
                  elevation: _wp.getisRoadorLoopactive == 2 ? 1.5 : 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: _wp.getisRoadorLoopactive == 2
                      ? Colors.orangeAccent
                      : Colors.orangeAccent.shade100,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_downward_rounded,
                        size: 15,
                      ),
                      TextBoxforAll(FirebaseNames.roaddown, 1.5, 12, TextAlign.center),
                    ],
                  ),
                  onPressed: () {
                    _wp.roadandLoop = FirebaseNames.roaddown;
                  }),
            ),
          ],
        ),
        Column(
          children: [
            AnimatedOpacity(
              opacity: _wp.getisRoadorLoopactive == 3 ? 1 : 0.5,
              duration: Duration(milliseconds: 500),
              child: MaterialButton(
                  elevation: _wp.getisRoadorLoopactive == 3 ? 1.5 : 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: _wp.getisRoadorLoopactive == 3
                      ? Colors.orangeAccent
                      : Colors.orangeAccent.shade100,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_upward_rounded,
                        size: 15,
                      ),
                      TextBoxforAll(FirebaseNames.loopup, 1.5, 12, TextAlign.center)
                    ],
                  ),
                  onPressed: () {
                    _wp.roadandLoop = FirebaseNames.loopup;
                  }),
            ),
            AnimatedOpacity(
              opacity: _wp.getisRoadorLoopactive == 4 ? 1 : 0.5,
              duration: Duration(milliseconds: 500),
              child: MaterialButton(
                  elevation: _wp.getisRoadorLoopactive == 4 ? 1.5 : 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: _wp.getisRoadorLoopactive == 4
                      ? Colors.orangeAccent
                      : Colors.orangeAccent.shade100,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_road,
                        size: 15,
                      ),
                      TextBoxforAll(FirebaseNames.loopmid, 1.5, 12, TextAlign.center)
                    ],
                  ),
                  onPressed: () {
                    _wp.roadandLoop = FirebaseNames.loopmid;
                  }),
            ),
            AnimatedOpacity(
              opacity: _wp.getisRoadorLoopactive == 5 ? 1 : 0.5,
              duration: Duration(milliseconds: 500),
              child: MaterialButton(
                  elevation: _wp.getisRoadorLoopactive == 5 ? 1.5 : 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: _wp.getisRoadorLoopactive == 5
                      ? Colors.orangeAccent
                      : Colors.orangeAccent.shade100,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_downward_rounded,
                        size: 15,
                      ),
                      TextBoxforAll(FirebaseNames.loopdown, 1.5, 12, TextAlign.center),
                    ],
                  ),
                  onPressed: () {
                    _wp.roadandLoop = FirebaseNames.loopdown;
                  }),
            ),
          ],
        ),
      ],
    );
  }
}

final snackBarDayError = SnackBar(
  content: Text(
    "Day & Month cannot be empty",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    ),
  ),
);

final snackBarNosError = SnackBar(
  content: Text(
    "Nos cannot be empty",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    ),
  ),
);

final snackBaralreadyAddedError = SnackBar(
  content: Text(
    "That work is already added",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    ),
  ),
);

final DataAdded = SnackBar(
  content: Text(
    "Work added!!",
    style: TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    ),
  ),
);
