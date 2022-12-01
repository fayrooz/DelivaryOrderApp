import 'dart:core';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/ChattingGroupReturn.dart';
import '../../Models/NotificationBadge/NoificationBadge.dart';
import '../../Util/Constants.dart';
import '../Screens/Main/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LatestChat_List extends StatelessWidget {

  static List<LatestChattingReturn> dataList = [];

  const LatestChat_List({Key? key}) : super(key: key);
  String getDate(String date){
    DateTime dt = DateTime.parse(date);
    var formatterDate = DateFormat('dd/MM');
    var formatterTime = DateFormat('kk:mm');
    String actualDate = formatterDate.format(dt);
    String actualTime = formatterTime.format(dt);
    return actualDate + " "
        + actualTime;
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: false,
      padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 200),
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () async {


             ChattingGroup.groupid = dataList[index].groupId;


              Chatting.customerId = dataList[index].customerId;

              Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(5)));




          },
          child: Container(

            margin: const EdgeInsets.only(left: 4.0, right: 4.0),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border(
                right: BorderSide(width: 4.0, color:   Colors.green

                ),
                // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
              ),
              color: Colors.white,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      dataList[index].groupName,
                      style: TextStyle(color: Color(0xFF686868),fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 10),
                    ) ,


                  ],
                ),

                SizedBox(height: 4),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(dataList[index].msgText,
                      maxLines: 2,
                      textAlign: TextAlign.right,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xFF686868),
                          fontFamily: "Al-Jazeera-Arabic-Bold",
                          fontSize: 13)),
                ),


                SizedBox(height: 17), //1st row

                //2d row







                //3rd row

                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextButton(

                              style: ButtonStyle(

                                backgroundColor:


                                MaterialStateProperty.all(Color(0xff44A2A9)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0))),
                              ),
                              onPressed: () {},
                              child: Text(
                                getDate(dataList[index].msgTs),
                                style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 10),
                              )


                          ),

                        ],
                      ),

                     Text( (dataList[index].customerName),


                          maxLines: 1,
                          textAlign: TextAlign.right,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(

                              color: Color(0xFF686868),
                              fontFamily:  "Al-Jazeera-Arabic-Regular",
                              fontSize: 13))

                    ],

                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 20,
      ),
    );

  }



}