// To parse this JSON data, do
//
//     final userDetailsWithPin = userDetailsWithPinFromJson(jsonString);

import 'dart:convert';

UserDetailsWithPin userDetailsWithPinFromJson(String str) => UserDetailsWithPin.fromJson(json.decode(str));

String userDetailsWithPinToJson(UserDetailsWithPin data) => json.encode(data.toJson());

class UserDetailsWithPin {
    UserDetailsWithPin({
        this.status,
        this.message,
        this.data,
    });

    int? status;
    String? message;
    Data? data;

    factory UserDetailsWithPin.fromJson(Map<String, dynamic> json) => UserDetailsWithPin(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.customerId,
        this.status,
        this.amount,
        this.isSubAccount,
        this.id,
        this.wallets,
        this.fullname,
        this.username,
        this.email,
        this.phone,
        this.pin,
        this.avatar,
        this.confirmationCode,
        this.qrcode,
        this.dataId,
    });

    CustomerId? customerId;
    String? status;
    double? amount;
    String? isSubAccount;
    String? id;
    List<Wallet>? wallets;
    String? fullname;
    String? username;
    String? email;
    String? phone;
    String? pin;
    String? avatar;
    String? confirmationCode;
    String? qrcode;
    String? dataId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerId: CustomerId.fromJson(json["customerId"]),
        status: json["status"],
        amount: json["amount"].toDouble(),
        isSubAccount: json["isSubAccount"],
        id: json["_id"],
        wallets: List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
        fullname: json["fullname"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        pin: json["pin"],
        avatar: json["avatar"],
        confirmationCode: json["confirmationCode"],
        qrcode: json["qrcode"],
        dataId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "customerId": customerId!.toJson(),
        "status": status,
        "amount": amount,
        "isSubAccount": isSubAccount,
        "_id": id,
        "wallets": List<dynamic>.from(wallets!.map((x) => x.toJson())),
        "fullname": fullname,
        "username": username,
        "email": email,
        "phone": phone,
        "pin": pin,
        "avatar": avatar,
        "confirmationCode": confirmationCode,
        "qrcode": qrcode,
        "id": dataId,
    };
}

class CustomerId {
    CustomerId({
        this.racks,
        this.chi,
    });

    String? racks;
    String? chi;

    factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
        racks: json["racks"],
        chi: json["chi"],
    );

    Map<String, dynamic> toJson() => {
        "racks": racks,
        "chi": chi,
    };
}

class Wallet {
    Wallet({
        this.id,
        this.transactions,
        this.balance,
        this.type,
        this.owner,
    });

    String? id;
    List<Transaction>? transactions;
    int? balance;
    String? type;
    String? owner;

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
        balance: json["balance"],
        type: json["type"],
        owner: json["owner"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "balance": balance,
        "type": type,
        "owner": owner,
    };
}

class Transaction {
    Transaction({
        this.meta,
        this.description,
        this.newBalance,
        this.amount,
    });

    Meta? meta;
    String? description;
    int? newBalance;
    int? amount;

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        meta: Meta.fromJson(json["meta"]),
        description: json["description"],
        newBalance: json["newBalance"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "meta": meta!.toJson(),
        "description": description,
        "newBalance": newBalance,
        "amount": amount,
    };
}

class Meta {
    Meta({
        this.date,
    });

    Date? date;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        date: Date.fromJson(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "date": date!.toJson(),
    };
}

class Date {
    Date({
        this.seconds,
        this.nanoseconds,
    });

    int? seconds;
    int? nanoseconds;

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
    );

    Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
    };
}
