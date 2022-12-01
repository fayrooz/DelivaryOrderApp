import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:schools_notifysystem/Widgets/inform.dart';

import '../../Models/ApiSyncDataMaxIdRecieve.dart';
import '../../Models/NotificationBadge/NoificationBadge.dart';
import '../../Util/Constants.dart';

class Notification_List extends StatelessWidget {

 // static  List<NotifyDataReceive> notifyList = [] ;

  static List<NotificationReceive> dataList = [];

  const Notification_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(

        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        reverse: false,
        padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 200),
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(

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
                right: BorderSide(width: 4.0,  color:  dataList[index].isSeen == "false" ? Colors.green : Color(0xFFCBCBCB)),
                // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(dataList[index].title,
                      maxLines: 2,
                      textAlign: TextAlign.right,

                       softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(

                          color: Color(0xFF686868),
                          fontFamily: "Al-Jazeera-Arabic-Bold",
                          fontSize: 13)),
                ),

                SizedBox(height: 5),


              Image.network(
                "http://rawda.edu.ps/images/News/9011a471-8d72-4eab-b3bf-7fa31cfd4329.jpg",height: 150,
            ),              //1st row
                SizedBox(height: 5),
                //2d row
                Text(
                    textAlign: TextAlign.right,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Al-Jazeera-Arabic-Regular"),
                    dataList[index].body,
                    softWrap: true),

                //  SizedBox(height: 5),
                //3rd row

                Row(
                  children: [
                    Text(
                      dataList[index].date_ts,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Al-Jazeera-Arabic-Regular"),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      dataList[index].time_ts,
                      style: const TextStyle(
                          fontSize: 11,
                          fontFamily: "Al-Jazeera-Arabic-Regular"),
                    )
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 20,
        ),
      ),
    );

  }
}