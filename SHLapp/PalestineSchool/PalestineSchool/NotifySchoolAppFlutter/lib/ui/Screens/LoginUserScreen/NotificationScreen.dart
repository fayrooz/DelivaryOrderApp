// ignore: duplicate_ignore
// ignore: file_names

// ignore_for_file: file_names, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schools_notifysystem/Util/NotificationSqlHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/ApiSyncDataMaxIdRecieve.dart';
import '../../../Models/NotificationBadge/NoificationBadge.dart';
import '../../../Models/ReturnedApiLoginData.dart';

import '../../../Util/Constants.dart';

import '../../list/inform_list.dart';

import 'package:badges/badges.dart';

import '../Main/HomeScreen.dart';

class NotificationScreen extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationScreenState();
  }

}


class _NotificationScreenState extends State<NotificationScreen> {


  List<NotificationDataReceive> _list = [];
 // final dbHelper = DatabaseHelper.instance;
  List<ReturnedApiLoginData> data = [];
  String usermsg = "";

   List<NotificationReceive> dataLists = [];

  int count = 0;

  final dbHelper = NotificationDatabaseHelper.instance;
  final _scrollController = ScrollController();


  void _query() async {

    dataLists = [];
    final allRows = await dbHelper.ORDER_queryAllRows();
    print('nnnn _query all rows:');
  //  allRows.forEach(print);

    allRows.forEach((row) => dataLists.add(NotificationReceive.fromJson(row)));


    setState(() {

      for (var item in dataLists) {
        var id = item.id;
        var title = item.title;
        print("$id: $title");


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


      Inform_List.dataList = dataLists.toList();

    });

  }


  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
   // _query();

  }

  @override
  void initState() {
    super.initState();
  _query();


  }
  @override
  Widget build(BuildContext context) {

    print("build_notification screen");
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
                      width: 150.0,
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
                        ),


                      SizedBox(width: 10,),


          InkWell(onTap: () async {

            LatestChattingReturnConst.pageNumber = 1;


            SharedPreferences prefs = await SharedPreferences.getInstance();



              int customerId = prefs.getInt("customerId") ?? 1;
              Chatting.customerId = customerId;

              Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => HomeScreen(8)));



          },

              child: Image.asset('images/MSG_ICO_MENU.png',width: 27,height: 30,)),



          SizedBox(width: 10,),

                          InkWell(onTap: (){
                            Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(4)));
                          },

                              child: Image.asset('images/SearchIcon.png',width: 30,height: 30,)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        'الاشعارات',
                        style: TextStyle(
                            color: Color(0xFFF9F9F9),
                            fontSize: 20,
                            fontFamily: "Al-Jazeera-Arabic-Bold"
                        )),
                  ),

                ],
              )
         , SizedBox(height: 8.0,),


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
                             Inform_List() :
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


}