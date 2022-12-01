
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schools_notifysystem/ui/list/student_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/ApiDataReceive.dart';
import '../../../Models/ApiDataSend.dart';
import '../../../Models/ReturnedApiLoginData.dart';
import '../../../Services/StudentsService.dart';
import '../../../Util/Constants.dart';
import '../../../Util/SQLHelper.dart';
import '../Main/HomeScreen.dart';




class StudentsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StudentsScreenState();
  }

}


class _StudentsScreenState extends State<StudentsScreen> {
  int customerId = 0;
  String token = "";
  String usermsg = "";
  String _isLogin = "false";
  String userType = "customer";
  bool _isLoading=false;
  List<DataReceive> _list = [];
  final dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> _journals = [];

  List<ReturnedApiLoginData> data = [];



  void _query() async {

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

      getStudentLists(obj).then((result) {


        if (!mounted) {
          return;
        }
        setState(() {
          List<DataReceive> result_list = [];
          String receivedJson = result;
          List<dynamic> list = json.decode(receivedJson);

          for (var item in list) {
            DataReceive fact = DataReceive.fromJson(item);
            result_list.add(fact);
          }

          _list = result_list;
          Student_List.studentList = _list;
          _isLoading = true;
        });
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

     userType = prefs.getString("userType") ?? "customer";

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
                  padding: EdgeInsets.only(left: 4),
                  child: Container(
                    width: 150.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset('images/Bell.png',width: 50,height: 50,)



                        ,    SizedBox(width: 10,),


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
                    userType == "customer" ? 'طلابي' : 'المجموعات',
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


              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20,top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [

                        Container(
                          width: 50 ,
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
                                _list.length > 0 ? _list.length.toString() : "0",
                                style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 12),
                              )


                          ),
                        ) ,
                        SizedBox(width: 5,),

                        Text( userType == "customer" ? "عدد الطلاب" : "عدد المجموعات",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xFF686868),
                                fontFamily: "Al-Jazeera-Arabic-Bold",
                                fontSize: 13)),
                      ],
                    ),
                  ),

                  SizedBox(height: 10,)
                ,  _list.length > 0 ?
                  Flexible(child: Student_List()) : Container(
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
                     Padding(
                       padding: EdgeInsets.only(right: 20,top: 20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,

                         children: [

                           Container(
                             width: 50 ,
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
                                   _list.length > 0 ? _list.length.toString() : "0",
                                   style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 12),
                                 )


                             ),
                           ) ,
                           SizedBox(width: 5,),

                           Text("عدد الطلاب",
                               maxLines: 2,
                               softWrap: true,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                   color: Color(0xFF686868),
                                   fontFamily: "Al-Jazeera-Arabic-Bold",
                                   fontSize: 13)),
                         ],
                       ),
                     ),

                     SizedBox(height: 10,)
                     ,_list.length > 0 ?
                     Student_List() : Container(
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