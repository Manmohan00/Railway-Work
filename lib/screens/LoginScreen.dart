import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railway_work_tracking/backend/Authentication.dart';
import 'package:railway_work_tracking/backend/Provider/UserData.dart';
import 'package:railway_work_tracking/screens/HomeScreen.dart';
import 'package:railway_work_tracking/screens/UI/UiFunctions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'loginscreen';

  @override
  Widget build(BuildContext context) {
    var setuserdata = Provider.of<UserData>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 100 * 70,
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/railway-work-tracking.appspot.com/o/CodeImages%2FLoginpage.jpg?alt=media&token=bcc1452c-1e3d-4cd6-a71b-cdc659e7b6d2",
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var checkConnection =
                  await (Connectivity().checkConnectivity());
                  if (checkConnection == ConnectivityResult.none) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBarInternetError);
                  } else {
                    bool user = await signInwithGoogle();
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    setuserdata.setUserName = pref.getString("UserName");
                    setuserdata.setUserEmail = pref.getString("Email");
                    user
                        ? Navigator.pushReplacementNamed(context, HomeScreen.id)
                        : ScaffoldMessenger.of(context)
                        .showSnackBar(snackBarloginError);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 100 * 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 100 * 10,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 100 * 5,
                        child: Image.network(
                          "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.sF_2Hibi-8w-KejTSslPfgHaFb%26pid%3DApi&f=1",
                        ),
                      ),
                      TextBoxforAll("Login with Google", 3.0, 14, TextAlign.center),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future signInwithGoogle() async {
    User user = await Authentication().signInwithGoogle();
    setloginStatustrue(user.displayName, user.email);
    return true;
  }


  // ignore: non_constant_identifier_names
  setloginStatustrue(Username, email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("logInStatus", true);
    pref.setString("UserName", Username);
    pref.setString("Email", email);
  }


final snackBarloginError = SnackBar(
  content: Text(
    "Cannot Login to Google",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    ),
  ),
);
