// To parse this JSON data, do
//
//     final TransactionModel = TransactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel TransactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String TransactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
    TransactionModel({
        this.status,
        this.message,
        this.data,
    });

    int? status;
    String? message;
    List<TransactionData>? data;

    factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        status: json["status"],
        message: json["message"],
        data: List<TransactionData>.from(json["data"].map((x) => TransactionData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TransactionData {
    TransactionData({
        this.transactionDate,
        this.currency,
        this.paymentMethod,
        this.status,
        this.senderId,
        this.transactionAmount,
        this.description,
        this.recipientId,
        this.type,
        this.eventId,
        this.transactionId,
    });

    String? transactionDate;
    String? currency;
    String? paymentMethod;
    String? status;
    List<String>? senderId;
    double? transactionAmount;
    String? description;
    String? recipientId;
    String? type;
    String? eventId;
    String? transactionId;

    factory TransactionData.fromJson(Map<String, dynamic> json) => TransactionData(
        transactionDate: json["transaction_date"],
        currency: json["currency"],
        paymentMethod: json["payment_method"],
        status: json["status"],
        senderId: List<String>.from(json["sender_id"].map((x) => x)),
        transactionAmount: json["transaction_amount"].toDouble(),
        description: json["description"],
        recipientId: json["recipient_id"],
        type: json["type"],
        eventId: json["event_id"] == null ? null : json["event_id"],
        transactionId: json["transaction_id"],
    );

    Map<String, dynamic> toJson() => {
        "transaction_date": transactionDate,
        "currency": currency,
        "payment_method": paymentMethod,
        "status": status,
        "sender_id": List<dynamic>.from(senderId!.map((x) => x)),
        "transaction_amount": transactionAmount,
        "description": description,
        "recipient_id": recipientId,
        "type": type,
        "event_id": eventId == null ? null : eventId,
        "transaction_id": transactionId,
    };
}
