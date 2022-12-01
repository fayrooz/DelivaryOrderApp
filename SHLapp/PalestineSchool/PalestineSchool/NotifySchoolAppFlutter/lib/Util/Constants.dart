
import 'package:flutter/material.dart';

String BaseURL = "http://palestineapi.o1solutions.com";
String ErrorMsg = "";
 String LoginType = 'puplic';
class CustomColors {
  static const Color backgroundColor = Color(0xFF44A2A9);
  static var index = 0;

}

class ChattingGroup {

  static int groupid = 1;
  static int pageNumber = 1;

}

class SendMessageChatting{


  static int groupid = 1;
  static bool isAdmisender = false;
  static String adminSenderName = "";
 static String msgText = "";


}

class Chatting {
  static int customerId = 1;
  static String studentName = "";

}


class LatestChattingReturnConst {

  static int groupid = 1;
  static int pageNumber = 1;

}

showAlertDialog(BuildContext context , String title , String content) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("موافق"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

sAlertDialog(BuildContext context , String title , String content) {



  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(child: Text(title,style: TextStyle(
        color: Colors.black,
        fontFamily: "Al-Jazeera-Arabic-Bold",
        fontSize: 15),)),
    content: Text(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      content, style: TextStyle(

        color: Colors.black,
        fontFamily: "Al-Jazeera-Arabic-Regular",
        fontSize: 16),),
    actions: [

    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}