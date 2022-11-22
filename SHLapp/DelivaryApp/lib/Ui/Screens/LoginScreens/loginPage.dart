import 'package:flutter/material.dart';

import '../../../../Widgets/loginViewWidget.dart';

import 'dart:async';
import 'package:flutter/cupertino.dart';






class loginPage extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  loginScreen(),
    );
  }
}


class loginScreen extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _loginScreen();
  }

}

class _loginScreen extends State<loginScreen> {

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  TextEditingController userName = TextEditingController();




  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,



      body:

      Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          // background image and bottom contents
          Column(

            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height/2 ,

                  width: double.infinity,
                  color: Color(0xFF44A2A9),
                  child: Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Container(

                          height: 100,
                          width: 100,

                          child: CircleAvatar(

                            backgroundImage: AssetImage('images/logo192.png'),
                            maxRadius: 15,
                            minRadius: 15,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(  "السنديان للنقل والتوصيل" ,style: TextStyle(

                            fontSize: 24.0,color: Color(0xFFF1F1F1),fontFamily: "Al-Jazeera-Arabic-Bold")
                        ),
                      ],
                    ),
                  )
              ),



            ],
          ),
          // Profile image
          loginView_Widget()


        ],
      ),







    );
  }





}