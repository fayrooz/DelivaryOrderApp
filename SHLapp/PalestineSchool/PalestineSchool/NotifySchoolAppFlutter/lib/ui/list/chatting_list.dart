import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schools_notifysystem/Widgets/inform.dart';

import '../../Models/ApiDataReceive.dart';
import '../../Models/ApiDataSend.dart';
import '../../Models/ChattingGroupReturn.dart';
import '../../Services/StudentsService.dart';
import '../../Util/Constants.dart';

class Chatting_List extends StatelessWidget {

  static  List<ChattingReturn> studentList = [] ;



  const Chatting_List({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    print("ff$studentList.length");
    print(studentList.length);

    return  Expanded(
      child: ListView.separated(

        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        reverse: false,
        padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 200),
        itemCount: studentList.length,
        itemBuilder: (BuildContext context, int index) {


          return Column(
            children: [
              studentList[index].msgFromAdmin == false?

              InkWell(
                onTap: (){
                  sAlertDialog(context , "", studentList[index].msgText);
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
                      right: BorderSide(width: 4.0, color: Colors.green),
                      // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                    ),
                    color: Colors.white,
                  ),
                  child:
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [


                            Text(studentList[index].msgText,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFF686868),
                                    fontFamily: "Al-Jazeera-Arabic-Regular",
                                    fontSize: 15)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10), //1st row

                      //2d row
                      Align(
                        alignment: Alignment.topLeft,
                        child:   Container(
                          width: 120 ,
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
                                studentList[index].msgTs,
                                style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 10),
                              )


                          ),
                        ),
                      ),

                      //  SizedBox(height: 5),
                      //3rd row


                    ],
                  ),


                ),
              ):
              InkWell(
                onTap: (){
                  sAlertDialog(context , "", studentList[index].msgText);
                },
                child: Padding(padding:EdgeInsets.only(right: 30), child: Container(

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
                        right: BorderSide(width: 4.0, color: Colors.deepPurple),
                        // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                      ),
                      color: Colors.white,
                    ),
                    child:
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        InkWell(
                          onTap: (){
                          //  sAlertDialog(context , "", studentList[index].msgText);
                          },

                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            padding: EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(studentList[index].msgText,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xFF686868),
                                      fontFamily: "Al-Jazeera-Arabic-Regular",
                                      fontSize: 16)),
                            ),
                          ),
                        ),

                        SizedBox(height: 10), //1st row

                        //2d row
                        Align(
                          alignment: Alignment.topLeft,
                          child:   Container(
                            width: 120 ,
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
                                  studentList[index].msgTs,
                                  style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 10),
                                )


                            ),
                          ),
                        ),

                        //  SizedBox(height: 5),
                        //3rd row


                      ],
                    ),


                  ),
                ),
              )

            ],
          )



          ;
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 20,
        ),
      ),
    );

  }




}