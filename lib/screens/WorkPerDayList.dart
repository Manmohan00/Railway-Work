import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Firebase/FirebaseStreams.dart';
import 'package:railway_work_tracking/backend/Firebase/WorkDataModel.dart';
import 'package:railway_work_tracking/backend/Provider/AddWorkProvider.dart';
import 'package:railway_work_tracking/backend/Provider/WorkListScreenProvider.dart';
import 'package:railway_work_tracking/screens/Addworkwithoutdate.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';
import 'package:railway_work_tracking/screens/UI/UiFunctions.dart';
import 'package:railway_work_tracking/screens/Update.dart';
import 'SharedPrefNames.dart';

class WorkPerDayList extends StatelessWidget {
  static const String id = 'WorkPerDayList';

  @override
  Widget build(BuildContext context) {
    Map arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String billName = arguments['Name'];
    String firebaseDate = arguments['dateforFB'];
    firebaseDate = firebaseDate.replaceAll('/', '-');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WorkListScreenProvider(),
        ),
        StreamProvider<WorkQuantity>.value(
            value: FirebaseStreams().getWorkQuantity(billName, firebaseDate),
            initialData: WorkQuantity.toJson({'': ''})),
        StreamProvider<WorkAddedbyUser>.value(
            value: FirebaseStreams().getWorkUser(billName, firebaseDate),
            initialData: WorkAddedbyUser.toJson({'': ''})),
        StreamProvider<WorkComment>.value(
            value: FirebaseStreams().getWorkComment(billName, firebaseDate),
            initialData: WorkComment.toJson({'': ''})),
        StreamProvider<WorkRoadorLoop>.value(
            value: FirebaseStreams().getWorkRoad(billName, firebaseDate),
            initialData: WorkRoadorLoop.toJson({'': ''})),
        StreamProvider<WorkRepeat>.value(
            value: FirebaseStreams().getWorkRepeat(billName, firebaseDate),
            initialData: WorkRepeat.toJson({'': 0})),
      ],
      child: ListBuild(),
    );
  }
}

class ListBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String billName = arguments['Name'];
    String date = arguments['Date'];
    String firebaseDate = arguments['dateforFB'].replaceAll('/', '-');

    WorkQuantity quantityProvider = Provider.of<WorkQuantity>(context);
    WorkAddedbyUser userProvider = Provider.of<WorkAddedbyUser>(context);
    WorkComment commentProvider = Provider.of<WorkComment>(context);
    WorkRoadorLoop roadprovider = Provider.of<WorkRoadorLoop>(context);
    WorkRepeat workRepeatProvider = Provider.of<WorkRepeat>(context);

    Map quantity = {
      WorkListShort.ERC: quantityProvider.ERC,
      WorkListShort.MBS: quantityProvider.MBS,
      WorkListShort.RH: quantityProvider.RH,
      WorkListShort.Paint: quantityProvider.Paint,
      WorkListShort.ERCHeat: quantityProvider.ERCHeat,
      WorkListShort.DressBox: quantityProvider.DressBox,
      WorkListShort.Gas: quantityProvider.Gas,
      WorkListShort.NewMBC: quantityProvider.NewMBC,
      WorkListShort.Crib: quantityProvider.Crib,
      WorkListShort.TRRprep: quantityProvider.TRRprep,
      WorkListShort.TRR: quantityProvider.TRR,
      WorkListShort.Partner: quantityProvider.Partner,
      WorkListShort.Drill: quantityProvider.Drill,
      WorkListShort.Destress: quantityProvider.Destress,
      WorkListShort.DestressTensor: quantityProvider.DestressTensor,
      WorkListShort.Railunload: quantityProvider.Railunload,
      WorkListShort.MBCReplace: quantityProvider.MBCReplace,
      WorkListShort.Lift: quantityProvider.Lift,
      WorkListShort.Pack: quantityProvider.Pack,
      WorkListShort.Generate: quantityProvider.Generate,
      WorkListShort.SEJ: quantityProvider.SEJ,
      WorkListShort.RailPrep: quantityProvider.RailPrep,
      WorkListShort.LBR: quantityProvider.LBR,
      WorkListShort.Payment: quantityProvider.Payment,
      WorkListShort.Extra: quantityProvider.Extra,
    };
    Map user = {
      WorkListShort.ERC: userProvider.ERC,
      WorkListShort.MBS: userProvider.MBS,
      WorkListShort.RH: userProvider.RH,
      WorkListShort.Paint: userProvider.Paint,
      WorkListShort.ERCHeat: userProvider.ERCHeat,
      WorkListShort.DressBox: userProvider.DressBox,
      WorkListShort.Gas: userProvider.Gas,
      WorkListShort.NewMBC: userProvider.NewMBC,
      WorkListShort.Crib: userProvider.Crib,
      WorkListShort.TRRprep: userProvider.TRRprep,
      WorkListShort.TRR: userProvider.TRR,
      WorkListShort.Partner: userProvider.Partner,
      WorkListShort.Drill: userProvider.Drill,
      WorkListShort.Destress: userProvider.Destress,
      WorkListShort.DestressTensor: userProvider.DestressTensor,
      WorkListShort.Railunload: userProvider.Railunload,
      WorkListShort.MBCReplace: userProvider.MBCReplace,
      WorkListShort.Lift: userProvider.Lift,
      WorkListShort.Pack: userProvider.Pack,
      WorkListShort.Generate: userProvider.Generate,
      WorkListShort.SEJ: userProvider.SEJ,
      WorkListShort.RailPrep: userProvider.RailPrep,
      WorkListShort.LBR: userProvider.LBR,
      WorkListShort.Payment: userProvider.Payment,
      WorkListShort.Extra: userProvider.Extra,
    };
    Map comment = {
      WorkListShort.ERC: commentProvider.ERC,
      WorkListShort.MBS: commentProvider.MBS,
      WorkListShort.RH: commentProvider.RH,
      WorkListShort.Paint: commentProvider.Paint,
      WorkListShort.ERCHeat: commentProvider.ERCHeat,
      WorkListShort.DressBox: commentProvider.DressBox,
      WorkListShort.Gas: commentProvider.Gas,
      WorkListShort.NewMBC: commentProvider.NewMBC,
      WorkListShort.Crib: commentProvider.Crib,
      WorkListShort.TRRprep: commentProvider.TRRprep,
      WorkListShort.TRR: commentProvider.TRR,
      WorkListShort.Partner: commentProvider.Partner,
      WorkListShort.Drill: commentProvider.Drill,
      WorkListShort.Destress: commentProvider.Destress,
      WorkListShort.DestressTensor: commentProvider.DestressTensor,
      WorkListShort.Railunload: commentProvider.Railunload,
      WorkListShort.MBCReplace: commentProvider.MBCReplace,
      WorkListShort.Lift: commentProvider.Lift,
      WorkListShort.Pack: commentProvider.Pack,
      WorkListShort.Generate: commentProvider.Generate,
      WorkListShort.SEJ: commentProvider.SEJ,
      WorkListShort.RailPrep: commentProvider.RailPrep,
      WorkListShort.LBR: commentProvider.LBR,
      WorkListShort.Payment: commentProvider.Payment,
      WorkListShort.Extra: commentProvider.Extra,
    };

    Map roadorLoop = {
      WorkListShort.ERC: roadprovider.ERC,
      WorkListShort.MBS: roadprovider.MBS,
      WorkListShort.RH: roadprovider.RH,
      WorkListShort.Paint: roadprovider.Paint,
      WorkListShort.ERCHeat: roadprovider.ERCHeat,
      WorkListShort.DressBox: roadprovider.DressBox,
      WorkListShort.Gas: roadprovider.Gas,
      WorkListShort.NewMBC: roadprovider.NewMBC,
      WorkListShort.Crib: roadprovider.Crib,
      WorkListShort.TRRprep: roadprovider.TRRprep,
      WorkListShort.TRR: roadprovider.TRR,
      WorkListShort.Partner: roadprovider.Partner,
      WorkListShort.Drill: roadprovider.Drill,
      WorkListShort.Destress: roadprovider.Destress,
      WorkListShort.DestressTensor: roadprovider.DestressTensor,
      WorkListShort.Railunload: roadprovider.Railunload,
      WorkListShort.MBCReplace: roadprovider.MBCReplace,
      WorkListShort.Lift: roadprovider.Lift,
      WorkListShort.Pack: roadprovider.Pack,
      WorkListShort.Generate: roadprovider.Generate,
      WorkListShort.SEJ: roadprovider.SEJ,
      WorkListShort.RailPrep: roadprovider.RailPrep,
      WorkListShort.LBR: roadprovider.LBR,
      WorkListShort.Payment: roadprovider.Payment,
      WorkListShort.Extra: roadprovider.Extra,
    };


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(date),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: ListView.builder(
              itemCount: WorkListName.workListALL.length,
              itemBuilder: (BuildContext context, int index) {
               // print(quantity[WorkListShort.workListALL[0]]);
                return Visibility(
                  visible: quantity[WorkListShort.workListALL[index]] != '0'
                      ? true
                      : false,
                  child: GestureDetector(
                    onDoubleTap: () {
                      Provider.of<AddWorkProvider>(context, listen: false)
                              .quantity =
                          quantity[WorkListShort.workListALL[index]] ?? '';
                      Provider.of<AddWorkProvider>(context, listen: false)
                          .Comment = comment[WorkListShort.workListALL[index]];
                      Provider.of<AddWorkProvider>(context, listen: false).roadandLoop=
                          roadorLoop[WorkListShort.workListALL[index]] ;

                      showModalBottomSheet(
                          enableDrag: false,
                          isDismissible: false,
                          isScrollControlled: true,
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          context: context,
                          builder: (context) {
                            return Update(
                                billName,
                                WorkListShort.workListALL[index],
                                WorkListName.workListALL[index],
                                comment[WorkListShort.workListALL[index]],
                                quantity[WorkListShort.workListALL[index]],
                                firebaseDate);
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 3.0,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: Border.all(color: Colors.orange, width: 2.0)),
                      child: ExpansionTile(
                        trailing: TextBoxforAll(
                            quantity[WorkListShort.workListALL[index]],
                            2.0,
                            15,
                            TextAlign.justify,
                            colors: Colors.blueAccent.shade700),
                        title: TextBoxforAll(WorkListName.workListALL[index],
                            2.0, 12, TextAlign.start),
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(10.0),
                                  alignment: Alignment.topLeft,
                                  child: Comment(comment, roadorLoop, index)),
                              Container(
                                  margin: EdgeInsets.all(10.0),
                                  alignment: Alignment.bottomRight,
                                  child: UserName(user, index)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Addworkwithoutdate.id,
          arguments: {
            'work' : workRepeatProvider,
            'Bill' : billName,
            'Date' : firebaseDate,
            'displayDate' : date,
          });
        },
      ),
    );
  }
}

class UserName extends StatelessWidget {
  Map user;
  int index;

  UserName(this.user, this.index);

  @override
  Widget build(BuildContext context) {
    return TextBoxforAll(
        user[WorkListShort.workListALL[index]] == 'none'
            ? 'Not added'
            : user[WorkListShort.workListALL[index]],
        2.0,
        12,
        TextAlign.justify);
  }
}

class Comment extends StatelessWidget {
  Map comment;
  Map road;
  int index;

  Comment(this.comment, this.road, this.index);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 100 * 60,
          child: TextBoxforAll(
              comment[WorkListShort.workListALL[index]] == 'none'
                  ? 'No Comments'
                  : comment[WorkListShort.workListALL[index]],
              1.5,
              12,
              TextAlign.start,
            colors:comment[WorkListShort.workListALL[index]] == 'none'
                ? Colors.black54
                : Colors.black87,
          weight: FontWeight.w500,),
        ),
        TextBoxforAll(
            road[WorkListShort.workListALL[index]] == 'none'
                ? ''
                : road[WorkListShort.workListALL[index]],
            2.0,
            12,
            TextAlign.start,
        colors: Colors.blueAccent.shade700,),
      ],
    );
  }
}

class Update extends StatelessWidget {
  String billName;
  String workName;
  String displayName;
  String comment;
  String quantity;
  String firebaseDate;

  Update(this.billName, this.workName, this.displayName, this.comment,
      this.quantity, this.firebaseDate);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(),
          child: UpdateScreen(
              billName, workName, displayName, comment, quantity, firebaseDate),
        ),
      ),
    );
  }
}
