// ignore: duplicate_ignore
// ignore: file_names

// ignore_for_file: file_names, unnecessary_new

import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:schools_notifysystem/Util/NewsDataBaseHelper.dart';

import '../../../Models/ApiDataSend.dart';
import '../../../Models/ApiSyncDataMaxIdRecieve.dart';
import '../../../Models/NotificationBadge/NoificationBadge.dart';
import '../../../Models/ReturnedApiLoginData.dart';
import '../../../Services/NotificationService.dart';
import '../../../Util/Constants.dart';
import '../../../Util/NotificationSqlHelper.dart';
import '../../../Util/SQLHelper.dart';
import '../../../Widgets/SideMenu.dart';
import '../../list/inform_list.dart';
import '../../list/notification_list.dart';



class NewsScreen extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsScreenState();
  }

}


class _NewsScreenState extends State<NewsScreen> {


 // List<NotifyDataReceive> _list = [];
 // final dbHelper = DatabaseHelper.instance;
 // List<ReturnedApiLoginData> data = [];
 // List<Map<String, dynamic>> _journals = [];

  List<NotificationReceive> dataLists = [];


  final dbHelper = NewsDatabaseHelper.instance;

  int count = 0;

  Future<void> _query()  async {

    dataLists = [];
    final allRows = await dbHelper.ORDER_queryAllRows();
     print('query all rows:');
     allRows.forEach(print);

     allRows.forEach((row) => dataLists.add(NotificationReceive.fromJson(row)));

    for (var item in dataLists) {
      print(item.date_ts);
    }

    if (!mounted) {
      return;
    }
    setState(() {

      for (var item in dataLists) {

        if (item.isSeen == "false"){
          count = count + 1;
        }

        // row to insert
        Map<String, dynamic> row = {
          NotificationDatabaseHelper.id : item.id,
          NotificationDatabaseHelper.title  : item.title,
          NotificationDatabaseHelper.body  : item.body,
          NotificationDatabaseHelper.datets  : item.date_ts,
          NotificationDatabaseHelper.timets  : item.time_ts,
          NotificationDatabaseHelper.mainlabel  : item.main_label,
          NotificationDatabaseHelper.secondarylabel  : item.secondary_label,
          NotificationDatabaseHelper.urllink  : item.url_link,
          NotificationDatabaseHelper.isSeen  : "true"

        };

        dbHelper.update(row);

      }



     Notification_List.dataList = dataLists.toList();
    });


  }


  @override
  void initState() {
    super.initState();
   _query();

  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
 // _query();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: ListView(

        children: <Widget>[
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 7),
            child: Container(
              width: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    child: Stack(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Color(0xffF9F9F9),
                          size: 40,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 5),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffF9F9F9),
                                border: Border.all(color: Color(0xFF44A2A9), width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Center(
                                child: Text(
                                  count.toString(),
                                  style: TextStyle(fontSize: 10,fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                'الاخبار',
                style: TextStyle(
                    color: Color(0xFFF9F9F9),
                    fontSize: 20,
                    fontFamily: "Al-Jazeera-Arabic-Bold"
                )),
          ),
        ],
      ),
          SizedBox(height: 8.0,),


          Container(
            height: MediaQuery
                .of(context)
                .size
                .height ,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
            ),


            child: dataLists.length > 0 ?
            Notification_List() :
            Padding(
              padding: EdgeInsets.only(top: 50,bottom: 15),
              child: Column(

                children: <Widget>[

                  Center(
                      child: Image.asset(
                        'images/Error.png',


                      )),


                  Text(
                    "لا تتوفر بيانات حاليا",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF686868),
                        fontFamily: "Al-Jazeera-Arabic-Bold"),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }








  //
  //
  // Widget CustomAppBar(){
  //   return
  //     Container(
  //
  //
  //       color: Color(0xFF44A2A9),
  //       height:  MediaQuery.of(context).size.height  ,
  //       width: MediaQuery.of(context).size.width,
  //       child: ListView(
  //
  //         children: <Widget>[
  //           Padding(
  //             padding: EdgeInsets.only(top: 5.0, left: 5.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //
  //                 Container(
  //                   width: 100.0,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: <Widget>[
  //                       Image.asset('images/Bell.png',width: 50,height: 50,)
  //                     ],
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(10),
  //                   child: Text(
  //                       'الاخبار',
  //                       style: TextStyle(
  //                           color: Color(0xFFF9F9F9),
  //                           fontSize: 20,
  //                           fontFamily: "Al-Jazeera-Arabic-Bold"
  //                       )),
  //                 ),
  //
  //               ],
  //             ),
  //           ),
  //
  //
  //
  //         ],
  //       ),
  //     );
  //
  // }
  // Widget CustomCurveContainer(){
  //
  //   return Positioned(
  //     top: 90,
  //
  //     child: Column(
  //
  //         children: <Widget>[
  //           Container(
  //               height: MediaQuery.of(context).size.height ,
  //               width: MediaQuery.of(context).size.width,
  //               // ignore: prefer_const_constructors
  //               decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.5),
  //                       spreadRadius: 5,
  //                       blurRadius: 7,
  //                       offset: Offset(0, 3), // changes position of shadow
  //                     ),
  //                   ],
  //                   color: Colors.white,
  //
  //                   borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
  //               ),
  //
  //
  //               child:   dataLists.length > 0 ?
  //               Notification_List() :
  //               Padding(
  //                 padding: EdgeInsets.only(top: 50,bottom: 15),
  //                 child: Column(
  //
  //                   children: <Widget>[
  //
  //                     Center(
  //                         child: Image.asset(
  //                           'images/Error.png',
  //
  //
  //                         )),
  //
  //
  //                     Text(
  //                       "لا تتوفر بيانات حاليا",
  //                       style: TextStyle(
  //                           fontSize: 20.0,
  //                           color: Color(0xFF686868),
  //                           fontFamily: "Al-Jazeera-Arabic-Bold"),
  //                     ),
  //
  //                   ],
  //                 ),
  //               )
  //
  //
  //           )
  //
  //
  //
  //
  //
  //         ]
  //     ),
  //   );
  // }
  //



  // @override
  // Widget build(BuildContext context) {
  //
  //   return Scaffold(
  //
  //       body:
  //
  //       Column(
  //
  //           children:<Widget>[
  //
  //             Stack(
  //
  //
  //
  //
  //               children: <Widget>[
  //
  //                 CustomAppBar(),
  //                 CustomCurveContainer(),
  //
  //
  //               ],
  //
  //
  //             ),
  //             //CustomeHomeContainer()
  //
  //           ]
  //       )
  //   );
  //
  // }

}