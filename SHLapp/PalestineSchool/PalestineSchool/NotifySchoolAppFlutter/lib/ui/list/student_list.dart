import 'package:flutter/material.dart';
import 'package:schools_notifysystem/Widgets/inform.dart';

import '../../Models/ApiDataReceive.dart';
import '../../Models/ApiDataSend.dart';
import '../../Services/StudentsService.dart';
import '../../Util/Constants.dart';

class Student_List extends StatelessWidget {

  static  List<DataReceive> studentList = [] ;



  const Student_List({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    print("ff$studentList.length");
    print(studentList.length);

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: false,
      padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 200),
      itemCount: studentList.length,
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
              right: BorderSide(width: 4.0, color: Colors.green),
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
                  studentList[index].title.toString() != "null" ?
                  Container(
                    width: 100,
                    height: 35,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Color(0xff44A2A9)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36.0))),
                        ),
                        onPressed: () {},
                        child: Text(

                          studentList[index].title,

                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 11,color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Regular",),
                        )),
                  ): Container(),

                  Text(studentList[index].serviceTitle,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xFF686868),
                          fontFamily: "Al-Jazeera-Arabic-Bold",
                          fontSize: 15)),
                ],
              ),
              SizedBox(height: 10), //1st row

              //2d row
              Align(
                alignment: Alignment.topRight,
                child: Text(

                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: "Al-Jazeera-Arabic-Regular"),
                    studentList[index].serviceBody,
                    softWrap: true),
              ),

              //  SizedBox(height: 5),
              //3rd row


            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 20,
      ),
    );

  }
}