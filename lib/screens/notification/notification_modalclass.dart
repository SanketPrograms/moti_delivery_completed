// To parse this JSON data, do
//
//     final notificationModalClass = notificationModalClassFromJson(jsonString);

import 'dart:convert';

NotificationModalClass notificationModalClassFromJson(String str) => NotificationModalClass.fromJson(json.decode(str));

String notificationModalClassToJson(NotificationModalClass data) => json.encode(data.toJson());

class NotificationModalClass {
  NotificationModalClass({
    this.status,
    this.error,
    this.success,
    this.result,
  });

  String? status;
  int? error;
  int? success;
  List<Result>? result;

  factory NotificationModalClass.fromJson(Map<String, dynamic> json) => NotificationModalClass(
    status: json["status"],
    error: json["error"],
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.oid,
    this.vid,
    this.otype,
    this.title,
    this.message,
    this.deleted,
    this.dt,
    this.did,
    this.userid,
    this.vendor,
    this.subtotal,
    this.total,
    this.status,
    this.txnId,
    this.pmode,
    this.paid,
    this.tax,
    this.shipping,
    this.placed,
    this.aid,
    this.odate,
  });

  String? id;
  String? oid;
  String? vid;
  String? otype;
  String? title;
  String? message;
  String? deleted;
  DateTime? dt;
  String? did;
  String? userid;
  String? vendor;
  String?subtotal;
  String? total;
  dynamic status;
  String? txnId;
  String? pmode;
  String? paid;
  String? tax;
  String? shipping;
  String? placed;
  String? aid;
  dynamic odate;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    oid: json["oid"],
    vid: json["vid"],
    otype: json["otype"],
    title: json["title"],
    message: json["message"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
    did: json["did"],
    userid: json["userid"],
    vendor: json["vendor"],
    subtotal: json["subtotal"],
    total: json["total"],
    status: json["status"],
    txnId: json["txn_id"],
    pmode: json["pmode"],
    paid: json["paid"],
    tax: json["tax"],
    shipping: json["shipping"],
    placed: json["placed"],
    aid: json["aid"],
    odate: json["odate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "oid": oid,
    "vid": vid,
    "otype": otype,
    "title": title,
    "message": message,
    "deleted": deleted,
    "dt": dt!.toIso8601String(),
    "did": did,
    "userid": userid,
    "vendor": vendor,
    "subtotal": subtotal,
    "total": total,
    "status": status,
    "txn_id": txnId,
    "pmode": pmode,
    "paid": paid,
    "tax": tax,
    "shipping": shipping,
    "placed": placed,
    "aid": aid,
    "odate": odate,
  };
}
