import 'package:flutter/material.dart';
import 'package:flutter_login_app/successPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkSuccessLogin() async {
    // After logging in, after reopening the application, our method of storing data
    var sharedPrefSuccessPage = await SharedPreferences.getInstance();

    var sharedPrefSuccessPageUserName = sharedPrefSuccessPage.getString(
            'tfUserName') ?? //If the username contains data, the code before the question mark '?'?' works, if the username does not contain any data, the code after ':' workk
        'UserName is not defined';
    var sharedPrefSuccessPageUserPassword = sharedPrefSuccessPage.getString(
            'tfUserPassword') ?? //If the userpassword contains data, the code before the question mark '?'?' works, if the username does not contain any data, the code after ':' work
        'UserPassword is not defined';

    if (sharedPrefSuccessPageUserName == 'Samet' &&
        sharedPrefSuccessPageUserPassword == '745523') {
      //user login informations
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: checkSuccessLogin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var letPass = snapshot.data;
            if (letPass != null) {
              // this is the null check of letPass ( LetPass is snapshot's data.)
              return letPass
                  ? SuccessPage()
                  : MyHomePage(); // if else short condt.
            } else {
              return Text('Login Error');
            }
          } else {
            return SizedBox
                .shrink(); // more than performance about Container ()
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tfUserName = TextEditingController(); //TextField UserName
  var tfUserPassword = TextEditingController(); //TextField UserPassword

  Future<void> userSuccessLogin() async {
    var sharedPrefLoginPageUserName = tfUserName.text; //SharePref UserName
    var sharedPrefLoginPageUserPassword =
        tfUserPassword.text; //SharedPref UserPass

    if (sharedPrefLoginPageUserName == 'Samet' &&
        sharedPrefLoginPageUserPassword == '745523') {
      var sharedPrefLoginPage = await SharedPreferences.getInstance();
      var sharedPrefLoginPageUserName = sharedPrefLoginPage.setString(
          'tfUserName', 'Samet'); //SharePref SetUserName with key'tfUserName'
      var sharedPrefLoginPageUserPassword = sharedPrefLoginPage.setString(
          'tfUserPassword',
          '745523'); //SharePre SetUserPass with key'tfUserPassword'

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SuccessPage(), //Go Successfull Login Page with replacement
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Login Error'))); // if the login error , want to show a SnackBar 'LOGIN ERROR'
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login Application First Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: tfUserName,
              decoration: InputDecoration(hintText: 'UserName'),
            ),
            TextField(
              obscureText: true,
              controller: tfUserPassword,
              decoration: InputDecoration(hintText: 'UserPassword'),
            ),
            ElevatedButton(
                onPressed: () {
                  userSuccessLogin();
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
