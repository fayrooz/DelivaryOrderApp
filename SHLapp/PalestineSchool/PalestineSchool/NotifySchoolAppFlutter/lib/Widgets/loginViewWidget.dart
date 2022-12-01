

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Models/ApiDataSend.dart';
import '../Models/ChattingGroupReturn.dart';
import '../Models/LoginPuplicData.dart';
import '../Models/LoginViewMobileModel.dart';
import '../Models/ReturnedApiLoginData.dart';
import '../Models/user/user_info.dart';
import '../Services/PuplicLoginService.dart';
import '../Services/chattingGroupService.dart';
import '../Services/dio_client.dart';
import '../Services/loginService.dart';
import '../Util/ChattingGroupDbHelper.dart';
import '../Util/Constants.dart';
import '../Util/SQLHelper.dart';
import '../ui/Screens/Main/HomeScreen.dart';




class loginView_Widget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _loginView_Widget();
  }
}


  class _loginView_Widget extends State<loginView_Widget> {


    final dbHelper = DatabaseHelper.instance;



    var _userNamecontroller = TextEditingController();
    var _Passwordcontroller = TextEditingController();
    String token= "";
    late SharedPreferences prefs;
    bool loading = false;
    final ChattingGroup_dbHelpers = ChattingGroupHelper.instance;

    List<ReturnedApiLoginData> data = [];

    final DioClient _dioClient = DioClient();


    void _insert(int customerId, String? customerName, String? customerPK, String? token, String? userType,  String? groupAdminSenderName) async {


      // row to insert
      Map<String, dynamic> row = {
        DatabaseHelper.customerId : customerId,
        DatabaseHelper.token  : token,
        DatabaseHelper.customerName  : customerName,
        DatabaseHelper.customerPK  : customerPK,
        DatabaseHelper.userType  : userType,
        DatabaseHelper.groupAdminSenderName : groupAdminSenderName
      };
      final id = await dbHelper.insert(row);
     // print('inserted row id: $id');

    }

    Widget _TextFieldCustom(int flag  , String lableText , Icon icon , bool obscureText) {

      return    SizedBox(
        height: 45,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(


              obscureText: obscureText,


              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.center,
              onChanged: (_newValue) {

                setState(() {

                  if (flag == 1) {


                    _userNamecontroller.value = TextEditingValue(
                      text: _newValue,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: _newValue.length),
                      ),
                    );
                  }
                  else{
                    _Passwordcontroller.value = TextEditingValue(
                      text: _newValue,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: _newValue.length),
                      ),
                    );
                  }
                });

              },


              controller: flag == 1 ? _userNamecontroller: _Passwordcontroller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  hintText:lableText,
                  hintStyle: TextStyle(
                      fontSize: 14.0,color: Color(0xFF44a2a9),fontFamily: "Al-Jazeera-Arabic-Regular"
                  ),



                // label: Center(
                //   child: Text(lableText,style: TextStyle(
                //       fontSize: 14.0,color: Color(0xFF44a2a9),fontFamily: "Al-Jazeera-Arabic-Regular"
                //   ),),
                // ),


                suffixIcon: IconTheme(data: IconThemeData(
                    color: Color(0xFF44a2a9)
                ), child: icon),

                //
                border: myinputborder(),
                enabledBorder: myinputborder(),
                focusedBorder: myfocusborder(),
              )
          ),
        ),
      );

    }

    @override
    Widget build(BuildContext context) {


      return
        loading
            ? Padding(
          padding: EdgeInsets.only(top: 120),
          child: Stack(
            children: [

              Center(
                child: Container(

                  // ignore: prefer_const_constructors
                    decoration: BoxDecoration(

                        color: Color(0xFFFFFFFF),
                        border: Border.all(
                          color: Color(0xFF44A2A9), //                   <--- border color
                          width: 1.0,
                        ),

                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
                    ),

                    child:   (

                        Container(

                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 40,
                          child:  Padding(
                            padding: EdgeInsets.all(25),

                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(



                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFD9EFF1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(9),
                                      ),
                                    ),
                                    height:40,
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(7),
                                    padding: const EdgeInsets.all(7),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'تطبيق الاشعارات الالكترونية',
                                          style: TextStyle(
                                              color: Color(0xFF1D7F87),
                                              fontSize: 14,
                                              fontFamily: "Al-Jazeera-Arabic-Regular"
                                          ),
                                          textAlign: TextAlign.center,
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),



                                  _TextFieldCustom( 1,"اسم المستخدم" , Icon(Icons.account_circle_outlined,),false),



                                  SizedBox(height: 10),
                                  _TextFieldCustom( 2,"كلمة المرور" , Icon(Icons.lock_outline),true),



                                  SizedBox(height: 10),



                                  SizedBox(
                                    height: 45,
                                    child: TextButton (


                                      onPressed: ()  async {

                                        LoginType = 'login';

                                        String text1 = _userNamecontroller.text ;
                                        String  text2 = _Passwordcontroller.text ;

                                        if(text1 == '' || text2 == '' ){

                                          showAlertDialog(context , "نبيه" , "الرجاء ادخال كافة البيانات");

                                        }else{

                                          setState(()  {
                                            loading = true;
                                            // sleep(Duration(seconds:5));
                                            fetch();


                                          });



                                        }

                                      },
      style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(

      borderRadius: BorderRadius.circular(20),

      ),
        backgroundColor: Color(0xFF44A2A9),
      ),
                                      child: Center(
                                        child: Text(
                                          "تسجيل الدخول",
                                          style: TextStyle(color: Color(0xFFF5F5F5),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Align(
                                    alignment: FractionalOffset.bottomLeft,
                                    child: TextButton(
                                      child: Text( "تسجيل دخول بدون حساب",
                                          style: TextStyle(color: Color(0xFF44A2A9),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 14)),
                                      onPressed: () async {

                                        LoginType = 'puplic';


                                        setState(()  {
                                          loading = true;

                                          fetch_pupilc();



                                        });




                                      },
                                    ),
                                  ),



                                ],
                              ),

                            ),

                          ),


                        )

                    )
                ),
              ),

              Center(child: CircularProgressIndicator()),
            ],

          ),
        )



         :Padding(
          padding: EdgeInsets.only(top:120),
          child: Center(
            child: Container(

              // ignore: prefer_const_constructors
                decoration: BoxDecoration(

                    color: Color(0xFFFFFFFF),
                    border: Border.all(
                      color: Color(0xFF44A2A9), //                   <--- border color
                      width: 1.0,
                    ),

                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
                ),

                child:   (

                    Container(

                      width:  MediaQuery
                          .of(context)
                          .size
                          .width - 30,
                      child:  Padding(
                        padding: EdgeInsets.all(25),

                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(



                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD9EFF1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(9),
                                  ),
                                ),
                                height:40,
                                width: double.infinity,
                                margin: const EdgeInsets.all(7),
                                padding: const EdgeInsets.all(7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'تطبيق الاشعارات الالكترونية',
                                      style: TextStyle(
                                          color: Color(0xFF1D7F87),
                                          fontSize: 14,
                                          fontFamily: "Al-Jazeera-Arabic-Regular"
                                      ),
                                      textAlign: TextAlign.center,
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(height: 10),



                              _TextFieldCustom( 1,"اسم المستخدم" , Icon(Icons.account_circle_outlined,),false),



                              SizedBox(height: 10),
                             _TextFieldCustom( 2,"كلمة المرور" , Icon(Icons.lock_outline),true),



                              SizedBox(height: 10),



                              SizedBox(
                                height: 45,
                                child:
                                TextButton (


                                  onPressed: ()  async {

                                    LoginType = 'login';

                                    String text1 = _userNamecontroller.text ;
                                    String  text2 = _Passwordcontroller.text ;

                                    if(text1 == '' || text2 == '' ){

                                      showAlertDialog(context , "نبيه" , "الرجاء ادخال كافة البيانات");

                                    }else{

                                      setState(()  {
                                        loading = true;
                                       // sleep(Duration(seconds:5));
                                        fetch();


                                      });

                                    }

                                    },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFF44A2A9),

                                      shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(20),

                                      ),


                                  )
                                 ,


                                  child: Center(
                                    child: Text(
                                      "تسجيل الدخول",
                                      style: TextStyle(color: Color(0xFFF5F5F5),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: FractionalOffset.bottomLeft,
                                child: TextButton(
                                  child: Text( "تسجيل دخول بدون حساب",
                                      style: TextStyle(color: Color(0xFF44A2A9),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 14)),
                                  onPressed: () async {

                                    LoginType = 'puplic';

                                    setState(()  {
                                      loading = true;

                                      fetch_pupilc();

                                    });

                                 },
                                ),
                              ),



                            ],
                          ),

                        ),

                      ),


                    )

                )
            ),
          ),
        );


    }


    fetch() async {
     // LoginViewMobileModel loginObj = LoginViewMobileModel( password: _Passwordcontroller.text,username: _userNamecontroller.text,token: "token1",deviceOsTypeId: 1);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String FCMtoken = prefs.getString("FCMtoken") ?? "";

      UserInfo userInfo = UserInfo(
           username: _userNamecontroller.text,
            password: _Passwordcontroller.text,
        deviceOsTypeId: 1,
        token: FCMtoken

      );

      ReturnedApiLoginData? returnData =
      await _dioClient.createUser(userInfo: userInfo);

      if (returnData != null) {

        print(returnData.customerName);
        print(returnData.userType);
        print(returnData.groupAdminSenderName);

        if (returnData.userType == "customer"){

          prefs.setString("groupAdminSenderName", "");
          _insert(returnData.customerId,
            returnData.customerName,
            returnData.customerPk,
            returnData.token,
            returnData.userType,
           "no data",
          );

        }

        else{
          prefs.setString("groupAdminSenderName", returnData.groupAdminSenderName.toString() );
          _insert(returnData.customerId,
            returnData.customerName,
            returnData.customerPk,
            returnData.token,
            returnData.userType,
            returnData.groupAdminSenderName,
          );
        }




        prefs.setString("isLogin", "true");
        prefs.setString("customerName", returnData.customerName);
        prefs.setString("userType", returnData.userType);
        prefs.setInt("customerId", returnData.customerId);




        final allRows = await dbHelper.queryAllRows();


        print('login rows:');
        allRows.forEach(print);
        allRows.forEach((row) => data.add(ReturnedApiLoginData.fromJson(row)));

        int? id = await dbHelper.queryRowCount();
        print("maxid$id");
        int maxid = id ?? 0;
        ApiDataSend obj = ApiDataSend(deviceOsTypeId: 1,
            customerId: data[maxid - 1].customerId,
            token: data[maxid - 1].token,maxId: 0);



        List<chattingGroupReturn> returnDatas=
        await _dioClient.createchattingGroupService(userInfo: obj);

        print(returnDatas);

        if(returnDatas != null) {
          for (var item in returnDatas) {
            print(item.groupName);
            print(item.serviceTitle);

            ChattingGroup_insertToDataBase(
                item.groupId, item.groupName, item.serviceTitle);
          }
        }

          Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(0)));


      }

      else{
        showAlertDialog(context , "نبيه" , "خطا اسم المستخدم/كلمة المرور");
        setState(()  {
          loading = false;
        });
      }






    }

    fetch_pupilc() async{
      final LoginPuplicData? returnData_p = await PuplicLoginPost();

      getSharedPreferences ();


      saveStringValue (returnData_p!.notRegistredUserMsg);

      if (returnData_p != null){
        loading = false;

        prefs = await SharedPreferences.getInstance();
        prefs.setString("isLogin_p", "true");


        Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(0)));
      }
    }

    getSharedPreferences () async
    {

      prefs = await SharedPreferences.getInstance();
    }
    saveStringValue (String usermsg) async
    {

      prefs = await SharedPreferences.getInstance();
      prefs.setString("usermsg", usermsg);
    }


    ChattingGroup_insertToDataBase(int groupId, String groupName, String serviceTitle
        ) async {


      print('ChattingGroup_dbHelpers ');
      // row to insert
      Map<String, dynamic> row = {
        ChattingGroupHelper.groupId : groupId,
        ChattingGroupHelper.groupName  : groupName,
        ChattingGroupHelper.serviceTitle  : serviceTitle


      };

      final _id = await ChattingGroup_dbHelpers.insert(row);
      print('ChattingGroup_dbHelpers : inserted row id: $_id');



    }








    OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
      return OutlineInputBorder( //Outline border type for TextFeild
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color:Color(0xFF44a2a9),
            width: 1,
          )
      );
    }

    OutlineInputBorder myfocusborder(){
      return OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color:Color(0xFF44a2a9),
            width: 1,
          )
      );
    }



  }






