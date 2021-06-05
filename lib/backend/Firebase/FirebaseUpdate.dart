

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';

class FirebaseUpdate {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> Updatedata(billName, workName, date, user, comment,
      quantity, road) async {
    print("$date");
    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.nos).update({
      '$workName-Nos': quantity
    });

    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.comment).update({
      '$workName-CMT': comment,
    });

    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.road).update({
      '${workName}_Road': '$road'
    });


    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.Added).update({
      '${workName}_Added': '$user.edited'
    });

    return true;
  }


  Future<bool> Removedata(billName, workName, date) async {
    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.nos).update({
      '$workName-Nos': '0'
    });

    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.comment).update({
      '$workName-CMT': FieldValue.delete()
    });

    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.Added).update({
      '${workName}_Added': FieldValue.delete()
    });

    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.road).update({
      '${workName}_Road': FieldValue.delete()
    });

    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.work).update({
      '$workName': false
    });

    return true;
  }

  Future<bool> UpdatedataNocomment(billName, workName, date, user, comment,
      quantity, road) async {
    print("$date");
    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.nos).update({
      '$workName-Nos': quantity
    });

    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.comment).set({
      '$workName-CMT': comment
    });

    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.road).update({
      '${workName}_Road': '$road'
    });

    _db.collection(billName).doc(date).collection('Work_done')
        .doc(FirebaseNames.Added).update({
      '${workName}_Added': '$user.edited'
    });

    return true;
  }
}