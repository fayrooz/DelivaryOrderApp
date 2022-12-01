import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ApiDataReceive.dart';
import '../Models/ApiDataSend.dart';
import '../Models/ChattingGroupReturn.dart';
import '../Models/ReturnedApiLoginData.dart';
import '../Models/user/user_info.dart';
import '../Util/Constants.dart';
import 'logging.dart';



class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://palestine.o1solutions.com/api/Mobile',
      connectTimeout: 5000,
      receiveTimeout: 3000,
        headers: {"Content-Type": "application/json"}

    ),
  )..interceptors.add(Logging());





  Future<ReturnedApiLoginData?> createUser({required UserInfo userInfo}) async {
    ReturnedApiLoginData? retrievedUser;

    try {
      Response response = await _dio.post(
        BaseURL + '/api/Mobile/login',
        data: userInfo.toJson(),
      );

      print('User created: ${response.data}');

      retrievedUser = ReturnedApiLoginData.fromJson(response.data);
      return retrievedUser;

    } catch (e) {
      print('Error creating user: $e');
      return null;
    }


  }

  Future<List<chattingGroupReturn>> createchattingGroupService({required ApiDataSend userInfo}) async {
    List<chattingGroupReturn> retrievedUser = [];





 var token  = userInfo.token;
    Dio _ChattGdio = Dio(
      BaseOptions(
          baseUrl:  BaseURL + '/api/Mobile',
          connectTimeout: 5000,
          receiveTimeout: 3000,
          headers: {'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "content-type":"application/json"}

      ),
    )..interceptors.add(Logging());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String FCMtoken = prefs.getString("FCMtoken") ?? "";

    try {

      Response response = await _ChattGdio.post(
        BaseURL + '/api/Mobile/CustomerMessageGroups',
        data:   {"customerId": userInfo.customerId,
        "deviceOsTypeId": 1,
        "token": FCMtoken},
      );

      print("CustomerMessageGroups");
      print({"customerId": userInfo.customerId,
        "deviceOsTypeId": 1,
        "token": FCMtoken});


      print('CustomerMessageGroups created: ${response.data}');

      retrievedUser =
          (response.data as List).map((x) => chattingGroupReturn.fromJson(x))
          .toList(); ;
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }


  Future<List<ChattingReturn>> createChattingService({required ApiDataSend userInfo}) async {
    List<ChattingReturn> retrievedUser = [];
    //String ErrorM = "";

    print("Chatting.customerId");
    print(Chatting.customerId);

    print("ChattingGroup.groupid");
    print(ChattingGroup.groupid);



    var token  = userInfo.token;
    Dio _ChattGdio = Dio(
      BaseOptions(
          baseUrl:  BaseURL + '/api/Mobile',
          connectTimeout: 5000,
          receiveTimeout: 3000,
          headers: {'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "content-type":"application/json"}

      ),
    )..interceptors.add(Logging());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String FCMtoken = prefs.getString("FCMtoken") ?? "";

    try {

      Response response = await _ChattGdio.post(
        BaseURL + '/api/Mobile/CustomerMessageByGroup',
         data:   {
          "customerId": Chatting.customerId,
          "deviceOsTypeId": 1,
          "token": FCMtoken,
          "pageNumber": ChattingGroup.pageNumber,
          "rowsOfPage": 5,
          "groupId": ChattingGroup.groupid,},
      );

      print({
        "customerId": Chatting.customerId,
        "deviceOsTypeId": 1,
        "token": FCMtoken,
        "pageNumber": ChattingGroup.pageNumber,
        "rowsOfPage": 5,
        "groupId": ChattingGroup.groupid,});

      print('CustomerMessage created: ${response.data}');
    //  ErrorM = response.data;

      retrievedUser =
          (response.data as List).map((x) => ChattingReturn.fromJson(x))
              .toList(); ;

    }

    catch (e) {

      ErrorMsg ='Error : $e';

      print('Error : $e');


    }

    return retrievedUser;

  }




  SendMessageService({required ApiDataSend userInfo}) async {


    var token  = userInfo.token;
    Dio _ChattGdio = Dio(
      BaseOptions(
          baseUrl:  BaseURL + '/api/Mobile',
          connectTimeout: 5000,
          receiveTimeout: 3000,
          headers: {'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "content-type":"application/json"}

      ),
    )..interceptors.add(Logging());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String FCMtoken = prefs.getString("FCMtoken") ?? "";

    try {

      Response response = await _ChattGdio.post(
        BaseURL + '/api/Mobile/SendMessage',
        data:   { "customerId": Chatting.customerId,
          "deviceOsTypeId": 1,
          "token": FCMtoken,
          "msgText":  SendMessageChatting.msgText,
          "isAdminSender" :  SendMessageChatting.isAdmisender,
          "adminSenderName": SendMessageChatting.adminSenderName,
          "groupId": ChattingGroup.groupid,},
      );

      print('SendMessageService: ${response.data}');






    }

    catch (e) {

      ErrorMsg ='SendMessageService: $e';
    }



  }


  deleteUser({required ApiDataSend userInfo}) async {
    String retrievedUser = "";
    var token  = userInfo.token;
    final Dio _dio = Dio(
      BaseOptions(
          baseUrl:  BaseURL + '/api/Mobile',
          connectTimeout: 5000,
          receiveTimeout: 3000,
          headers: {'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "content-type":"application/json"}

      ),
    )..interceptors.add(Logging());


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String FCMtoken = prefs.getString("FCMtoken") ?? "";

    try {
      Response response = await _dio.post(
        BaseURL + '/api/Mobile/logout',
        data: {"customerId": userInfo.customerId,
          "deviceOsTypeId": 1,
          "token": FCMtoken},
      );

      print('delete created: ${response.data}');

      retrievedUser = response.data;
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }

  deletePuplic() async {
    String retrievedUser = "";

    final Dio _dio = Dio(
      BaseOptions(
          baseUrl:  BaseURL + '/api/Mobile',
          connectTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            "Accept": "application/json",
            "content-type":"application/json"}

      ),
    )..interceptors.add(Logging());


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String FCMtoken = prefs.getString("FCMtoken") ?? "";

    try {
      Response response = await _dio.post(
        BaseURL + '/api/Mobile/logoutpuplic',
        data: {
          "token": FCMtoken},
      );

      print('delete created: ${response.data}');

      retrievedUser = response.data;
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }




  Future<List<LatestChattingReturn>> getLatestChattingService({required ApiDataSend userInfo}) async {
    List<LatestChattingReturn> retrievedUser = [];




    var token  = userInfo.token;
    Dio _ChattGdio = Dio(
      BaseOptions(
          baseUrl:  BaseURL + '/api/Mobile',
          connectTimeout: 5000,
          receiveTimeout: 3000,
          headers: {'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "content-type":"application/json"}

      ),
    )..interceptors.add(Logging());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String FCMtoken = prefs.getString("FCMtoken") ?? "";

    try {

      String userType = prefs.getString("userType") ?? "customer";
      String url = "";
      if (userType == "customer"){
        url = "CustomerLatestMessages";
      }else{
        url = "AdminLatestMessages";
      }

      Response response = await _ChattGdio.post(
        BaseURL + '/api/Mobile/'+ url,
        data:   {
          "customerId": Chatting.customerId,
          "deviceOsTypeId": 1,
          "token": FCMtoken,
          "pageNumber": LatestChattingReturnConst.pageNumber,
          "rowsOfPage": 10,
          },
      );


      print( {
        "customerId": Chatting.customerId,
        "deviceOsTypeId": 1,
        "token": FCMtoken,
        "pageNumber": LatestChattingReturnConst.pageNumber,
        "rowsOfPage": 10,
      });
      //  ErrorM = response.data;

      retrievedUser =
          (response.data as List).map((x) => LatestChattingReturn.fromJson(x))
              .toList(); ;

              print(retrievedUser);

    }

    catch (e) {

      ErrorMsg ='Error : $e';

      print('Error : $e');


    }

    return retrievedUser;

  }


}
