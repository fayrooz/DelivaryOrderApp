

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/ApiDataReceive.dart';
import '../../../Models/ApiDataSend.dart';
import '../../../Models/ChattingGroupReturn.dart';
import '../../../Models/ReturnedApiLoginData.dart';
import '../../../Services/StudentsService.dart';
import '../../../Util/ChattingGroupDbHelper.dart';
import '../../../Util/Constants.dart';
import '../../../Util/SQLHelper.dart';
import '../../list/chattingGroup_list.dart';
import '../Main/HomeScreen.dart';
class ChattingGroupScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChattingGroupScreenState();
  }

}


class _ChattingGroupScreenState extends State<ChattingGroupScreen> {


  List<DataReceive> _list = [];
  String _isLogin = "false";
  String usermsg = "";
  bool _isLoading=false;
  final dbHelper = ChattingGroupHelper.instance;


  List<ChattingGroupReturn> dataLists = [];

  void _query() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString("isLogin") ?? "false";

    if (isLogin == 'false'){

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String usermsg = prefs.getString("usermsg") ?? "يرجى تسجيل الدخول";

      print("usermsg$usermsg");
      this.usermsg = usermsg;
    }

    dataLists = [];
    final allRows = await dbHelper.queryAllRows();
    print('nnnn _query all rows:');
     allRows.forEach(print);

    allRows.forEach((row) => dataLists.add(ChattingGroupReturn.fromJson(row)));


    setState(() {




      ChattingGroup_List.studentList = dataLists.toList();

    });



  }

  @override
  void initState()    {
    super.initState();
    isLogin();
    _query();

  }





  isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString("isLogin") ?? "false";
    setState(() {
      _isLogin = isLogin;
    });

    print(_isLogin);

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
                                      "0",
                                      style: TextStyle(fontSize: 10,fontFamily: "Al-Jazeera-Arabic-Bold"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )




                  ,SizedBox(width: 10,),


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
                    'المراسلات',
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


            child: dataLists.length  > 0 ?
            ChattingGroup_List() :
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
