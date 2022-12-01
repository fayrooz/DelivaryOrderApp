



import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/ApiDataReceive.dart';
import '../../../Models/ApiDataSend.dart';
import '../../../Models/ChattingGroupReturn.dart';
import '../../../Models/ReturnedApiLoginData.dart';
import '../../../Services/ChattingService.dart';
import '../../../Services/StudentsService.dart';
import '../../../Services/dio_client.dart';
import '../../../Services/sendMsgService.dart';
import '../../../Util/Constants.dart';
import '../../../Util/SQLHelper.dart';
import '../../list/chattingGroup_list.dart';
import '../../list/chatting_list.dart';
import '../Main/HomeScreen.dart';
import 'package:intl/intl.dart' as intl;

class ChattingScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChattingScreenState();
  }

}


class _ChattingScreenState extends State<ChattingScreen> {

  final DioClient _dioClient = DioClient();
  List<ChattingReturn> _list = [];
  String _isLogin = "false";
  String usermsg = "";
  bool _isLoading=false;
  final dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> _journals = [];

  List<ReturnedApiLoginData> data = [];

  var _MsgTxtcontroller = TextEditingController();

  bool visible = false ;

  int _page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;
  String userType = "";

  String customerName = "";


  String groupAdminSenderName =  "";


  void _query() async {
    _list = [];
    //Chatting_List.studentList = [];

    setState(() {
      _isLoading = true;
      _isFirstLoadRunning = true;
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

    List<ChattingReturn> returnDatas=
    await _dioClient.createChattingService(userInfo: obj);

    int l =  returnDatas.length;
    print("returnDatas$l");

    if (l  != 0){

      setState(() {
        _list = returnDatas;
        print("_list");
        print(_list.length);
        for (var item in _list){
          print(item.adminSenderName);
          print(item.msgFromAdmin);
          print(item.msgText);
          print(item.msgTs);
        }

        _isLoading = false;
      });
    }

    else{

      setState(() {

        _isLoading = false;
        if (l == 0){
        //    showAlertDialog(context , "تنبيه" , "لا يتوفر بيانات حاليا");
        }else{
          showAlertDialog(context , "تنبيه" , ErrorMsg);
        }


        print("ErrorMsg: $ErrorMsg");
      });
    }





    // chattingService(obj).then((result) {
    //   setState(() {
    //
    //     List<ChattingReturn> result_list = [];
    //     String receivedJson = result;
    //     List<dynamic> list = json.decode(receivedJson);
    //
    //     for (var item in list) {
    //       ChattingReturn fact = ChattingReturn.fromJson(item);
    //       result_list.add(fact);
    //     }
    //
    //     _list = result_list;
    //    //  Chatting_List.studentList = _list;
    //     _isLoading = true;
    //   });
    // });


    setState(() {
      _isFirstLoadRunning = false;
    });



  }


  void _loadMore() async {
    if (_hasNextPage == true &&

        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      ChattingGroup.pageNumber+= 1;
      try {

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


        List<ChattingReturn>? returnDatas=
        await _dioClient.createChattingService(userInfo: obj);

        if (returnDatas != null){
          setState(() {

            for (var item in returnDatas) {

              _list.add(item);
            }

          //  Chatting_List.studentList = _list;

          });
        }

        // chattingService(obj).then((result) {
        //   setState(() {
        //
        //     List<ChattingReturn> result_list = [];
        //     String receivedJson = result;
        //     List<dynamic> list = json.decode(receivedJson);
        //
        //     for (var item in list) {
        //       ChattingReturn fact = ChattingReturn.fromJson(item);
        //       _list.add(fact);
        //     }
        //
        //     Chatting_List.studentList = _list;
        //
        //   });
        // });




      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  String getDate(String date){
    DateTime dt = DateTime.parse(date);
    var formatterDate = DateFormat('dd/MM');
    //  var formatterTime = DateFormat('kk:mm');
    String actualDate = formatterDate.format(dt);
    // String actualTime = formatterTime.format(dt);
    return actualDate ;
  }
  String getTime(String date){
    DateTime dt = DateTime.parse(date);
    // var formatterDate = DateFormat('dd/MM');
    var formatterTime = DateFormat('kk:mm');
    // String actualDate = formatterDate.format(dt);
    String actualTime = formatterTime.format(dt);
    return
      actualTime;
  }



  @override
  void initState()    {
    super.initState();
    visible = false;
    isLogin();
    ChattingGroup.pageNumber = 1;
    _query();
    _controller = ScrollController()..addListener(_loadMore);





  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }


  isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString("isLogin") ?? "false";
    setState(() {
      _isLogin = isLogin;
    });

    print(_isLogin);


     userType = prefs.getString("userType") ?? "customer";
     customerName = prefs.getString("customerName") ?? "";


     groupAdminSenderName = prefs.getString("groupAdminSenderName") ?? "";

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
                padding: EdgeInsets.only(top: 10, right: 10),

                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

             children: [


              Text(
          'المراسلات',
          style: TextStyle(
              color: Color(0xFFF9F9F9),
              fontSize: 20,
              fontFamily: "Al-Jazeera-Arabic-Bold"
          )),

                     userType != "customer"? Text(Chatting.studentName, style: TextStyle(color: Colors.white,fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 14),):Container(),],
                      )


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


            child:

            Stack(
              children: [
                _list.length > 0  ?
                ListView.separated(
                  controller:  _controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: false,
                  padding: const EdgeInsets.only(top: 25,right: 10,left: 10,bottom: 280),
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {


                    return InkWell(
                      onTap: (){
                        sAlertDialog(context , "", _list[index].msgText);
                      },
                      child: Column(
                        children: [
                          _list[index].msgFromAdmin == false ?
                          InkWell(
                            onTap: (){
                              sAlertDialog(context , "", _list[index].msgText);
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
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.8,
                                    padding: EdgeInsets.only(right: 10),
                                    child: Directionality(
                                      textDirection: ui.TextDirection.rtl,

                                      child: Text(_list[index].msgText,
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xFF686868),
                                              fontFamily: "Al-Jazeera-Arabic-Regular",
                                              fontSize: 16)),
                                    ),
                                  ),
                                  SizedBox(height: 10), //1st row

                                  //2d row
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child:   Container(
                                      width: 90 ,
                                      height: 35,
                                      child: TextButton(

                                          style: ButtonStyle(

                                            backgroundColor:


                                            MaterialStateProperty.all(Color(0xff44A2A9)),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(17.0))),
                                          ),
                                          onPressed: () {},


                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                  children: [
                                                    Text(
                                                      getDate( _list[index].msgTs ) + " ",
                                                      style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 13),
                                                    ),

                                                    Text(
                                                      getTime(_list[index].msgTs),
                                                      style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 13),
                                                    ),
                                                  ]

                                              )


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

                          Padding(


                            padding:EdgeInsets.only(right: 30),
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
                                sAlertDialog(context , "", _list[index].msgText);

                         },



                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.8,
                                      padding: EdgeInsets.only(right: 10),
                                      child: Directionality(
                                        textDirection: ui.TextDirection.rtl,
                                        child: Text(_list[index].msgText,
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
                                  SizedBox(height: 10),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child:   Container(
                                          width: 90 ,
                                          height: 35,
                                          child: TextButton(

                                              style: ButtonStyle(

                                                backgroundColor:


                                                MaterialStateProperty.all(Color(0xff44A2A9)),
                                                shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(17.0))),
                                              ),
                                              onPressed: () {},


                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                      children: [
                                                        Text(
                                                          getDate( _list[index].msgTs ) + " ",
                                                          style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 13),
                                                        ),

                                                        Text(
                                                          getTime(_list[index].msgTs),
                                                          style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 13),
                                                        ),
                                                      ]

                                                  )


                                              )


                                          ),
                                        ),
                                      ),

                                      Text(_list[index].adminSenderName,
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xFF686868),
                                              fontFamily: "Al-Jazeera-Arabic-Regular",
                                              fontSize: 13)),
                                  ],)


                                  //  SizedBox(height: 5),
                                  //3rd row


                                ],
                              ),


                            ),
                          )

                        ],
                      ),
                    )



                    ;
                  },
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(
                    height: 20,
                  ),
                ): _isLoading == false ?   Padding(
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
                ):


                Container(
                  padding: const EdgeInsets.all(50),
                  margin:const EdgeInsets.all(50) ,
                  color:Colors.white,
                  //widget shown according to the state
                  child: Center(
                    child:
                    CircularProgressIndicator(),
                  ),


                ),

               Positioned(
         bottom: 210,
         right: 10,

         child: Container(
           width: 120 ,
           height: 35,
           child: TextButton(

               style: ButtonStyle(

                 backgroundColor:


                 MaterialStateProperty.all(Color(0xff44A2A9)),
                 shape: MaterialStateProperty.all(
                     RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(8.0))),
               ),
               onPressed: () {

                 _showAlert();


               },
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset('images/SndMSG.png',fit: BoxFit.fitHeight,),


                   Text(
                     "رسالة جديدة",
                     style: TextStyle(color: Color(0xffF9F9F9),fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 13),
                   ),
                 ],
               )




           ),
         )


       ),

                // when the _loadMore function is running
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                // When nothing else to load
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),

              ],
            )


    )


    ,
        ],
      ),
    );
  }

   _showAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return

            AlertDialog(
              content:

              visible == false?  new Container(
                width: 300.0,
                height: 250.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xFFFFFF),
                  borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,


                  children: <Widget>[
                    // dialog top


                    // dialog centre
                    new Container(



                        child: new TextField(

                         // textDirection: TextDirection.rtl,
                          showCursor: true,

                          textAlign: TextAlign.center,
                          controller: _MsgTxtcontroller,
                          maxLines: 10, // <-- SEE HERE
                          minLines: 1, // <-- SEE HERE
                          keyboardType: TextInputType.multiline,
                          decoration: new InputDecoration(

                            isDense: true, // important line
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 2),//
                            border: InputBorder.none,
                            filled: false,

                            hintText: ' ادخل نص الرسالة',
                            hintStyle: new TextStyle(

                              color: Colors.grey.shade500,
                              fontSize: 12.0,
                              fontFamily: 'Al-Jazeera-Arabic-Regular',
                            ),
                          ),
                          onChanged: (val){

          },


                        )),


                      Expanded(
                       child: Align(
                         alignment: Alignment.bottomCenter,
                         child: InkWell(
                          onTap: () async {


                            // final trimVal = val.trim();
                            // if (val != trimVal)
                            //
                            //   setState(() {
                            //     _MsgTxtcontroller.text = trimVal;
                            //     _MsgTxtcontroller.selection = TextSelection.fromPosition(TextPosition(offset: trimVal.length));
                            //   });
                            //
                            print("_MsgTxtcontroller.text.trim():");



                            print(_MsgTxtcontroller.text.trim().length > 0 ) ;


                            // if (_MsgTxtcontroller.text != _MsgTxtcontroller.text.trim()){
                            //   sAlertDialog(context, "تنبيه", "الرجاء ادخال نص الرسالة");
                            // }



           if (_MsgTxtcontroller.text != "" && _MsgTxtcontroller.text.trim().length > 0) {
            showLoaderDialog(contexts);

            List<ReturnedApiLoginData> data = [];


            final allRows = await dbHelper.queryAllRows();


            print('query all rows:');
            allRows.forEach(print);

            allRows.forEach((row) =>
                data.add(ReturnedApiLoginData.fromJson(row)));

            print("data");

            int? id = await dbHelper.queryRowCount();
            print("maxid$id");
            int maxid = id ?? 0;


            ApiDataSend obj = ApiDataSend(deviceOsTypeId: 1,
                customerId: data[maxid - 1].customerId,
                token: data[maxid - 1].token, maxId: 0);

            SendMessageChatting.msgText = _MsgTxtcontroller.text;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String userType = prefs.getString("userType") ?? "customer";
            String customerName = prefs.getString("customerName") ?? "";


            String groupAdminSenderName = prefs.getString(
                "groupAdminSenderName") ?? "";


            if (userType == "customer") {
              SendMessageChatting.isAdmisender = false;
              SendMessageChatting.adminSenderName = "";
            } else {
              SendMessageChatting.isAdmisender = true;
              SendMessageChatting.adminSenderName = groupAdminSenderName;
            }

            // String returnDatas=
            // await _dioClient.SendMessageService(userInfo: obj);
            //
            //
            // setState(() async {
            //
            //   print("result$returnDatas");
            //
            //   _MsgTxtcontroller.text = "";
            //
            //   _query();
            //
            //   Navigator.of(contexts, rootNavigator: true).pop("Discard");
            //   Navigator.pop(contexts, 'Cancel');
            //
            //
            //
            //
            // });


            SendMessageService(obj).then((result) {
              print("result$result");

              _MsgTxtcontroller.text = "";

              _query();

              Navigator.of(contexts, rootNavigator: true).pop("Discard");
              Navigator.pop(contexts, 'Cancel');
            });
          }
           else
            {


              sAlertDialog(context, "تنبيه", "الرجاء ادخال نص الرسالة");
            }

                          },
                          child: (
                           new Container(

                             height: 35,
                             width:  MediaQuery
              .of(context)
              .size
              .width,

                             decoration: new BoxDecoration(
                               color:  CustomColors.backgroundColor,
                             ),
                             child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                               Image.asset('images/SndMSG.png',fit: BoxFit.fitHeight,),



                                       Text(
                                         'ارسل الرسالة',
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 16.0,
                                           fontFamily: 'Al-Jazeera-Arabic-Regular',
                                         ),
                                         textAlign: TextAlign.center,
                                       ),
                                      ],
                                 )



                           ))
                          ),
                    ),
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


              ),
            );;
        });
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }






}

