
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schools_notifysystem/ui/list/student_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/ApiDataReceive.dart';
import '../../../Models/ApiDataSend.dart';
import '../../../Models/ReturnedApiLoginData.dart';
import '../../../Services/StudentsService.dart';
import '../../../Services/adminGroupservice.dart';
import '../../../Util/Constants.dart';
import '../../../Util/SQLHelper.dart';
import '../../list/AdminGroupStudent_list.dart';
import '../Main/HomeScreen.dart';




class AdminGroupStudentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AdminGroupStudentScreenState();
  }

}


class _AdminGroupStudentScreenState extends State<AdminGroupStudentScreen> {
  int customerId = 0;
  String token = "";
  String usermsg = "";
  String _isLogin = "false";

  bool _isLoading=false;
  List<DataReceive_AdminGroup> _list = [];
  final dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> _journals = [];

  List<ReturnedApiLoginData> data = [];



  void _query() async {

    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString("isLogin") ?? "false";

    if (isLogin == 'false'){

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String usermsg = prefs.getString("usermsg") ?? "يرجى تسجيل الدخول";

      print("usermsg$usermsg");
      this.usermsg = usermsg;
    }



    final allRows = await dbHelper.queryAllRows();


    print('query all rows:');
    allRows.forEach(print);

    allRows.forEach((row) => data.add(ReturnedApiLoginData.fromJson(row)));

    print("data");

    int? id = await dbHelper.queryRowCount();
    print("maxid$id");
    int maxid = id ?? 0;


    ApiDataSend obj = ApiDataSend(deviceOsTypeId: 1,
        customerId: data[maxid - 1].customerId,
        token: data[maxid - 1].token, maxId: 0);

    AdminGroupCustomersService(obj).then((result) {

      if (result != "[]") {
        setState(() {
          List<DataReceive_AdminGroup> result_list = [];
          String receivedJson = result;
          List<dynamic> list = json.decode(receivedJson);

          for (var item in list) {
            DataReceive_AdminGroup fact = DataReceive_AdminGroup.fromJson(item);
            result_list.add(fact);
          }

          _list = result_list;
          AdminGroupStudent_list.studentList = _list;
          _isLoading = false;
        });
      }
      else{

        setState(() {

          _isLoading = false;

            showAlertDialog(context , "تنبيه" , "لا يتوفر بيانات حاليا");

        });
      }





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




    if (_isLogin == 'false'){

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
                      'الطلاب',
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
                    .height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
                ),


                child: _list.length > 0 ?
                AdminGroupStudent_list() : _isLoading == false ?  Padding(
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
                ):Container(
                     padding: const EdgeInsets.all(50),
                     margin:const EdgeInsets.all(50) ,
                     color:Colors.white,
                     //widget shown according to the state
                     child: Center(
                       child:
                       CircularProgressIndicator(),
                     ),


                   )
            )
          ],
        ),
      );


      // return Scaffold(
      //
      //     body:
      //
      //     Column(
      //
      //         children:<Widget>[
      //
      //           Stack(
      //
      //
      //             clipBehavior: Clip.antiAliasWithSaveLayer,
      //
      //             children: <Widget>[
      //
      //               CustomAppBar(),
      //               CustomCurveContainer(),
      //
      //
      //             ],
      //
      //
      //           ),
      //           //CustomeHomeContainer()
      //
      //         ]
      //     )
      // );
    }



  }




  Widget CustomAppBar(){
    return
      Container(


        color: Color(0xFF44A2A9),
        height:  MediaQuery.of(context).size.height - 118 ,
        width: MediaQuery.of(context).size.width,
        child: ListView(

          children: <Widget>[
            Padding(
              padding: EdgeInsets.only( left: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset('images/Bell.png',width: 50,height: 50,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        'طلابي',
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
  Widget CustomCurveContainer(){

    return Positioned(
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

                Column(
                  children: [

                    _list.length > 0 ?
                    AdminGroupStudent_list() : Container(
                      padding: const EdgeInsets.all(50),
                      margin:const EdgeInsets.all(50) ,
                      color:Colors.white,
                      //widget shown according to the state
                      child: Center(
                        child:
                        CircularProgressIndicator(),
                      ),


                    )

                  ],
                )






            )





          ]
      ),
    );
  }





}