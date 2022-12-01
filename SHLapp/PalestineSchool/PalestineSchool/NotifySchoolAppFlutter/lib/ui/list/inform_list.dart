import 'dart:core';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/NotificationBadge/NoificationBadge.dart';
import '../../Util/Constants.dart';


class Inform_List extends StatelessWidget {

  static List<NotificationReceive> dataList = [];

  const Inform_List({Key? key}) : super(key: key);

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
          onTap: (){
            sAlertDialog(context , dataList[index].title, dataList[index].body);
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
                right: BorderSide(width: 4.0, color:  dataList[index].isSeen == "false" ? Colors.green : Color(0xFFCBCBCB)

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

                    Container(
                      width: 46 ,
                      height: 30,
                      child: TextButton(

                          style: ButtonStyle(

                            backgroundColor:


                            MaterialStateProperty.all(Color(0xff44A2A9)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          onPressed: () {},
                          child: Text(
                            dataList[index].main_label.toString(),

                            style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 10),
                          )


                      ),
                    ) ,

                     Text(dataList[index].title,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xFF686868),
                            fontFamily: "Al-Jazeera-Arabic-Bold",
                            fontSize: 13)),
                  ],
                ),
                SizedBox(height: 10), //1st row

                //2d row
                Text(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Al-Jazeera-Arabic-Regular"),
                    dataList[index].body,
                    softWrap: true),

                 SizedBox(height: 20),


                dataList[index].url_link == "nodata" ? Container():  Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 90,
                    height: 35,

                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border: Border.all(
                                    color: Color(0xFFC3D5D6), //                   <--- border color
                                    width: 0.5,
                                  ),
                                ),
                    child:
                    Row(


                      children: [


                        TextButton(

                            onPressed: () {
                              print(dataList[index].url_link);

                              launchURL(dataList[index].url_link.toString());

                            },
                            child: Text(
                              "الرابط",
                              style: TextStyle(color: Colors.black54,fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 13),
                            )


                        ),
                        Image.asset(
                          'images/attachemet.png',
                        ),



                        ]
                    )
                    ,


                  ),
                ),



                SizedBox(height: 13),
                //3rd row

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    ),

                    dataList[index].secondary_label == "nodata"? Container():Text( (dataList[index].secondary_label).toString(),


                        maxLines: 2,
                        textAlign: TextAlign.right,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFF686868),
                            fontFamily: "Al-Jazeera-Arabic-Bold",
                            fontSize: 13))

                  ],

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


  launchURL(String _url) async {

    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $url';
    }
  }
}