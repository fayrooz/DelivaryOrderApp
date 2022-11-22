import 'dart:async';

import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Ui/Screens/LoginScreens/loginPage.dart';
import 'Widgets/backgroundWidget.dart';

import 'package:shared_preferences/shared_preferences.dart';


void main() { WidgetsFlutterBinding.ensureInitialized();

runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // This widget is the root of your application.

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) =>  SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.

      },


      //home: Inform_List(),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState


    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {



  late SharedPreferences prefs;





  @override
  void initState() {
    super.initState();
    //getSharedPreferences ();


  }

  getSharedPreferences () async
  {
    prefs = await SharedPreferences.getInstance();
  }
  saveStringValue (String token) async
  {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("FCMtoken", token);
  }

  @override
  Widget build(BuildContext context) {


    Timer(
        const Duration(seconds: 4),
            () async =>{



          movenext()
        }

    );

    // TODO: implement build
    return Scaffold(




        body: Stack(
          children: <Widget>[
            background_Widget(),
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child:
                  Container(

                    height: 110,
                    width: 110,

                    child: CircleAvatar(

                      backgroundImage: AssetImage('images/logo192.png'),
                      maxRadius: 15,
                      minRadius: 15,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "السنديان للنقل والتوصيل",
                  style: TextStyle(
                      fontSize: 23.0,
                      color: Color(0xFFF1F1F1),
                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                ),

              ],
            )
          ],
        ));
  }

  movenext() async {





    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString("isLogin") ?? "false";
    String isLogin_p = prefs.getString("isLogin_p") ?? "false";

    prefs.setString("isnotifi", "false");


    if (isLogin == "false" && isLogin_p == "false"){

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => loginPage()));
    }else {
      SharedPreferences prefs = await SharedPreferences.getInstance();



    }






  }









}
