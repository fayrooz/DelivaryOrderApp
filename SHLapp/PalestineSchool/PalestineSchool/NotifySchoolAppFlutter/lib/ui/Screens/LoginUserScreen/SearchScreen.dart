
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schools_notifysystem/Util/Constants.dart';
import 'package:schools_notifysystem/ui/list/student_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/NotificationBadge/NoificationBadge.dart';
import '../../../Util/NotificationSqlHelper.dart';
import '../../list/search_list.dart';
import '../Main/HomeScreen.dart';



class SearchScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchScreenState();
  }

}


class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchcontroller = TextEditingController();



  List<String> countries = ["النوع"];
  String selectval = "";
  String _isLogin = "false";
  String usermsg = "";
  late List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  late ListItem _selectedItem;

  List<NotificationReceive> dataLists = [];
  List<NotificationReceive> SearchLists = [];
  final dbHelper = NotificationDatabaseHelper.instance;
  var isLoading = "false";


  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name,textAlign: TextAlign.center , style:  TextStyle(
              fontSize: 14,
              fontFamily: "Al-Jazeera-Arabic-Regular"),),
          value: listItem,

        ),
      );
    }
    return items;
  }


  @override
  void initState() {
    super.initState();
    dataLists = [];
    SearchLists = [];

    selectval = countries[0];
    isLoading = "false";
    isLogin();
    _fetch();
  }


  isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString("isLogin") ?? "false";
    setState(() {
      _isLogin = isLogin;
    });

    print(_isLogin);

    if (isLogin == 'false'){

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String usermsg = prefs.getString("usermsg") ?? "يرجى تسجيل الدخول";

      print("usermsg$usermsg");
      this.usermsg = usermsg;
    }

  }
  _fetch() async {
    var Litems = [];

    final allRows = await dbHelper.queryAllRows();
    print('search _query all rows:');
    allRows.forEach(print);
    allRows.forEach((row) => dataLists.add(NotificationReceive.fromJson(row)));

    for(var item in dataLists ){
      Litems.add(item.main_label) ;
    }


    setState(() {
      for(var item in Litems.toSet().toList() ){
        print(item) ;
        countries.add(item);
     //   items.add(item);
      }


    // items = Litems;

    });


  }

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('تنبيه'),
      content: const Text('الرجاء ادخال البيانات'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');

          },
          child: const Text('موافق'),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {

    if (_isLogin == 'false'){

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
                        Image.asset('images/Bell.png', width: 50, height: 50,)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      'بحث',
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))
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
              ,


            )
          ],
        ),
      );

    }

   else {
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
                        Image.asset('images/Bell.png', width: 50, height: 50,),


                        SizedBox(width: 10,),


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
                      'بحث',
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))
              ),


              child: Column(

                children: <Widget>[


                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
                    height: 60,
                    width: MediaQuery
                    .of(context)
                    .size
                    .width - 20,

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:  Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border(
                        right: BorderSide(
                            width: 4.0, color: CustomColors.backgroundColor),
                        // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                      ),
                      color: Colors.white,
                    ),


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,



                      children: [

                         InkWell(

                          onTap: () async {
                            print("selectval$selectval");

                            SearchLists = [];
                            dataLists = [];

                            print("Search-btn.");
                            print(_searchcontroller.text);


                            //no choice
                            if (_searchcontroller.text == "" &&
                                selectval == "النوع") {
                              showDialogBox();
                            }
                            // type(main lable) only
                            else if (_searchcontroller.text == "" &&
                                selectval != "النوع") {
                              final allRows = await dbHelper
                                  .ORDER_queryAllRows();
                              print('search _query all:');
                              allRows.forEach(print);
                              allRows.forEach((row) =>
                                  dataLists.add(
                                      NotificationReceive.fromJson(row)));

                              for (var item in dataLists) {
                                print(item.main_label);
                                if (item.main_label == selectval) {
                                  SearchLists.add(item);
                                }
                              }
                              print(SearchLists.length);

                              setState(() {
                                isLoading = "true";


                                print("yesy");


                                if (SearchLists.length != 0) {
                                  print("tggg");
                                  isLoading = "false";

                                  // _wait();
                                  Search_List.dataList = SearchLists;
                                }
                                else {
                                  print("no result");
                                  isLoading = "no result";
                                }
                              });
                            }
                            //text(body) only
                            else if (_searchcontroller.text != "" &&
                                selectval == "النوع") {
                              final allRows = await dbHelper
                                  .ORDER_queryAllRows();
                              print('search _query all rows:');
                              allRows.forEach(print);
                              allRows.forEach((row) =>
                                  dataLists.add(
                                      NotificationReceive.fromJson(row)));

                              for (var item in dataLists) {
                                print(item.body);
                                if (item.body.contains(
                                    _searchcontroller.text) ||
                                    item.body == (_searchcontroller.text)) {
                                  SearchLists.add(item);
                                }
                              }
                              print(SearchLists.length);

                              setState(() {
                                isLoading = "true";


                                print("yesy");


                                if (SearchLists.length != 0) {
                                  print("tggg");
                                  isLoading = "false";

                                  // _wait();
                                  Search_List.dataList = SearchLists;
                                }
                                else {
                                  print("no result");
                                  isLoading = "no result";
                                }
                              });
                            }
                            //both
                            else if (_searchcontroller.text != "" &&
                                selectval != "النوع") {
                              final allRows = await dbHelper
                                  .ORDER_queryAllRows();
                              print('search _query all rows:');
                              allRows.forEach(print);
                              allRows.forEach((row) =>
                                  dataLists.add(
                                      NotificationReceive.fromJson(row)));

                              for (var item in dataLists) {
                                print(item.body);
                                if (item.body.contains(
                                    _searchcontroller.text) &&
                                    item.main_label == selectval) {
                                  SearchLists.add(item);
                                }
                              }
                              print(SearchLists.length);

                              setState(() {
                                isLoading = "true";


                                print("yesy");


                                if (SearchLists.length != 0) {
                                  print("tggg");
                                  isLoading = "false";

                                  // _wait();
                                  Search_List.dataList = SearchLists;
                                }
                                else {
                                  print("no result");
                                  isLoading = "no result";
                                }
                              });
                            }
                          },
                          child: Image.asset(
                            'images/Search-btn.png',
                            height: 100,
                            width: 80,


                          ),
                        ),
                         Container(
                          width: 85,
                          height: 25,

                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: CustomColors.backgroundColor)),


                          child: DropdownButton(

                            value: selectval,
                            icon: Icon(                // Add this
                              Icons.arrow_drop_down,  // Add this
                              color: CustomColors.backgroundColor,   // Add this
                            ),
                            items: countries.map((country) {
                              return DropdownMenuItem(
                                child: SizedBox(
                                  width: 50,
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
                        ),
                         SizedBox(width: 5,),
                         Container(
                          width: 150,
                          height: 25,
                          child: TextFormField(

                              textAlign: TextAlign.right,
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (_newValue) {

                                setState(() {

                                });

                              },


                              controller: _searchcontroller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                hintText:"ادخل نص البحث",
                                hintStyle: TextStyle(
                                    fontSize: 13.0,color: Colors.grey,fontFamily: "Al-Jazeera-Arabic-Regular"
                                ),



                                // label: Center(
                                //   child: Text(lableText,style: TextStyle(
                                //       fontSize: 14.0,color: Color(0xFF44a2a9),fontFamily: "Al-Jazeera-Arabic-Regular"
                                //   ),),
                                // ),


                                //
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                                focusedBorder: myfocusborder(),
                              )
                          ),
                        )
                        ,SizedBox(width: 5,)


                      ],
                    ),

                  ),


                  SearchLists.length > 0 && isLoading == "false"
                      ? Search_List()
                      : isLoading == "no result" ? Container(
                    child:
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "لا يوجد بيانات",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF686868),
                              fontFamily: "Al-Jazeera-Arabic-Bold"),
                        ),
                      ),
                    ),
                  ) :

                  isLoading == "true" ? Container(
                    padding: const EdgeInsets.all(50),
                    margin: const EdgeInsets.all(50),
                    color: Colors.white,
                    //widget shown according to the state
                    child: Center(
                      child:
                      CircularProgressIndicator(),
                    ),


                  ) : Container()


                  // Search_List()
                ],
              )
              ,


            )
          ],
        ),
      );
    }







  }








  OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
    return OutlineInputBorder( //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color:Color(0xFF44a2a9),
          width: 1,
        )
    );
  }

  OutlineInputBorder myfocusborder(){
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color:Color(0xFF44a2a9),
          width: 1,
        )
    );
  }

}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}