import 'dart:convert';
import 'package:flask_rest_api_user_crud/constants/http_error_handling.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants/utils.dart';
import '../models/user.dart';

class UserAPI {
  Future<GetAllUsers?> getAllUsers() async {
    var client = http.Client();
    //http:127.0.0.1:5000/user
    var uri = Uri.parse("http://10.0.2.2:5000/user");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      // print(json.runtimeType);   // returns String type
      return welcomeFromJson(json);
    }
  }

  Future<AddUser?> addUser(
      String name, String contact, BuildContext context) async {
    var respBody;
    try {
      var client = http.Client();
      var uri = Uri.parse("http://10.0.2.2:5000/user");
      var response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, String>{'name': name, 'contact': contact}));
      // if (response.statusCode == 200) {
      //   var json = response.body;
      //   return addwelcomeFromJson(json);
      // }
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            respBody = response.body;
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // if (respBody == null) {
    //   return addwelcomeReturnNull();
    // }
    // print(respBody);
    if (respBody == null) {
      return null;
    }
    return addwelcomeFromJson(respBody);
  }

  Future<AddUser?> deleteUser(int id, BuildContext context) async {
    var respBody;
    try {
      var client = http.Client();
      var uri = Uri.parse("http://10.0.2.2:5000/user/$id");
      var response = await client.delete(
        uri,
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            respBody = response.body;
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    if (respBody == null) {
      return null;
    }
    return addwelcomeFromJson(respBody);
  }
}
