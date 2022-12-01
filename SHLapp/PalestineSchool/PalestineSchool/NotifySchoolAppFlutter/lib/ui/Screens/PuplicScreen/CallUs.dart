
import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:schools_notifysystem/Util/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(CallUs());

class CallUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        backgroundColor: Colors.white,
        body
      : SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Center(
                child:
                Container(

                  height: 70,
                  width: 70,

                  child: CircleAvatar(

                    backgroundImage: AssetImage('images/ll.jpg'),
                    maxRadius: 15,
                    minRadius: 15,
                  ),
                ),
              ),

              SizedBox(height: 15,),

              Center(
                child: Text(
                  "جميع الحقوق محفوظة لروضة ومدارس فلسطين",
                  style: TextStyle(
                    fontFamily:  "Al-Jazeera-Arabic-Bold",
                    fontSize:  17.0,
                    color: Colors.black54,
                    fontWeight:  FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                "تطوير شركة نيوسوفت"
                    ,
                style: TextStyle(
                  fontFamily:  "Al-Jazeera-Arabic-Bold",
                  fontSize:  17,
                  color: Colors.black54,
                  fontWeight:  FontWeight.bold,
                ),
              ),
              SizedBox(height: 5,),
              Text(

                    "محمد هلالي",
                style: TextStyle(
                  fontFamily:  "Al-Jazeera-Arabic-Bold",
                  fontSize:  17.0,
                  color: Colors.black54,
                  fontWeight:  FontWeight.bold,
                ),
              ),

              SizedBox(height: 4,),


              Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 40.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: CustomColors.backgroundColor,
                child: ListTile(
                  leading: Icon(Icons.phone,color: Colors.white,),
                  title: Text(

                    '+970595337070',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Al-Jazeera-Arabic-Bold",
                    ),
                  ),
                  onTap: () => showAlert(context,"1"),
                ),
              ),
              SizedBox(height: 8,),
              Divider(
                color:  CustomColors.backgroundColor,
                thickness:  3.0,
                indent: 30.0,
                endIndent: 30.0,
              ),
              SizedBox(height: 8,),
              Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 40.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: CustomColors.backgroundColor,
                child: ListTile(
                  leading: Icon(Icons.phone,color: Colors.white,),
                  title: Text(

                    'المدرسة - 092330071',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Al-Jazeera-Arabic-Bold",
                    ),
                  ),
                  onTap: () => showAlert(context,"2"),
                ),
              ),



              Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 40.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: CustomColors.backgroundColor,
                child: ListTile(
                  leading: Icon(Icons.phone,color: Colors.white,),
                  title: Text(

                    '+الروضة - 970592330071',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Al-Jazeera-Arabic-Bold",
                    ),
                  ),
                  onTap: () => showAlert(context,"3"),
                ),
              ),



              Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 40.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: CustomColors.backgroundColor,
                child: ListTile(
                  leading: Icon(Icons.phone,color: Colors.white,),
                  title: Text(

                    '+المحاسبة - 970592330071',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Al-Jazeera-Arabic-Bold",
                    ),
                  ),
                  onTap: () => showAlert(context,"3"),
                ),
              )

              ,Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 40.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: CustomColors.backgroundColor,
                child: ListTile(
                  leading: Icon(Icons.email
                    ,color: Colors.white,),
                  title: Text(

                    ' palschool2016@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Al-Jazeera-Arabic-Bold",
                    ),
                  ),
                  onTap: () => showAlert(context,"4"),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }

  showAlert(BuildContext context, String flage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 8.0,
          contentPadding: EdgeInsets.all(18.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          content: Container(
            child: flage == "1"? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                InkWell(
                  onTap: () =>
                      launch('tel:' + "+970595337070"),
                  child: Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    child: Text('Call'),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => launch('sms:' + "+970595337070"),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Text('Message'),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => launch('https://wa.me/' + "+970595337070"),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Text('WhatsApp'),
                  ),
                )

              ],
            ):
                flage == "2"? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    InkWell(
                      onTap: () =>
                          launch('tel:' + "092330071"),
                      child: Container(
                        height: 50.0,
                        alignment: Alignment.center,
                        child: Text('Call'),
                      ),
                    ),



                  ],
                ):
                    flage == "3"?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        InkWell(
                          onTap: () =>
                              launch('tel:' + "+970592330071"),
                          child: Container(
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Text('Call'),
                          ),
                        ),



                      ],
                    ):Column()


          ),
        );
      },
    );
  }
}