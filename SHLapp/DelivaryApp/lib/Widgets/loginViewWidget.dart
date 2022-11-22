

import 'dart:convert';

import 'package:delivaryapp/Ui/Screens/LoginScreens/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/Constants.dart';





class loginView_Widget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _loginView_Widget();
  }
}


  class _loginView_Widget extends State<loginView_Widget> {






    var _userNamecontroller = TextEditingController();
    var _Passwordcontroller = TextEditingController();
    String token= "";
    late SharedPreferences prefs;
    bool loading = false;




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



                                  SizedBox(height: 20),

                                  _TextFieldCustom( 1,"اسم المستخدم" , Icon(Icons.account_circle_outlined,),false),



                                  SizedBox(height: 10),
                                  _TextFieldCustom( 2,"كلمة المرور" , Icon(Icons.lock_outline),true),



                                  SizedBox(height: 20),



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
                                  SizedBox(height: 10),

                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (BuildContext context) => SignUpPage()));
                                    }
                                    ,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child:  Text(
                                        'انشاء مستخدم جديد ',
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontSize: 13.0,color: CustomColors.backgroundColor,fontFamily: "Al-Jazeera-Arabic-Bold"),
                                      ),
                                    ),
                                  )





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

                              SizedBox(height: 20),
                              _TextFieldCustom( 1,"اسم المستخدم" , Icon(Icons.account_circle_outlined,),false),



                              SizedBox(height: 10),
                             _TextFieldCustom( 2,"كلمة المرور" , Icon(Icons.lock_outline),true),



                              SizedBox(height: 20),



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
                              SizedBox(height: 10),

                              InkWell(
                                onTap: (){
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (BuildContext context) => SignUpPage()));
                                }
                                ,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child:  Text(
                                    'انشاء مستخدم جديد ',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 13.0,color: CustomColors.backgroundColor,fontFamily: "Al-Jazeera-Arabic-Bold"),
                                  ),
                                ),
                              )





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


         // Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(0)));

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






