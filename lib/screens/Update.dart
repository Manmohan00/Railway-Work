import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseUpdate.dart';
import 'package:railway_work_tracking/backend/Provider/AddWorkProvider.dart';
import 'package:railway_work_tracking/backend/Provider/UserData.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';
import 'package:railway_work_tracking/screens/UI/UiFunctions.dart';

class UpdateScreen extends StatelessWidget {
  String billName;
  String workName;
  String displayName;
  String comment;
  String quantity;
  String firebaseDate;

  UpdateScreen(this.billName,this.workName, this.displayName, this.comment, this.quantity, this.firebaseDate);

  @override
  Widget build(BuildContext context) {
    AddWorkProvider workProvider = Provider.of<AddWorkProvider>(context);
    UserData userName = Provider.of<UserData>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextBoxforAll('$displayName', 2.0, 13,
                  TextAlign.center, colors: Colors.blueAccent.shade700,),
                ),
                Quantity(quantity),
                RoadorLoop(),
                Comment(comment),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
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
                              String _quantity =
                                  workProvider.getQuantity ?? '';
                              String _comment =
                                  workProvider.getComment ?? '';
                              String _user = userName.userName ?? '';
                              String _roadandLoop = workProvider.getRoadLoop;

                              if (_quantity == '0' || _quantity.isEmpty) {
                                _quantity = '0';
                                FirebaseUpdate().Removedata(billName, workName,
                                    firebaseDate);
                                workProvider.quantity = '';
                                workProvider.Comment = '';
                                workProvider.roadandLoop = FirebaseNames.roadup;
                                Navigator.pop(context);
                              }
                              else {
                                if (comment == 'none') {
                                  if (_comment.isEmpty) {
                                    _comment = 'none';
                                    FirebaseUpdate().
                                    UpdatedataNocomment(
                                        billName,
                                        workName,
                                        firebaseDate,
                                        _user,
                                        _comment,
                                        _quantity,
                                        _roadandLoop);
                                    workProvider.quantity = '';
                                    workProvider.Comment = '';
                                    workProvider.roadandLoop =
                                        FirebaseNames.roadup;
                                    Navigator.pop(context);
                                  }
                                  else {
                                    FirebaseUpdate().
                                    Updatedata(
                                        billName,
                                        workName,
                                        firebaseDate,
                                        _user,
                                        _comment,
                                        _quantity,
                                        _roadandLoop);
                                    workProvider.quantity = '';
                                    workProvider.Comment = '';
                                    workProvider.roadandLoop =
                                        FirebaseNames.roadup;
                                    Navigator.pop(context);
                                  }
                                }
                                else {
                                  if (_comment.isEmpty) {
                                    _comment = 'none';
                                    FirebaseUpdate().
                                    UpdatedataNocomment(
                                        billName,
                                        workName,
                                        firebaseDate,
                                        _user,
                                        _comment,
                                        _quantity,
                                        _roadandLoop);
                                    workProvider.quantity = '';
                                    workProvider.Comment = '';
                                    workProvider.roadandLoop =
                                        FirebaseNames.roadup;
                                    Navigator.pop(context);
                                  }
                                  else {
                                    FirebaseUpdate().
                                    Updatedata(
                                        billName,
                                        workName,
                                        firebaseDate,
                                        _user,
                                        _comment,
                                        _quantity,
                                        _roadandLoop);
                                    workProvider.quantity = '';
                                    workProvider.Comment = '';
                                    workProvider.roadandLoop =
                                        FirebaseNames.roadup;
                                    Navigator.pop(context);
                                  }
                                }
                              }
                            }
                          },
                          child: TextBoxforAll(
                              "Update", 3.0, 14.0, TextAlign.center),
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
    );
  }
}

class Quantity extends StatefulWidget {
  String quantity;
  Quantity(this.quantity);
  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  TextEditingController quantity = TextEditingController();

  void initState(){
    quantity.text = widget.quantity;
  }

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
  String commentText;
  Comment(this.commentText);
  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {

  TextEditingController comment = TextEditingController();

  void initState(){
    comment.text = widget.commentText;
  }
  @override
  void dispose() {
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddWorkProvider Comment = Provider.of<AddWorkProvider>(context);
    return Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
        width: MediaQuery.of(context).size.width / 100 * 90,
        child: TextField(
          textAlignVertical: TextAlignVertical.top,
          maxLines: 5,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            comment.text = value;
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

final snackBarNosError = SnackBar(
  content: Text(
    "Nos cannot be empty",
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
