import 'package:flutter/material.dart';
import 'package:flutter_login_app/main.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  var sharedPrefSuccessPageUserName; // This var is , wanted to show this page Text in Scaffold.
  var sharedPrefSuccessPageUserPassword; // This var is , wanted to show this page Text in Scaffold.

  Future<void> userSuccessLoginAfterOnScreen() async {
    var sharedPrefSuccessPage = await SharedPreferences.getInstance();

    setState(() {
      sharedPrefSuccessPageUserName =
          sharedPrefSuccessPage.getString('tfUserName') ??
              'UserName is not defined';
      sharedPrefSuccessPageUserPassword =
          sharedPrefSuccessPage.getString('tfUserPassword') ??
              'UserPassword is not defined';
    });
  } // SharePref UserName and UserPassword has come from main page with userTextController ( via SharePref)

  Future<void> exitAppButtonMethod() async {
    var sharedPrefSuccessPage = await SharedPreferences.getInstance();

    sharedPrefSuccessPage.remove('tfUserName');
    sharedPrefSuccessPage.remove(
        'tfUserPassword'); //OnAPPBAR Exit Button Function go Back MainPage with RemoveUserData

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  }

  @override
  void initState() {
    super.initState(); //Opening Page Method here
    userSuccessLoginAfterOnScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                exitAppButtonMethod();
              },
              icon: Icon(Icons.exit_to_app))
        ],
        centerTitle: true,
        title: Text('Login Application Success Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'UserName : $sharedPrefSuccessPageUserName'), //Show Infos , which info do you want
            Text(
                'UserName : $sharedPrefSuccessPageUserPassword'), //Show Infos , which info do you want
          ],
        ),
      ),
    );
    ;
  }
}
