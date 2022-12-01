import 'package:flutter/material.dart';
import 'package:schools_notifysystem/Widgets/inform.dart';

import '../../Models/ApiDataReceive.dart';
import '../../Models/ApiDataSend.dart';
import '../../Services/StudentsService.dart';
import '../../Util/Constants.dart';
import '../Screens/Main/HomeScreen.dart';

class AdminGroupStudent_list extends StatelessWidget {

  static  List<DataReceive_AdminGroup> studentList = [] ;



  const AdminGroupStudent_list({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    print("ff$studentList.length");
    print(studentList.length);

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 200),


      itemCount: studentList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: (){

            Chatting.customerId  = studentList[index].customerId;
            Chatting.studentName = studentList[index].studentName;

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
                right: BorderSide(width: 4.0, color: Colors.green),
                // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(studentList[index].studentName,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xFF686868),
                            fontFamily: "Al-Jazeera-Arabic-Bold",
                            fontSize: 15)),
                  ],
                ),
                SizedBox(height: 10,)


                //  SizedBox(height: 5),
                //3rd row


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