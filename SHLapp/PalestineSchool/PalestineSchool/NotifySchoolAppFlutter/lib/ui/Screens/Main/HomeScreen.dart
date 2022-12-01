// ignore: duplicate_ignore
// ignore: file_names

// ignore_for_file: file_names, unnecessary_new

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:schools_notifysystem/Util/Constants.dart';
import 'package:schools_notifysystem/ui/Screens/LoginUserScreen/ChattingScreen.dart';
import 'package:schools_notifysystem/ui/Screens/LoginUserScreen/SearchScreen.dart';
import 'package:schools_notifysystem/ui/Screens/LoginUserScreen/SyncPage.dart';
import 'package:schools_notifysystem/ui/Screens/LoginUserScreen/ChattingGroupScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../../Models/ApiDataSend.dart';
import '../../../Models/ChattingGroupReturn.dart';
import '../../../Models/NotificationBadge/NoificationBadge.dart';
import '../../../Models/ReturnedApiLoginData.dart';

import '../../../Services/dio_client.dart';
import '../../../Util/ChattingGroupDbHelper.dart';
import '../../../Util/NewsDataBaseHelper.dart';
import '../../../Util/NotificationSqlHelper.dart';
import '../../../Util/SQLHelper.dart';
import '../../../Widgets/SideMenu.dart';
import '../LoginUserScreen/AdminGroupStudentScreen.dart';
import '../LoginUserScreen/LatestChattingScreen.dart';
import '../PuplicScreen/CallUs.dart';
import '../PuplicScreen/NewsScreen.dart';
import '../LoginUserScreen/NotificationScreen.dart';

import '../LoginUserScreen/StudentesScreen.dart';
import '../../list/inform_list.dart';
import 'loginScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class HomeScreen extends StatefulWidget{

  int selectedIndex;
  HomeScreen(this.selectedIndex);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }

}


class _HomeScreenState extends State<HomeScreen> {

  PageController? _pageController  ;
  final DioClient _dioClient = DioClient();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int bottomSelectedIndex = 0;
  late SharedPreferences prefs;
  String _isLogin = "false";
  String _isnotifi = "false";
  String _customerName = "";
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  final dbHelper = DatabaseHelper.instance;
  List<ReturnedApiLoginData> data = [];
  final dbHelper_notification = NotificationDatabaseHelper.instance;
  final dbHelper_news = NewsDatabaseHelper.instance;
  final dbHelper_login = DatabaseHelper.instance;
  final dbHelper_ChattingGroup = ChattingGroupHelper.instance;

  List<ReturnedApiLoginData> dataLists_login = [];
  List<NotificationReceive> dataLists = [];
  List<NotificationReceive> dataLists_news = [];

  List<ChattingGroupReturn> dataLists_chattngGroup = [];
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void initState()  {
 //   getConnectivity();
    super.initState();
    _pageController = PageController(initialPage: widget.selectedIndex ) ;
     print('rrr');
  }



  @override
  void dispose() {
   _pageController?.dispose();
    subscription.cancel();
    super.dispose();
  }


  isLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String isLogin = prefs.getString("isLogin") ?? "false";

  String isnotifi = prefs.getString("isnotifi") ?? "false";
  String customerName = prefs.getString("customerName") ?? "";

  setState(() {
     //fetch();
    _isLogin = isLogin;
    _isnotifi  = isnotifi;
    _customerName = customerName;

    if (_isnotifi == "true") {

        prefs.setString("isnotifi", "false");
        bottomSelectedIndex = 0;

    }
  });

  print(_isLogin);

}

  @override
  void didChangeDependencies() {
    print("gggg");
    isLogin();
  }




  @override
  Widget build(BuildContext context) {



    print('Widget build');


    return Scaffold(

        key: _scaffoldKey,
        endDrawer:_buildDrawer(),


        resizeToAvoidBottomInset: false,

        floatingActionButton:CustomFloatingActionButton(),

        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    //floating action button location to left

        bottomNavigationBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: CustomBottomAppBar()),

       body:buildPageView()


    );

  }

  Widget CustomFloatingActionButton(){
    return FloatingActionButton(
      backgroundColor: Color(0xFF44A2A9),
      //Floating action button on Scaffold
      onPressed: (){
        bottomTapped(3);
      },

      child: Image.asset('images/MSG_ICO_MENU.png'), //icon inside button
    );


  }

  // ignore: non_constant_identifier_names
  Widget CustomBottomAppBar(){
    return BottomAppBar( //bottom navigation bar on scaffold
      // ignore: prefer_const_constructors
      color:Color(0xFF44A2A9),
      // ignore: prefer_const_constructors
      shape: CircularNotchedRectangle(), //shape of notch
      notchMargin: 5, //notche margin between floating button and bottom appbar
      child: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.all(10),
        child: Row( //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(left:90),
              child:InkWell(
                  onTap: (){setState(() {

               bottomTapped(2);
              });
                  }, child: Image.asset('images/Sync.png',width: 30,height: 30,)),

            ),


            InkWell(
                onTap: () {
                  setState(() {
                    bottomTapped(1);
                  });
                } ,child: Image.asset('images/users.png',width: 30,height: 30)),





            InkWell(

                onTap: (){
                  setState(() {
                   bottomTapped(0);
                  });
                },
                child: Image.asset('images/Home.png',width: 30,height: 30,)),


            InkWell(
              onTap: (){
              //  PopshowDialogBox();
               // Scaffold.of(context).openEndDrawer();
                _scaffoldKey.currentState?.openEndDrawer();

               },
                child: Image.asset('images/Bar.png',width: 30,height: 30,)),

          ],
        ),
      ),
    );


  }

  PopshowDialogBox() =>
      showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('تنبيه'),
      content: const Text('هل تود التاكيد على تسجل الخروج'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {


            if (_isLogin != "false"){


      final allRows = await dbHelper.queryAllRows();

      allRows.forEach(print);

      allRows.forEach((row) => data.add(ReturnedApiLoginData.fromJson(row)));



      int? id = await dbHelper.queryRowCount();

      int maxid = id ?? 0;


      ApiDataSend obj = ApiDataSend(deviceOsTypeId: 1,
      customerId: data[maxid - 1].customerId,
       token: data[maxid - 1].token, maxId: 0);

         showLoaderDialog(context);
         String returnData =
            await _dioClient.deleteUser(userInfo: obj);

          if (returnData.contains("Successfully")) {


            Navigator.pop(context, 'Cancel');

            prefs = await SharedPreferences.getInstance();
            prefs.setString("isLogin", "false");

            dbHelper_login.deleteAll();
            dbHelper_ChattingGroup.deleteAll();
            dbHelper_notification.deleteAll();
            dbHelper_news.deleteAll();

            Navigator.of(context, rootNavigator: true).pop("Discard");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => loginPage()));

           }

          else{
            showAlertDialog(context , "نبيه" , "خطا في عملية الاتصال حاول لاحقا");
            Navigator.of(context, rootNavigator: true).pop("Discard");
          }


            }



            else{



              showLoaderDialog(context);

     String returnData =
    await _dioClient.deletePuplic();

        //  if (returnData.contains("Successfully")) {


         prefs = await SharedPreferences.getInstance();

         prefs.setString("isLogin_p", "false");

         dbHelper_login.deleteAll();
         dbHelper_ChattingGroup.deleteAll();
         dbHelper_notification.deleteAll();
         dbHelper_news.deleteAll();

         Navigator.of(context, rootNavigator: true).pop("Discard");
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => loginPage()));

            }
          },
          child: const Text('موافق'),
        ),

        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');

          },
          child: const Text('الغاء'),
        )
      ],
    ),
  );





  Widget buildPageView() {

    return PageView(

      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,


      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        _isLogin == "false" ?  NewsScreen() :  NotificationScreen(),
        StudentsScreen(),
        SyncScreen(),
        ChattingGroupScreen(),
        SearchScreen(),
        ChattingScreen(),
        AdminGroupStudentScreen(),
        CallUs(),
        LatestChattingScreen()


      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      _pageController?.jumpToPage(bottomSelectedIndex);
      //_pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }


  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );




  Drawer _buildDrawer() {
  return  Drawer(


      backgroundColor: CustomColors.backgroundColor,


      child: Column(
        mainAxisSize: MainAxisSize.max,
          children: <Widget>[
             Expanded(
          child: ListView(


            children: <Widget>[
              DrawerHeader(

                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      CustomColors.backgroundColor,
                      CustomColors.backgroundColor
                    ])
                ),
                child:
                Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child:
                      Container(

                        height: 90,
                        width: 90,

                        child: CircleAvatar(

                          backgroundImage: AssetImage('images/ll.jpg'),
                          maxRadius: 15,
                          minRadius: 15,
                        ),
                      ),
                    ),


                    Text(
                      "روضة ومدرسة فلسطين",
                      style: TextStyle(
                          fontSize: 21.0,
                          color: Color(0xFFF1F1F1),
                          fontFamily: "Al-Jazeera-Arabic-Bold"),
                    ),

                    SizedBox(height: 13,),

                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 30 ,
                         height: 40,
                      child: TextButton(

                          style: ButtonStyle(

                            backgroundColor:


                            MaterialStateProperty.all( Color(0xFFD9EFF1)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                          ),
                          onPressed: () {},
                          child: Text(
                            _customerName,
                            style: TextStyle(color: CustomColors.backgroundColor,fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 17),
                          )


                      ),
                    )

                    //                 Padding(
    //                padding: EdgeInsets.only(right: 10,left: 10),
    //               child: Container(
    //              decoration: const BoxDecoration(
    //           color: Color(0xFFD9EFF1),
    //         borderRadius: BorderRadius.all(
    //       Radius.circular(25),
    //        ),
    //       ),
    // height:50,
    // width: double.infinity,
    //           child: Center(
    //             child: Text(_customerName, textAlign: TextAlign.center, style: TextStyle(
    //                 fontSize: 17.0,
    //
    //                 color: CustomColors.backgroundColor,
    //                 fontFamily: "Al-Jazeera-Arabic-Bold")),
    //           ) ,
    //           ),
    //           ),
                 ],
                ),
              ),

              SizedBox(height: 25,),

              Padding(
                padding: EdgeInsets.only(right: 20,left: 20,top: 20),
                child: Container(

                    decoration: BoxDecoration(

                        border: Border(bottom: BorderSide(color: Colors.white))
                    )
                      ),
              ),
              CustomListTile('الرئيسية','images/Home.png'),
              CustomListTile( 'الطلاب' , 'images/users.png'),
              CustomListTile('تحميل الاشعارات','images/Sync.png'),
              CustomListTile('تواصل معنا','images/users.png'),
            ],




          ),
        ),

            Padding(
              padding: EdgeInsets.only(bottom: 44),
              child: Container(
                // This align moves the children to the bottom
                  child: Align(
                      alignment: FractionalOffset.bottomLeft,
                      // This container holds all the children that will be aligned
                      // on the bottom and should not scroll with the above ListView
                      child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[


                              ListTile(
                                  leading:  TextButton(


                                      style: ButtonStyle(


                                        backgroundColor:


                                        MaterialStateProperty.all( Color(0xFFD9EFF1)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(23.0))),
                                      ),
                                      onPressed: () {
                                        PopshowDialogBox();

                                      },
                                      child: Text(
                                        "تسجيل الخروج",
                                        style: TextStyle(color: CustomColors.backgroundColor,fontFamily: "Al-Jazeera-Arabic-Regular",fontSize: 13),
                                      )


                                  ),
                                  ),

                            ],
                          )
                      )
                  )
              ),
            )
          ],
      ),
    );
  }

 Widget CustomListTile(String text,String icon  ){
   return Center(

     child:Padding(
       padding: EdgeInsets.only(right: 20,left: 20),
       child: Container(

         decoration: BoxDecoration(

             border: Border(bottom: BorderSide(color: Colors.white))
         ),
         child: InkWell(
             splashColor: Colors.orangeAccent,
             onTap: (){

               CustomColors.index = 1;
               Navigator.pop(context);

               if (text == "الرئيسية"){
                 bottomTapped(0);
               }else if (text == "الطلاب"){
                 bottomTapped(1);
               }else if (text == "تحميل الاشعارات"){
                 bottomTapped(2);
               }else{
                 bottomTapped(7);
               }


             },
             child: Padding(
               padding: EdgeInsets.only(right: 20),
               child: Container(
                   height: 55,
                   child: Row(

                     mainAxisAlignment : MainAxisAlignment.end,
                     children: <Widget>[
                       Row(children: <Widget>[

                         Text(text,  style: TextStyle(
                             fontSize: 18.0,
                             color: Color(0xFFF1F1F1),
                             fontFamily: "Al-Jazeera-Arabic-Bold")),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                         ),
                         Image.asset(icon,width: 30,height: 30),


                       ],),

                     ],)
               ),
             )
         ),
       ),
     ),
   );

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