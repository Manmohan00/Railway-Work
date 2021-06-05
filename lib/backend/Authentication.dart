
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
 import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future signInwithGoogle() async{
   final googleUser = await googleSignIn.signIn();
   if(googleUser != null) {
     final googleAuth = await googleUser.authentication;
     if (googleAuth.idToken != null) {
       final userCredential = await _firebaseAuth.signInWithCredential(
           GoogleAuthProvider.credential(
               idToken: googleAuth.idToken,
               accessToken: googleAuth.accessToken)
       );
       return userCredential.user;
     }
     else {
       throw FirebaseAuthException(
         message: "Sign in Aborded",
         code: "ERROR_ABORDEDD_BY_USER",
       );
     }
   }
  }

  Future<void> signOut() async{
   await _firebaseAuth.signOut();
   await googleSignIn.signOut();
  }
 }