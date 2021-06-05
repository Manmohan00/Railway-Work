import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';

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
      date, String work, nos, String comment, bill, user,road) async {
    String docdate = date.replaceAll(Months.Jan,'01').replaceAll(Months.Feb, '02')
        .replaceAll(Months.Mar, '03')
        .replaceAll(Months.Apr, '04')
        .replaceAll(Months.May, '05')
        .replaceAll(Months.June, '06')
        .replaceAll(Months.July, '07')
        .replaceAll(Months.August, '08')
        .replaceAll(Months.Sept, '09')
        .replaceAll(Months.Oct, '10')
        .replaceAll(Months.Nov, '11')
        .replaceAll(Months.Dec,'12');

    String shWork = work.replaceAll(WorkListName.ERC, WorkListShort.ERC)
    .replaceAll(WorkListName.MBS, WorkListShort.MBS)
    .replaceAll(WorkListName.RH, WorkListShort.RH)
    .replaceAll(WorkListName.Paint, WorkListShort.Paint).
    replaceAll(WorkListName.ERCHeat, WorkListShort.ERCHeat)
    .replaceAll(WorkListName.DressBox, WorkListShort.DressBox)
        .replaceAll(WorkListName.Gas, WorkListShort.Gas)
        .replaceAll(WorkListName.NewMBC, WorkListShort.NewMBC)
        .replaceAll(WorkListName.Crib, WorkListShort.Crib)
        .replaceAll(WorkListName.TRRprep, WorkListShort.TRRprep)
        .replaceAll(WorkListName.TRR, WorkListShort.TRR)
        .replaceAll(WorkListName.Partner, WorkListShort.Partner)
        .replaceAll(WorkListName.Drill, WorkListShort.Drill)
        .replaceAll(WorkListName.Destress, WorkListShort.Destress)
        .replaceAll(WorkListName.DestressTensor, WorkListShort.DestressTensor)
        .replaceAll(WorkListName.Railunload, WorkListShort.Railunload)
        .replaceAll(WorkListName.MBCReplace, WorkListShort.MBCReplace)
        .replaceAll(WorkListName.Lift, WorkListShort.Lift)
        .replaceAll(WorkListName.Pack, WorkListShort.Pack)
        .replaceAll(WorkListName.Generate, WorkListShort.Generate)
        .replaceAll(WorkListName.SEJ, WorkListShort.SEJ)
        .replaceAll(WorkListName.RailPrep, WorkListShort.RailPrep)
        .replaceAll(WorkListName.LBR, WorkListShort.LBR)
        .replaceAll(WorkListName.Payment, WorkListShort.Payment)
        .replaceAll(WorkListName.Extra, WorkListShort.Extra);


    QuerySnapshot doc = await _db
        .collection(bill)
        .doc(docdate)
        .collection("Work_done")
        .where(shWork, isEqualTo: true)
        .get();

    QuerySnapshot docBase = await _db
        .collection(bill)
        .doc(docdate)
        .collection("Work_done")
        .where('work_created', isEqualTo: true)
        .get();

    if (docBase.size == 0) {
        await _db.collection(bill).doc(docdate).set({
          'Time': Timestamp.fromDate(DateTime.parse(docdate)),
          'Created': false,
        });

      await _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc('Work')
          .set({
        'work_created':true,
        WorkListShort.ERC: false,
        WorkListShort.MBS: false,
        WorkListShort.RH: false,
        WorkListShort.Paint: false,
        WorkListShort.ERCHeat: false,
        WorkListShort.DressBox: false,
        WorkListShort.Gas: false,
        WorkListShort.NewMBC: false,
        WorkListShort.Crib: false,
        WorkListShort.TRRprep: false,
        WorkListShort.TRR: false,
        WorkListShort.Partner: false,
        WorkListShort.Drill: false,
        WorkListShort.Destress: false,
        WorkListShort.DestressTensor: false,
        WorkListShort.Railunload: false,
        WorkListShort.MBCReplace: false,
        WorkListShort.Lift: false,
        WorkListShort.Pack: false,
        WorkListShort.Generate: false,
        WorkListShort.SEJ: false,
        WorkListShort.RailPrep: false,
        WorkListShort.LBR: false,
        WorkListShort.Payment: false,
        WorkListShort.Extra: false,
      });
      await _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc('Work_Nos')
          .set({
      '${WorkListShort.ERC}-Nos': '0',
      '${WorkListShort.MBS}-Nos': '0',
      '${WorkListShort.RH}-Nos': '0',
      '${WorkListShort.Paint}-Nos': '0',
      '${WorkListShort.ERCHeat}-Nos': '0',
      '${WorkListShort.DressBox}-Nos': '0',
      '${WorkListShort.Gas}-Nos': '0',
      '${WorkListShort.NewMBC}-Nos': '0',
      '${WorkListShort.Crib}-Nos': '0',
      '${WorkListShort.TRRprep}-Nos': '0',
      '${WorkListShort.TRR}-Nos': '0',
      '${WorkListShort.Partner}-Nos': '0',
      '${WorkListShort.Drill}-Nos': '0',
      '${WorkListShort.Destress}-Nos': '0',
      '${WorkListShort.DestressTensor}-Nos': '0',
      '${WorkListShort.Railunload}-Nos': '0',
      '${WorkListShort.MBCReplace}-Nos': '0',
      '${WorkListShort.Lift}-Nos': '0',
      '${WorkListShort.Pack}-Nos': '0',
      '${WorkListShort.Generate}-Nos': '0',
      '${WorkListShort.SEJ}-Nos': '0',
      '${WorkListShort.RailPrep}-Nos': '0',
      '${WorkListShort.LBR}-Nos': '0',
      '${WorkListShort.Payment}-Nos': '0',
      '${WorkListShort.Extra}-Nos': '0',
      });
      await _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.comment)
          .set({
        'work_cmt': 'WorkCMT',
      });

        await _db
            .collection(bill)
            .doc(docdate)
            .collection("Work_done")
            .doc(FirebaseNames.road)
            .set({
          'work_road': 'road',
        });


      await _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.Added)
          .set({
        'Work_added': 'UserNames',
      });
      if (doc.size == 0) {
        if (comment.contains('None')) {
          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.work)
              .update({
            shWork: true,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.nos)
              .update({
            "$shWork-Nos": nos,
          });
           _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.Added)
              .update({
            '${shWork}_Added': user,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.road)
              .update({
            '${shWork}_Road': road,
          });


          return true;
        } else {
          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.work)
              .update({
            shWork: true,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.nos)
              .update({
            "$shWork-Nos": nos,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.comment)
              .update({"$shWork-CMT": comment});
          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.Added)
              .update({
            '${shWork}_Added': user,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.road)
              .update({
            '${shWork}_Road': road,
          });

          return true;
        }
      } else {
        return false;
      }
    } else {
      if (doc.size == 0) {
        if (comment.contains('None')) {
          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.work)
              .update({
            shWork: true,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.nos)
              .update({
            "$shWork-Nos": nos,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.Added)
              .update({
            '${shWork}_Added': user,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.road)
              .update({
            '${shWork}_Road': road,
          });

          return true;
        } else {
          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.work)
              .update({
            shWork: true,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.nos)
              .update({
            "$shWork-Nos": nos,
          });

          await _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.Added)
              .update({
            '${shWork}_Added': user,
          });

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.comment)
              .update({"$shWork-CMT": comment});

          _db
              .collection(bill)
              .doc(docdate)
              .collection("Work_done")
              .doc(FirebaseNames.road)
              .update({
            '${shWork}_Road': road,
          });

          return true;
        }
      } else {
        return false;
      }
    }
  }
}
