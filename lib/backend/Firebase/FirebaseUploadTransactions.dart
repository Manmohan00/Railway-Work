import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:railway_work_tracking/backend/Firebase/WorkDataModel.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';
import 'DataProcessor.dart';
import 'FirebaseUploadTransactionsSubFunctions.dart';

class FirebaseUploadTransactions {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  void AddBillToFirebase(String work) async {
    _db.collection('Railway').doc(work).set({
      'Bill': true,
      'BillName': work,
    });
  }

  Future<bool> AddCollectionToFirebase(bill) async {
    DocumentSnapshot doc = await _db.collection(bill).doc('Created').get();
    bool exists = doc.exists;
    if (exists == true) {
      print("Already there");
      return false;
    } else {
      await _db.collection(bill).doc('Created').set({
        'Created': true,
        'BillName': bill,
      });
      print("Created!");
      return true;
    }
  }

  Future<bool> AddworkToFirebase(
      date, String work, nos, String comment, bill, user,road,
      WorkRepeat workRepeatProvider) async {
    String docdate = dateChange(date);
    print(docdate);

    String shWork = ShortenWorkName(work);

    Map<String, int> repeatWork = {
      WorkListShort.ERC: workRepeatProvider.ERC,
      WorkListShort.MBS: workRepeatProvider.MBS,
      WorkListShort.RH: workRepeatProvider.RH,
      WorkListShort.Paint: workRepeatProvider.Paint,
      WorkListShort.ERCHeat: workRepeatProvider.ERCHeat,
      WorkListShort.DressBox: workRepeatProvider.DressBox,
      WorkListShort.Gas: workRepeatProvider.Gas,
      WorkListShort.NewMBC: workRepeatProvider.NewMBC,
      WorkListShort.Crib: workRepeatProvider.Crib,
      WorkListShort.TRRprep: workRepeatProvider.TRRprep,
      WorkListShort.TRR: workRepeatProvider.TRR,
      WorkListShort.Partner: workRepeatProvider.Partner,
      WorkListShort.Drill: workRepeatProvider.Drill,
      WorkListShort.Destress: workRepeatProvider.Destress,
      WorkListShort.DestressTensor: workRepeatProvider.DestressTensor,
      WorkListShort.Railunload: workRepeatProvider.Railunload,
      WorkListShort.MBCReplace: workRepeatProvider.MBCReplace,
      WorkListShort.Lift: workRepeatProvider.Lift,
      WorkListShort.Pack: workRepeatProvider.Pack,
      WorkListShort.Generate: workRepeatProvider.Generate,
      WorkListShort.SEJ: workRepeatProvider.SEJ,
      WorkListShort.RailPrep: workRepeatProvider.RailPrep,
      WorkListShort.LBR: workRepeatProvider.LBR,
      WorkListShort.Payment: workRepeatProvider.Payment,
      WorkListShort.Extra: workRepeatProvider.Extra,
    };


    QuerySnapshot doc = await _db // to know if the data of that speivifc work is added
        .collection(bill)
        .doc(docdate)
        .collection("Work_done")
        .where(shWork, isEqualTo: 1) //this gives problems check it
        .get();
    print(doc.size);
    // QuerySnapshot docBase = await _db //to know if the document is created
    //     .collection(bill)
    //     .doc(docdate)
    //     .collection("Work_done")
    //     .where('work_created', isEqualTo: 0)
    //     .get();
    //
   //  if (docBase.size == 0) {
   //      await _db.collection(bill).doc(docdate).set({
   //        'Time': Timestamp.fromDate(DateTime.parse(docdate)),
   //        'Created': false,
   //      });
   //
   // //   initialCreate(_db, bill,docdate);
   //
   //    if (doc.size == 0) {
   //      await onlytheFirstTime(_db, bill, docdate, shWork, nos,comment, road, user);
   //      return true;
   //    } else {
   //      bool? value = Morethanone(docdate, shWork, nos, comment, bill, user,road,repeatWork, doc, docBase, _db);
   //      return true;
   //    }
   //    //Second part below
   //  } else {
      if (doc.size == 0) {
        print(shWork);
         await onlytheFirstTimeSecond(_db, bill, docdate, shWork, nos,comment, road, user);
        return true;
      } else {
        print(doc.size);
        print("The else $shWork");
        await Morethanone(docdate, shWork, nos, comment, bill, user,road,repeatWork, doc, _db);
        return true;
      }
  }

  Future<bool> AddNewworkToFirebase(
      date, String work, nos, String comment, bill, user,road) async {
    String docdate = dateChange(date);

    String shWork = ShortenWorkName(work);

    QuerySnapshot doc = await _db // to know if the data of that speivifc work is added
        .collection(bill)
        .doc(docdate)
        .collection("Work_done")
        .where(shWork, isEqualTo: 1)
        .get();

    QuerySnapshot docBase = await _db //to know if the document is created
        .collection(bill)
        .doc(docdate)
        .collection("Work_done")
        .where('work_created', isEqualTo: 0)
        .get();

    if (docBase.size == 0) {
      await _db.collection(bill).doc(docdate).set({
        'Time': Timestamp.fromDate(DateTime.parse(docdate)),
        'Created': false,
      });

      await initialCreate(_db, bill,docdate);

      if (doc.size == 0) {
       onlytheFirstTime(_db, bill, docdate, shWork, nos,comment, road, user);
        return true;
      } else {
        return false;
      }
      //Second part below
    } else {
      if (doc.size == 0) {
         onlytheFirstTimeSecond(_db, bill, docdate, shWork, nos,comment, road, user);
        return true;
      } else {
        return false;
      }
    }
  }
}

