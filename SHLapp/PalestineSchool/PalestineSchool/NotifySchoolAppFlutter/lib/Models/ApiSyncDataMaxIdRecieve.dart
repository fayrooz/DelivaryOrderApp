import 'dart:convert';

ApiSyncDataMaxIdRecieve apiSyncDataMaxIdRecieveFromJson(String str) => ApiSyncDataMaxIdRecieve.fromJson(json.decode(str));

String apiSyncDataMaxIdRecieveToJson(ApiSyncDataMaxIdRecieve data) => json.encode(data.toJson());

class ApiSyncDataMaxIdRecieve {
  ApiSyncDataMaxIdRecieve({
    required this.msgId,
    required this.msgText,
    required this.msgFromAdmin,
    required this.msgReadAdmin,
    required this.msgReadUser,
    required this.parentMsgId,
    required this.xMsgTs,
  });

  int msgId;
  String msgText;
  bool msgFromAdmin;
  String msgReadAdmin;
  String msgReadUser;
  int parentMsgId;
  String xMsgTs;

  factory ApiSyncDataMaxIdRecieve.fromJson(Map<String, dynamic> json) => ApiSyncDataMaxIdRecieve(
    msgId: json["MsgId "],
    msgText: json["MsgText "],
    msgFromAdmin: json["MsgFromAdmin "],
    msgReadAdmin: json["MsgReadAdmin "],
    msgReadUser: json["MsgReadUser"],
    parentMsgId: json["ParentMsgId"],
    xMsgTs: json[" x.MsgTs"],
  );

  Map<String, dynamic> toJson() => {
    "MsgId ": msgId,
    "MsgText ": msgText,
    "MsgFromAdmin ": msgFromAdmin,
    "MsgReadAdmin ": msgReadAdmin,
    "MsgReadUser": msgReadUser,
    "ParentMsgId": parentMsgId,
    " x.MsgTs": xMsgTs,
  };
}



class NotificationDataReceive {


  final int id;
  final String title;
  final String body;
  final  String datets;
  final  String timets;
  final  String mainlabel;
  final  String? secondarylabel;
  final  String? urllink;



  NotificationDataReceive.fromJson(Map<String, dynamic> json)
      : id = json['nid'],
        title = json['title'],
        body = json['body'],
        timets = json['timets'],
        datets = json['datets'],
        mainlabel = json['mainlabel'],
        secondarylabel = json['secondarylabel'],
        urllink = json['urllink']
  ;
}


class NotifyDataReceive {



  final int id;
  final String title;
  final String body;
  final  String datets;
  final  String timets;
  final  String? mainlabel;
  final  String? secondarylabel;
  final  String? urllink;

  NotifyDataReceive.fromJson(Map<String, dynamic> json)
      : id = json['nid'],
        title = json['title'],
        body = json['body'],
        timets = json['timets'],
        datets = json['datets'],
        mainlabel = json['mainlabel'],
        secondarylabel = json['secondarylabel'],
        urllink = json['urllink']
  ;
}
