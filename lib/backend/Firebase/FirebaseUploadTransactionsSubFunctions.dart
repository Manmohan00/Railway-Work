

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:railway_work_tracking/backend/Firebase/WorkDataModel.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';

Future<bool> initialCreate(FirebaseFirestore _db,String bill,String docdate) async{
  await _db
      .collection(bill)
      .doc(docdate)
      .collection("Work_done")
      .doc('Work')
      .set({
    'work_created':0,
    WorkListShort.ERC: 0,
    WorkListShort.MBS: 0,
    WorkListShort.RH: 0,
    WorkListShort.Paint: 0,
    WorkListShort.ERCHeat: 0,
    WorkListShort.DressBox: 0,
    WorkListShort.Gas: 0,
    WorkListShort.NewMBC: 0,
    WorkListShort.Crib: 0,
    WorkListShort.TRRprep: 0,
    WorkListShort.TRR: 0,
    WorkListShort.Partner: 0,
    WorkListShort.Drill: 0,
    WorkListShort.Destress: 0,
    WorkListShort.DestressTensor: 0,
    WorkListShort.Railunload: 0,
    WorkListShort.MBCReplace: 0,
    WorkListShort.Lift: 0,
    WorkListShort.Pack: 0,
    WorkListShort.Generate: 0,
    WorkListShort.SEJ: 0,
    WorkListShort.RailPrep: 0,
    WorkListShort.LBR: 0,
    WorkListShort.Payment: 0,
    WorkListShort.Extra: 0,
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
  return true;
}


Future<bool> Morethanone(String docdate, String shWork,String nos,String comment,String bill,String user,
    String road,Map<String, int> repeatWork,QuerySnapshot doc,FirebaseFirestore _db) async{

  if (doc.size != 0) {
    print(docdate);
    int nextnum = repeatWork[shWork]!+1;
    if (comment.contains('None')) {
      print("SHSHS --> ${repeatWork[shWork]}, $nextnum");//Add if no comment
      _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.work)
          .update({
        shWork: nextnum,
      });

      _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.nos)
          .update({
        "$shWork-Nos$nextnum": nos,
      });
      _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.Added)
          .update({
        '${shWork}_Added$nextnum': user,
      });

      _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.road)
          .update({
        '${shWork}_Road$nextnum': road,
      });
      return true;
    } else {
      _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.work)
          .update({
        shWork: nextnum,
      });

      _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.nos)
          .update({
        "$shWork-Nos$nextnum": nos,
      });

      _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.comment)
          .update({"$shWork-CMT$nextnum": comment});
      _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.Added)
          .update({
        '${shWork}_Added$nextnum': user,
      });

      _db
          .collection(bill)
          .doc(docdate)
          .collection("Work_done")
          .doc(FirebaseNames.road)
          .update({
        '${shWork}_Road$nextnum': road,
      });

      return true;
    }
  }
  return true;
}


Future<bool> onlytheFirstTime(FirebaseFirestore _db, String bill,String docdate,
    String shWork,String  nos, String comment, String road,String  user) async{
  if (comment.contains('None')) {       //Add if no comment
    _db
        .collection(bill)
        .doc(docdate)
        .collection("Work_done")
        .doc(FirebaseNames.work)
        .update({
      shWork: 1,
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
    print("The IF part");
    return true;
  } else {
    print("The else part");
    _db
        .collection(bill)
        .doc(docdate)
        .collection("Work_done")
        .doc(FirebaseNames.work)
        .update({
      shWork: 1,
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
        .update(
        {"$shWork-CMT": comment});
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
}

Future<bool> onlytheFirstTimeSecond(FirebaseFirestore _db,String bill, docdate, String shWork, String nos,String comment,String road,String user) async{
  if (comment.contains('None')) {
    _db
        .collection(bill)
        .doc(docdate)
        .collection("Work_done")
        .doc(FirebaseNames.work)
        .update({
      shWork: 1,
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
      shWork: 1,
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
}