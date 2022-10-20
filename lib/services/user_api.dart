import 'dart:convert';
import 'package:http/http.dart' as http;
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

  Future<AddUser> addUser(String name, String contact) async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:5000/user");
    var response = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'name': name, 'contact': contact}));
    if (response.statusCode == 200) {
      var json = response.body;
      // print(json.runtimeType);   // returns String type
      // return User.fromJson(jsonDecode(json));
      // print(json);
      return addwelcomeFromJson(json);
    } else {
      throw Exception("Failed to add user");
    }
  }
}
