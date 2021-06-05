import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';
import 'BillNameModel.dart';
import 'WorkDataModel.dart';

class FirebaseStreams {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<BillNameModel>> GetBillName() {
    return _db
        .collection('Railway')
        .where("Bill", isEqualTo: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) => BillNameModel.toJson(
                documentSnapshot.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<WorkData>> getWorkDate(bill) {
    return _db
        .collection(bill)
        .orderBy('Time',descending: false)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) => WorkData.toJson(
                documentSnapshot.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<WorkQuantity> getWorkQuantity(bill, docDate) {
    return _db
        .collection(bill)
        .doc(docDate).collection('Work_done').doc(FirebaseNames.nos)
        .snapshots().map((DocumentSnapshot documentSnapshot) =>
        WorkQuantity.toJson(documentSnapshot.data() as Map<String, dynamic>));
  }

  Stream<WorkAddedbyUser> getWorkUser(bill, docDate) {
    return _db
        .collection(bill)
        .doc(docDate).collection('Work_done').doc(FirebaseNames.Added)
        .snapshots().map((DocumentSnapshot documentSnapshot) =>
        WorkAddedbyUser.toJson(documentSnapshot.data() as Map<String, dynamic>));
  }

  Stream<WorkComment> getWorkComment(bill, docDate) {
    return _db
        .collection(bill)
        .doc(docDate).collection('Work_done').doc(FirebaseNames.comment)
        .snapshots().map((DocumentSnapshot documentSnapshot) =>
        WorkComment.toJson(documentSnapshot.data() as Map<String, dynamic>));
  }

  Stream<WorkRoadorLoop> getWorkRoad(bill, docDate) {
    return _db
        .collection(bill)
        .doc(docDate).collection('Work_done').doc(FirebaseNames.road)
        .snapshots().map((DocumentSnapshot documentSnapshot) =>
        WorkRoadorLoop.toJson(documentSnapshot.data() as Map<String, dynamic>));
  }

}
