
import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:schools_notifysystem/ui/list/student_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/ApiDataReceive.dart';
import '../../../Models/ApiDataSend.dart';
import '../../../Models/ApiSyncDataMaxIdRecieve.dart';
import '../../../Models/NotificationBadge/NoificationBadge.dart';
import '../../../Models/ReturnedApiLoginData.dart';
import '../../../Services/NotificationService.dart';
import '../../../Services/StudentsService.dart';
import '../../../Services/SyncService.dart';
import '../../../Util/Constants.dart';
import '../../../Util/NewsDataBaseHelper.dart';
import '../../../Util/NotificationSqlHelper.dart';
import '../../../Util/SQLHelper.dart';




class SyncScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SyncScreenState();
  }

}


class _SyncScreenState extends State<SyncScreen> {
  int customerId = 0;
  String token = "";
  String usermsg = "";


  final dbHelper = DatabaseHelper.instance;
  bool _isLoading=false;

  final Notification_dbHelpers = NotificationDatabaseHelper.instance;
  final News_dbHelpers = NewsDatabaseHelper.instance;

  String _isLogin = "false";

  List<ReturnedApiLoginData> data = [];
  List<NotificationDataReceive> _list = [];
  List<NotifyDataReceive> _Newslist = [];


  List<NotificationReceive> dataLists = [];
  List<NotificationReceive> News_dataLists = [];

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

    _query();
    isLogin();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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


  void _query() async {


    if (LoginType == 'puplic'){

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String usermsg = prefs.getString("usermsg") ?? "يرجى تسجيل الدخول";

      print("usermsg$usermsg");
      this.usermsg = usermsg;
    }


    setState(() {
      _isLoading = true;
    });

    final allRows = await dbHelper.queryAllRows();


    print('query all rows:');
    allRows.forEach(print);
    allRows.forEach((row) => data.add(ReturnedApiLoginData.fromJson(row)));

    int? id = await dbHelper.queryRowCount();
     int userId = id ?? 0;




    final SyncNotification_allRows = await Notification_dbHelpers.queryAllRows();
    print("SyncNotification_allRows");
    SyncNotification_allRows.forEach(print);
    SyncNotification_allRows.forEach((row) => dataLists.add(NotificationReceive.fromJson(row)));
    var max_id = 0;

    for (var item in dataLists) {

      print(item.id);


      if (item.id > max_id){
        max_id = item.id;
      }


    }

    print("max_id: $max_id");

    //
    // final SyncNews_allRows = await News_dbHelpers.queryAllRows();
    // print("News_dbHelpers_allRows");
    // SyncNews_allRows.forEach(print);
    // SyncNews_allRows.forEach((row) => News_dataLists.add(NotificationReceive.fromJson(row)));
    // var Nmax_id = 0;
    //
    // for (var item in News_dataLists) {
    //   print(item.id);
    //
    //
    //   if (item.id > Nmax_id){
    //     Nmax_id = item.id;
    //   }
    //
    // }
    //
    // print("Nmax_id: $Nmax_id");

    ApiDataSend obj = ApiDataSend(deviceOsTypeId: 1,
        customerId: data[userId - 1].customerId,
        token: data[userId - 1].token,maxId: max_id);


    // ApiDataSend obj1 = ApiDataSend(deviceOsTypeId: 1,
    //     customerId: data[userId - 1].customerId,
    //     token: data[userId - 1].token,maxId: Nmax_id);






/*
Notification
 */
     getSyncNotificationLists (obj).then((result) {

    print(result);

       setState(() {


         if (result != "[]") {
           List<NotificationDataReceive> result_list = [];
           String receivedJson = result;
           List<dynamic> list = json.decode(receivedJson);

           for (var item in list) {
             NotificationDataReceive fact = NotificationDataReceive.fromJson(
                 item);
             result_list.add(fact);

             Login_insertToDataBase(
                 fact.id,
                 fact.title,
                 fact.body,
                 fact.datets,
                 fact.timets
                 ,
                 fact.mainlabel,
                 fact.secondarylabel,
                 fact.urllink);
           }

           _list = result_list;
         }


         _isLoading = false;


       });

     });


    // getnewsLists (obj1).then((result) {
    //
    //   setState(() {
    //
    //     if (result != "[]") {
    //       List<NotifyDataReceive> result_list = [];
    //       String receivedJson = result;
    //       List<dynamic> list = json.decode(receivedJson);
    //
    //       for (var item in list) {
    //         NotifyDataReceive fact = NotifyDataReceive.fromJson(item);
    //         result_list.add(fact);
    //
    //         PuplicinsertToDataBase(
    //             fact.id,
    //             fact.title,
    //             fact.body,
    //             fact.datets,
    //             fact.timets
    //             ,
    //             fact.mainlabel,
    //             fact.secondarylabel,
    //             fact.urllink);
    //       }
    //
    //       _Newslist = result_list;
    //     }
    //     _isLoading = false;
    //
    //
    //   });
    // });



  }



  isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString("isLogin") ?? "false";
    setState(() {
      _isLogin = isLogin;
    });

    print(_isLogin);
  }



  PuplicinsertToDataBase(int id, String title, String body, String datets, String timets
      , String? mainlabel, String? secondarylabel, String? urllink) async {

    // row to insert
    Map<String, dynamic> row = {
      NotificationDatabaseHelper.id : id,
      NotificationDatabaseHelper.title  : title,
      NotificationDatabaseHelper.body  : body,
      NotificationDatabaseHelper.datets  : datets,
      NotificationDatabaseHelper.timets  : timets,
      NotificationDatabaseHelper.mainlabel  : mainlabel,
      NotificationDatabaseHelper.secondarylabel  : secondarylabel,
      NotificationDatabaseHelper.urllink  : urllink,

    };

      final _id = await News_dbHelpers.insert(row);
      print('puplic : inserted row id: $_id');



  }


  Login_insertToDataBase(int id, String title, String body, String datets, String timets
      , String mainlabel, String? secondarylabel, String? urllink) async {

    // row to insert
    Map<String, dynamic> row = {
      NotificationDatabaseHelper.id : id,
      NotificationDatabaseHelper.title  : title,
      NotificationDatabaseHelper.body  : body,
      NotificationDatabaseHelper.datets  : datets,
      NotificationDatabaseHelper.timets  : timets,
      NotificationDatabaseHelper.mainlabel  : mainlabel,
      NotificationDatabaseHelper.secondarylabel  : secondarylabel,
      NotificationDatabaseHelper.urllink  : urllink,

    };

    final _id = await Notification_dbHelpers.insert(row);
    print('Login : inserted row id: $_id');



  }



  @override
  Widget build(BuildContext context) {




    if (_isLogin == "false" ){

      return Scaffold(

          body:

          Column(

              children:<Widget>[

                Stack(


                  clipBehavior: Clip.antiAliasWithSaveLayer,

                  children: <Widget>[

                    CustomAppBar(),
                    Positioned(
                      top: 90,
                      child: Column(

                          children: <Widget>[
                            Container(
                                height: MediaQuery.of(context).size.height ,
                                width: MediaQuery.of(context).size.width,
                                // ignore: prefer_const_constructors
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,

                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
                                ),


                                child:

                                Padding(
                                  padding: EdgeInsets.only(top: 50,bottom: 15),
                                  child: Column(

                                    children: <Widget>[

                                      Center(
                                          child: Image.asset(
                                            'images/Error.png',


                                          )),


                                      Text(
                                        this.usermsg,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Color(0xFF686868),
                                            fontFamily: "Al-Jazeera-Arabic-Bold"),
                                      ),

                                    ],
                                  ),
                                )


                            )

                          ]
                      ),
                    ),


                  ],


                ),
                //CustomeHomeContainer()

              ]
          )
      );

    }

    else{
      return Scaffold(

          body:

          Column(

              children:<Widget>[

                Stack(


                  clipBehavior: Clip.antiAliasWithSaveLayer,

                  children: <Widget>[

                    CustomAppBar(),


                    Positioned(
                      top: 90,
                      child: Column(

                          children: <Widget>[
                            Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                // ignore: prefer_const_constructors
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,

                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
                                ),


                                child:

                                    Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: Column(
                                        children: [

                                          Center(
                                            child:  Text(
                                              "سيتم مزامنة وتحميل الاشعارات والاخبار",
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Color(0xFF686868),
                                                  fontFamily: "Al-Jazeera-Arabic-Regular"),
                                            ),
                                          )

                                          ,
                                          _isLoading == false ? Padding(
                                            padding: EdgeInsets.only(top: 50,bottom: 15),
                                            child: Column(

                                              children: <Widget>[

                                                Center(
                                                    child: Image.asset(
                                                      'images/Error.png',


                                                    )),


                                                Text(
                                                  "تمت المزامنة بنجاح",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color(0xFF686868),
                                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                                ),

                                              ],
                                            ),
                                          ): Center(child: CircularProgressIndicator()),
                                        ],
                                      ),
                                    )






                            )





                          ]
                      ),
                    )













                  ],


                ),
                //CustomeHomeContainer()

              ]
          )
      );
    }



  }



  // ignore: non_constant_identifier_names


  // ignore: non_constant_identifier_names


  Widget CustomAppBar(){
    return
      Container(


        color: Color(0xFF44A2A9),
        height:  MediaQuery.of(context).size.height - 118 ,
        width: MediaQuery.of(context).size.width,
        child: ListView(

          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Container(
                    width: 100.0,

                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        'المزامنة',
                        style: TextStyle(
                            color: Color(0xFFF9F9F9),
                            fontSize: 20,
                            fontFamily: "Al-Jazeera-Arabic-Bold"
                        )),
                  ),

                ],
              ),
            ),



          ],
        ),
      );

  }








}