// To parse this JSON data, do
//
//     final AllEventModel = AllEventModelFromJson(jsonString);

import 'dart:convert';

AllEventModel AllEventModelFromJson(String str) => AllEventModel.fromJson(json.decode(str));

String AllEventModelToJson(AllEventModel data) => json.encode(data.toJson());

class AllEventModel {
    AllEventModel({
        this.status,
        this.message,
        this.data,
    });

    int? status;
    String? message;
    List<AllEvents>? data;

    factory AllEventModel.fromJson(Map<String, dynamic> json) => AllEventModel(
        status: json["status"],
        message: json["message"],
        data: List<AllEvents>.from(json["data"].map((x) => AllEvents.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class AllEvents {
    AllEvents({
        this.status,
        this.startDate,
        this.type,
        this.currency,
        this.amount,
        this.participantList,
        this.name,
        this.owner,
        this.eventCode,
        this.url,
        this.qrcode,
        this.startTime,
        this.participantCount,
        this.id,
    });

    String? status;
    String? startDate;
    String? type;
    String? currency;
    int? amount;
    List<EventOwner>? participantList;
    String? name;
    EventOwner? owner;
    String? eventCode;
    String? url;
    String? qrcode;
    String? startTime;
    int? participantCount;
    dynamic? id;

    factory AllEvents.fromJson(Map<String, dynamic> json) => AllEvents(
        status: json["status"],
        startDate: json["startDate"],
        type: json["type"],
        currency: json["currency"],
        amount: json["amount"],
        participantList: List<EventOwner>.from(json["participantList"].map((x) => EventOwner.fromJson(x))),
        name: json["name"],
        owner: EventOwner.fromJson(json["owner"]),
        eventCode: json["event_code"],
        url: json["url"],
        qrcode: json["qrcode"],
        startTime: json["startTime"],
        participantCount: json["participantCount"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "startDate": startDate,
        "type": type,
        "currency": currency,
        "amount": amount,
        "participantList": List<dynamic>.from(participantList!.map((x) => x.toJson())),
        "name": name,
        "owner": owner!.toJson(),
        "event_code": eventCode,
        "url": url,
        "qrcode": qrcode,
        "startTime": startTime,
        "participantCount": participantCount,
        "id": id,
    };
}

class EventOwner {
    EventOwner({
        this.id,
        this.fullname,
        this.username,
        this.avatar,
        this.ownerId,
    });

    String? id;
    String? fullname;
    String? username;
    String? avatar;
    String? ownerId;

    factory EventOwner.fromJson(Map<String, dynamic> json) => EventOwner(
        id: json["_id"],
        fullname: json["fullname"],
        username: json["username"],
        avatar: json["avatar"],
        ownerId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "username": username,
        "avatar": avatar,
        "id": ownerId,
    };
}
