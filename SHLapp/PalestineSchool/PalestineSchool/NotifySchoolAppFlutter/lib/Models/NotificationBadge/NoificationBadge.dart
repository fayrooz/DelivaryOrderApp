import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class NotificationReceive {


  final int id;
  final String title;
  final  String body;
  final  String date_ts;
  final  String? main_label;
  final  String? secondary_label;
  final  String? url_link;
  final  String time_ts;
  final  String? isSeen;

  NotificationReceive.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        body = json['body'],
        date_ts = json['datets'],
        main_label = json['mainlabel'],
        secondary_label = json['secondarylabel'],
        time_ts = json['timets'],
        url_link = json['urllink'],
        isSeen= json['isSeen']
  ;
}



