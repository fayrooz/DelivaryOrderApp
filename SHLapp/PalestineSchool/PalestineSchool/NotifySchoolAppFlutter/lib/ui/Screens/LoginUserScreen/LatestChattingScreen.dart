
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schools_notifysystem/ui/list/LatestChatting_List.dart';
import 'package:schools_notifysystem/ui/list/student_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/ApiDataReceive.dart';
import '../../../Models/ApiDataSend.dart';
import '../../../Models/ChattingGroupReturn.dart';
import '../../../Models/ReturnedApiLoginData.dart';
import '../../../Services/StudentsService.dart';
import '../../../Services/adminGroupservice.dart';
import '../../../Services/dio_client.dart';
import '../../../Util/Constants.dart';
import '../../../Util/SQLHelper.dart';
import '../../list/AdminGroupStudent_list.dart';




class LatestChattingScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LatestChattingScreenState();
  }

}


class _LatestChattingScreenState extends State<LatestChattingScreen> {

  final DioClient _dioClient = DioClient();


  bool _isLoading=false;
  List<LatestChattingReturn> _list = [];
  final dbHelper = DatabaseHelper.instance;
  String _isLogin = "false";


  List<ReturnedApiLoginData> data = [];



  void _query() async {


    setState(() {
      _isLoading = true;

    });

    _list = [];
    LatestChat_List.dataList = [];
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




    List<LatestChattingReturn> returnDatas=
    await _dioClient.getLatestChattingService(userInfo: obj);

    print("returnDatas.length");
    print(returnDatas.length);

    if (returnDatas.length == 0){
      setState(() {
      _isLoading = false;
      });

    //  showAlertDialog(context , "تنبيه" , "لا يتوفر بيانات حاليا");
    }

    else {
      if (returnDatas != null) {
        print("r");
        setState(() {
          print("rr");
          _list = returnDatas;
           LatestChat_List.dataList = _list;
          _isLoading = false;

        });
      }
    }


  }

  @override
  void initState()    {
    super.initState();

    LatestChattingReturnConst.pageNumber = 1;
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
                  padding: EdgeInsets.only(left: 4),
                  child: Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset('images/Bell.png',width: 50,height: 50,)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      'احدث المراسلات',
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
                LatestChat_List() :_isLoading == false ?   Padding(
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
                ): Container(
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