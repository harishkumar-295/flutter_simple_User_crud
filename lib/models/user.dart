// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetAllUsers welcomeFromJson(String str) =>
    GetAllUsers.fromJson(json.decode(str));

String welcomeToJson(GetAllUsers data) => json.encode(data.toJson());

class GetAllUsers {
  GetAllUsers({
    required this.msg,
    required this.success,
    required this.users,
  });

  final String msg;
  final bool success;
  final List<User> users;

  factory GetAllUsers.fromJson(Map<String, dynamic> json) => GetAllUsers(
        msg: json["msg"],
        success: json["success"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "success": success,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  User({
    required this.contact,
    required this.id,
    required this.name,
  });

  final String contact;
  final int id;
  final String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        contact: json["contact"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "contact": contact,
        "id": id,
        "name": name,
      };
}

AddUser addwelcomeFromJson(String str) => AddUser.fromJson(json.decode(str));
String addwelcomeToJson(AddUser data) => json.encode(data.toJson());

class AddUser {
  AddUser({
    required this.msg,
    required this.success,
    required this.user,
  });

  final String msg;
  final bool success;
  final User user;

  factory AddUser.fromJson(Map<String, dynamic> json) => AddUser(
      msg: json["msg"],
      success: json["success"],
      // user: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      user: User.fromJson(json['user']));

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "success": success,
        "users": user.toJson(),
      };
}
