import 'package:flutter/material.dart';

import '../../../Widgets/loginViewWidget.dart';


import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';





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


  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void initState() {
    getConnectivity();
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

                      height: 90,
                      width: 90,

                      child: CircleAvatar(

                        backgroundImage: AssetImage('images/ll.jpg'),
                        maxRadius: 15,
                        minRadius: 15,
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(  "روضة ومدرسة فلسطين" ,style: TextStyle(

                        fontSize: 27.0,color: Color(0xFFF1F1F1),fontFamily: "Al-Jazeera-Arabic-Bold")
                    ),
                  ],
                ),
              )
            ),


              // Expanded(
              //   child:  Container(
              //             height: MediaQuery.of(context).size.height/2,
              //             width: double.infinity,
              //             color: Colors.white,
              //
              //
              //     child: Padding(
              //       padding: EdgeInsets.only(right: 4,left: 4,top: 55),
              //
              //       child: Align(
              //         alignment: FractionalOffset.center,
              //
              //         child: Container(
              //           width:  MediaQuery.of(context).size.width -  15,
              //
              //
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             children: [
              //
              //                  Text(
              //                   'يجب زيارة المدرسة للحصول على اسم  المستخدم وكلمة المرور',
              //
              //                   style: TextStyle(fontSize: 12,color: Color(0xFF707070),fontFamily: "Al-Jazeera-Arabic-bold"),
              //                 ),
              //
              //
              //               Image.asset('images/info.png' ,
              //                 width: 30,height: 30,),
              //
              //
              //             ],
              //
              //
              //           ),
              //
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(25),
              //             color: Colors.white,
              //             border: Border.all(
              //               color: Color(0xFFC3D5D6), //                   <--- border color
              //               width: 0.5,
              //             ),
              //           ),
              //           height: 50,
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
          // Profile image
          loginView_Widget()


        ],
      ),







    );
  }



  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );

  }