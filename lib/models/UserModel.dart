// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.status,
        this.message,
        this.token,
        this.user,
    });

    int? status;
    String? message;
    String? token;
    User? user;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user!.toJson(),
    };
}

class User {
    User({
        this.username,
        this.fullname,
        this.email,
        this.phone,
        this.avatar,
        this.amount,
        this.qrcode,
    });

    String? username;
    String? fullname;
    String? email;
    String? phone;
    String? avatar;
    double? amount;
    String? qrcode;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        amount: json["amount"].toDouble(),
        qrcode: json["qrcode"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "amount": amount,
        "qrcode": qrcode,
    };
}
