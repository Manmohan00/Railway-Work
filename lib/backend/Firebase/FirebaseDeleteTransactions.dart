
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';

class FirebaseDeleteTransactions{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  void DeleteDoc(collection,docName){
    _db.collection(collection).doc(docName).collection(FirebaseNames.subcollection).doc(FirebaseNames.work).delete();
    _db.collection(collection).doc(docName).collection(FirebaseNames.subcollection).doc(FirebaseNames.Added).delete();
    _db.collection(collection).doc(docName).collection(FirebaseNames.subcollection).doc(FirebaseNames.comment).delete();
    _db.collection(collection).doc(docName).collection(FirebaseNames.subcollection).doc(FirebaseNames.nos).delete();
    _db.collection(collection).doc(docName).collection(FirebaseNames.subcollection).doc(FirebaseNames.road).delete();
    _db.collection(collection).doc(docName).delete();
}

  void DeleteCollection(collection){
    _db.collection(collection).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.collection(FirebaseNames.subcollection).doc(FirebaseNames.work).delete();
        ds.reference.collection(FirebaseNames.subcollection).doc(FirebaseNames.comment).delete();
        ds.reference.collection(FirebaseNames.subcollection).doc(FirebaseNames.Added).delete();
        ds.reference.collection(FirebaseNames.subcollection).doc(FirebaseNames.nos).delete();
        ds.reference.collection(FirebaseNames.subcollection).doc(FirebaseNames.road).delete();
        ds.reference.delete();
      }
      _db.collection('Railway').doc(collection).delete();
    });
  }
}
