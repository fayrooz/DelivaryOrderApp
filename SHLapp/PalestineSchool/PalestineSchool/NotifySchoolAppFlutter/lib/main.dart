
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:schools_notifysystem/Util/NewsDataBaseHelper.dart';
import 'package:schools_notifysystem/ui/Screens/LoginUserScreen/SearchScreen.dart';
import 'package:schools_notifysystem/ui/Screens/Main/HomeScreen.dart';
import 'package:schools_notifysystem/ui/Screens/Main/loginScreen.dart';

import 'Models/ApiDataSend.dart';
import 'Models/ApiSyncDataMaxIdRecieve.dart';
import 'Models/ChattingGroupReturn.dart';
import 'Models/ReturnedApiLoginData.dart';
import 'Services/chattingGroupService.dart';
import 'Util/ChattingGroupDbHelper.dart';
import 'Util/Constants.dart';
import 'Util/NotificationService.dart';
import 'Util/NotificationSqlHelper.dart';
import 'Util/SQLHelper.dart';
import 'Widgets/backgroundWidget.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

void main() { WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessaging);
  runApp(MyApp());
}

Future<void> _firebaseMessaging(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // This widget is the root of your application.

    return MaterialApp(
      navigatorKey:navigatorKey,
      debugShowCheckedModeBanner: false,

      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) =>  SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/HomeScreen(0)': (context) =>  HomeScreen(0),

        '/HomeScreen(5)': (context) =>  HomeScreen(5),
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


  late final FirebaseMessaging _messaging;
  late SharedPreferences prefs;

  final Notification_dbHelpers = NotificationDatabaseHelper.instance;
  final News_dbHelpers = NewsDatabaseHelper.instance;


  final ChattingGroup_dbHelpers = ChattingGroupHelper.instance;


  late FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  List<ReturnedApiLoginData> data = [];
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();



    getSharedPreferences ();
    registerNotification();
    NotificationService().init();

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

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

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

                height: 90,
                width: 90,

                child: CircleAvatar(

                  backgroundImage: AssetImage('images/ll.jpg'),
                  maxRadius: 15,
                  minRadius: 15,
                ),
              ),
            ),

            Text(
              "روضة ومدرسة فلسطين",
              style: TextStyle(
                  fontSize: 27.0,
                  color: Color(0xFFF1F1F1),
                  fontFamily: "Al-Jazeera-Arabic-Bold"),
            ),
            Text(
              "تطبيق الاشعارات الالكتروني",
              style: TextStyle(
                  fontSize: 20.0,
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
        String type = prefs.getString("type") ?? "notification";
        print("type: $type");




        if (type == "msg"){
          navigatorKey.currentState?.pushNamed('/HomeScreen(5)');
          prefs.setString("type", "notification");

          //Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(5)));
        }else{
          navigatorKey.currentState?.pushNamed('/HomeScreen(0)');
         // Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(0)));
        }


      }






  }




  void registerNotification() async {


  


    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;



    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    _messaging.getToken().then((token){

      print('token: $token');
      saveStringValue (token.toString());
    //  _AddToken(token!);
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);




    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');



      FirebaseMessaging.instance.getInitialMessage().then((message) async {
        print("getInitialMessage");


        if (message != null) {
          if (message?.data['nid'] != null) {
            var datets = "";
            var secondarylabel = "";
            var mainlabel = "";
            var urllink = "";
            var timets = "";

            if (message?.data['datets'] != null) {
              datets = message?.data['datets'];
            }
            if (message?.data['secondarylabel'] != null) {
              secondarylabel = message?.data['secondarylabel'];
            }
            if (message?.data['mainlabel'] != null) {
              mainlabel = message?.data['mainlabel'];
            }
            if (message?.data['urllink'] != null) {
              urllink = message?.data['urllink'];
            }
            if (message?.data['timets'] != null) {
              timets = message?.data['timets'];
            }


            // row to insert
            Map<String, dynamic> row = {
              NotificationDatabaseHelper.id: message?.data['nid'],
              NotificationDatabaseHelper.title: message?.notification?.title,
              NotificationDatabaseHelper.body: message?.notification?.body,
              NotificationDatabaseHelper.datets: datets,
              NotificationDatabaseHelper.timets: timets,
              NotificationDatabaseHelper.mainlabel: mainlabel,
              NotificationDatabaseHelper.secondarylabel: secondarylabel,
              NotificationDatabaseHelper.urllink: urllink,
              NotificationDatabaseHelper.isSeen: "false"
            };


            SharedPreferences prefs = await SharedPreferences.getInstance();
            String isLogin = prefs.getString("isLogin") ?? "false";


            if (isLogin == 'false' && message?.data['type'] != "msg") {
              final id = await News_dbHelpers.insert(row);
              print('puplic : inserted row id: $id');
            } else if (isLogin == 'true' && message?.data['type'] != "msg") {
              final id = await Notification_dbHelpers.insert(row);
              print(' login : inserted row id: $id');
            }


            if (message?.data['type'] == "msg") {
              Chatting.customerId = int.parse(message?.data['cid']);
              ChattingGroup.groupid = int.parse(message?.data['gid']);
              Chatting.studentName = secondarylabel;


              navigatorKey.currentState?.pushNamed('/HomeScreen(5)');
              prefs.setString("type", "notification");
            //  Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(5)));
            } else {
              navigatorKey.currentState?.pushNamed('/HomeScreen(0)');
             // Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(0)));
            }
          }


        }


      });


      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

        print("FCMMessage");
        print(message.notification?.title);
        print(message.notification?.body);
        print(message.data);



        final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

        final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );

        final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);


        NotificationApi._notifications.initialize(initializationSettings,
            onSelectNotification: selectNotification );

        NotificationApi.showNotification(
            title: message.notification?.title, body: message.notification?.body, payload: 'notification');

        var datets = "";
        var secondarylabel = "";
        var mainlabel = "";
        var urllink = "";
        var timets = "";

        if (message.data['datets'] != null  ){
          datets = message.data['datets'];
        }
        if (message.data['secondarylabel'] != null  ){
          secondarylabel = message.data['secondarylabel'];
        }
        if (message.data['mainlabel'] != null  ){
          mainlabel = message.data['mainlabel'];
        }
        if (message.data['urllink'] != null  ){
          urllink = message.data['urllink'];
        }
        if (message.data['timets'] != null  ){
          timets = message.data['timets'];
        }



        // row to insert
        Map<String, dynamic> row = {
          NotificationDatabaseHelper.id : message.data['nid'],
          NotificationDatabaseHelper.title  : message.notification?.title,
          NotificationDatabaseHelper.body  : message.notification?.body,
          NotificationDatabaseHelper.datets  : datets,
          NotificationDatabaseHelper.timets  : timets,
          NotificationDatabaseHelper.mainlabel  : mainlabel,
          NotificationDatabaseHelper.secondarylabel  : secondarylabel,
          NotificationDatabaseHelper.urllink  : urllink,
          NotificationDatabaseHelper.isSeen  : "false"

        };

        String customerId = message.data['cid'] ?? "1" ;
        String groupid = message.data['gid']  ?? "1" ;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String isLogin = prefs.getString("isLogin") ?? "false";
        prefs.setString("type",message.data['type']) ;
        prefs.setString("cid",customerId) ;
        prefs.setString("groupid",groupid) ;

        prefs.setString("studentName",secondarylabel) ;



        if (isLogin == 'false'&& message.data['type'] != "msg"){

          final id = await News_dbHelpers.insert(row);
          print('puplic : inserted row id: $id');


        }else if (isLogin == 'true'&& message.data['type'] != "msg"){
          final id = await Notification_dbHelpers.insert(row);
          print(' login : inserted row id: $id');

        }
       }

      );

  // For handling the received notifications(background)
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {




        print("FCMMessage2");
        print(message.notification?.title);
        print(message.notification?.body);
        print(message.data);

        // final AndroidInitializationSettings initializationSettingsAndroid =
        // AndroidInitializationSettings('@mipmap/ic_launcher');
        //
        // final IOSInitializationSettings initializationSettingsIOS =
        // IOSInitializationSettings(
        //   requestSoundPermission: false,
        //   requestBadgePermission: false,
        //   requestAlertPermission: false,
        // );
        //
        // final InitializationSettings initializationSettings =
        // InitializationSettings(
        //     android: initializationSettingsAndroid,
        //     iOS: initializationSettingsIOS,
        //     macOS: null);

        var datets = "";
        var secondarylabel = "";
        var mainlabel = "";
        var urllink = "";
        var timets = "";

        if (message.data['datets'] != null  ){
          datets = message.data['datets'];
        }
        if (message.data['secondarylabel'] != null  ){
          secondarylabel = message.data['secondarylabel'];
        }
        if (message.data['mainlabel'] != null  ){
          mainlabel = message.data['mainlabel'];
        }
        if (message.data['urllink'] != null  ){
          urllink = message.data['urllink'];
        }
        if (message.data['timets'] != null  ){
          timets = message.data['timets'];
        }





        // row to insert
        Map<String, dynamic> row = {
          NotificationDatabaseHelper.id : message.data['nid'],
          NotificationDatabaseHelper.title  : message.notification?.title,
          NotificationDatabaseHelper.body  : message.notification?.body,
          NotificationDatabaseHelper.datets  :datets,
          NotificationDatabaseHelper.timets  : timets,
          NotificationDatabaseHelper.mainlabel  : mainlabel,
          NotificationDatabaseHelper.secondarylabel  : secondarylabel,
          NotificationDatabaseHelper.urllink  : urllink,
          NotificationDatabaseHelper.isSeen  : "false"

        };


        SharedPreferences prefs = await SharedPreferences.getInstance();
        String isLogin = prefs.getString("isLogin") ?? "false";




        if (isLogin == 'false' && message.data['type'] != "msg"){

          final id = await News_dbHelpers.insert(row);
          print('puplic : inserted row id: $id');

        }else if (isLogin == 'true' && message.data['type'] != "msg"){
          final id = await Notification_dbHelpers.insert(row);
          print(' login : inserted row id: $id');

        }



        if (message.data['type'] == "msg"){
           Chatting.customerId = int.parse(message?.data['cid']);
           ChattingGroup.groupid = int.parse( message?.data['gid']);

           Chatting.studentName = secondarylabel;

           navigatorKey.currentState?.pushNamed('/HomeScreen(5)');
           prefs.setString("type","notification") ;
        //  Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(5)));
        }else{

         navigatorKey.currentState?.pushNamed('/HomeScreen(0)');
        //  Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(0)));
        }





      });


    } else {
      print('User declined or has not accepted permission');
    }
  }

  ///Receive message when app is in background solution for on message




  Future<void>  selectNotification(String? x) async {

    print("test hear");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("isnotifi", "true");


    String type = prefs.getString("type") ?? "notification";
    String customerId = prefs.getString("cid") ?? "1";
    String groupid = prefs.getString("groupid") ?? "1";
    String studentName =  prefs.getString("studentName") ?? "" ;

    if (type == "msg"){

       Chatting.customerId = int.parse(customerId);
       ChattingGroup.groupid = int.parse(groupid);

       Chatting.studentName = studentName;
       navigatorKey.currentState?.pushNamed('/HomeScreen(5)');
       prefs.setString("type", "notification");

       // Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(5)));

    }

    else{
      print("rrrr");

   //navigatorKey.currentState?.pushNamed('/HomeScreen', arguments: 0);

      navigatorKey.currentState?.pushNamed('/HomeScreen(0)');
   // Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(0)));


    }




    // setState(() {
    //
    //
    // });

      // setState(() {
      //
      //   print("yreeee");
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
      //
      // });



  }


}

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        channelShowBadge: true,

        icon: '@mipmap/ic_launcher',


        //<-- Add this parameter
      ),
      //iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
}
