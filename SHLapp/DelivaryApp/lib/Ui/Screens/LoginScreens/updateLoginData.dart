import 'package:delivaryapp/Util/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/loginViewWidget.dart';

import 'dart:async';
import 'package:flutter/cupertino.dart';

class updateLoginDataPage extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  updateLoginDataScreen(),
    );
  }
}


class updateLoginDataScreen extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _updateLoginDataScreen();
  }

}

class _updateLoginDataScreen extends State<updateLoginDataScreen> {

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  List<String> countries = ["الضفة","الداخل"];
  TextEditingController userName = TextEditingController();

  var _userNamecontroller = TextEditingController();
  var _Passwordcontroller = TextEditingController();

  String selectval = "";
  bool _switchValue=false;
  @override
  void initState() {
    selectval = countries[0];
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,



      body:

      Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          // background image and bottom contents
          Column(

            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height ,

                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                          Text(  "تعديل الحساب" ,style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: "Al-Jazeera-Arabic-Bold")),
                          SizedBox(height: 10,),

                          userData(),


                          SizedBox(height: 15,),

                          Padding(
                            padding:EdgeInsets.only(right: 15) ,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CupertinoSwitch(
                                  activeColor: CustomColors.backgroundColor,
                                  value: _switchValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _switchValue = value;
                                    });
                                  },
                                ),

                                Text(
                                  "نوع الحساب تاجر",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          _switchValue == true ?   companyData(): Container(),
                          SizedBox(height: 10,),
                          Padding(
                            padding:EdgeInsets.only(right: 15) ,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Text(
                                  "العنوان",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.black,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 10,),
                          addressrData(),
                          SizedBox(height: 10,),
                          Padding(
                            padding:EdgeInsets.only(right: 15) ,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Text(
                                  "بيانات الدخول",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.black,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 10,),
                          loginData(),
                          SizedBox(height: 10,),
                          Padding(
                            padding:EdgeInsets.only(right: 15) ,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 150,
                                  child: TextButton (


                                    onPressed: ()  async {


                                    },
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(17),

                                      ),
                                      backgroundColor: Color(0xFF44A2A9),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "رجوع",
                                        style: TextStyle(color: Color(0xFFF5F5F5),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 5,),
                                SizedBox(
                                  height: 45,
                                  width: 150,
                                  child: TextButton (


                                    onPressed: ()  async {


                                    },
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(17),

                                      ),
                                      backgroundColor: Color(0xFF44A2A9),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "حفظ",
                                        style: TextStyle(color: Color(0xFFF5F5F5),fontFamily: "Al-Jazeera-Arabic-Bold",fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  )
              ),



            ],
          ),
          // Profile image



        ],
      ),







    );
  }



  Widget userData(){
    return Center(
      child: Container(

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

              color: Color(0xFFFFFFFF),
              border: Border.all(
                color: Colors.white, //                   <--- border color
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

                        SizedBox(height: 10),

                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "الاسم",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),

                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "رقم المحمول 1",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),

                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "رقم المحمول 2",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),





                        SizedBox(height: 20),





                      ],
                    ),

                  ),

                ),


              )

          )
      ),
    );
  }
  Widget companyData(){
    return Center(
      child: Container(

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

              color: Color(0xFFFFFFFF),
              border: Border.all(
                color: Colors.white, //                   <--- border color
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

                        SizedBox(height: 10),

                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "اسم الشركة-المحل",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),

                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [



                                Text(
                                  "رابط صفحة تواصل اجتماعي 1",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),

                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [


                                Text(
                                  "رابط صفحة تواصل اجتماعي 2",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),

                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [


                                Text(
                                  "رابط صفحة تواصل اجتماعي 3",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),

                        SizedBox(height: 20),


                      ],
                    ),

                  ),

                ),


              )

          )
      ),
    );
  }
  Widget addressrData(){
    return Center(
      child: Container(

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

              color: Color(0xFFFFFFFF),
              border: Border.all(
                color: Colors.white, //                   <--- border color
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
                    .width - 50,
                child:  Padding(
                  padding: EdgeInsets.all(25),

                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(



                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        SizedBox(height: 10),

                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "المنطقة",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        DropdownButton(

                          value: selectval,
                          icon: Icon(                // Add this
                            Icons.arrow_drop_down,  // Add this
                            color: CustomColors.backgroundColor,   // Add this
                          ),
                          items: countries.map((country) {
                            return DropdownMenuItem(
                              child: SizedBox(
                                width:  200,
                                height: 35,
                                child: Text(
                                    textAlign: TextAlign.center,
                                    country, style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Al-Jazeera-Arabic-Regular",
                                    fontSize: 13)),
                              ),
                              value: country,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectval = value.toString();
                            });
                          },
                        ),

                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "المدينة",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        DropdownButton(

                          value: selectval,
                          icon: Icon(                // Add this
                            Icons.arrow_drop_down,  // Add this
                            color: CustomColors.backgroundColor,   // Add this
                          ),
                          items: countries.map((country) {
                            return DropdownMenuItem(
                              child: SizedBox(
                                width:200,
                                height: 35,
                                child: Text(
                                    textAlign: TextAlign.center,
                                    country, style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Al-Jazeera-Arabic-Regular",
                                    fontSize: 13)),
                              ),
                              value: country,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectval = value.toString();
                            });
                          },
                        ),

                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "العنوان تفصيلي",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),





                        SizedBox(height: 20),





                      ],
                    ),

                  ),

                ),


              )

          )
      ),
    );
  }
  Widget loginData(){
    return Center(
      child: Container(

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

              color: Color(0xFFFFFFFF),
              border: Border.all(
                color: Colors.white, //                   <--- border color
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

                        SizedBox(height: 10),

                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "اسم المستخدم",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),

                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "كلمة المرور",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),

                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "تاكيد كلمة المرور",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),

                        SizedBox(height: 20),

                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 13.0,

                                      color: Colors.red,
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                                SizedBox(width: 3,),

                                Text(
                                  "ملاحظات",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF9a9a9a),
                                      fontFamily: "Al-Jazeera-Arabic-Bold"),
                                ),
                              ],
                            )


                        ),
                        _TextFieldCustom( 1,"" , Icon(Icons.account_circle_outlined,),false),




                      ],
                    ),

                  ),

                ),


              )

          )
      ),
    );
  }


  Widget _TextFieldCustom(int flag  , String lableText , Icon icon , bool obscureText) {

    return    SizedBox(
      height: 35,
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



              //

            )
        ),
      ),
    );

  }



}