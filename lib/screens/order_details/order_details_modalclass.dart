// To parse this JSON data, do
//
//     final orderDetailsModalclass = orderDetailsModalclassFromJson(jsonString);

import 'dart:convert';

OrderDetailsModalclass orderDetailsModalclassFromJson(String str) => OrderDetailsModalclass.fromJson(json.decode(str));

String orderDetailsModalclassToJson(OrderDetailsModalclass data) => json.encode(data.toJson());

class OrderDetailsModalclass {
  OrderDetailsModalclass({
    this.status,
    this.error,
    this.success,
    this.result,
  });

  String? status;
  int? error;
  int? success;
  Result? result;

  factory OrderDetailsModalclass.fromJson(Map<String, dynamic> json) => OrderDetailsModalclass(
    status: json["status"],
    error: json["error"],
    success: json["success"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "success": success,
    "result": result!.toJson(),
  };
}

class Result {
  Result({
    this.id,
    this.userid,
    this.vendor,
    this.subtotal,
    this.total,
    this.status,
    this.txnId,
    this.pmode,
    this.paid,
    this.deleted,
    this.dt,
    this.tax,
    this.shipping,
    this.placed,
    this.aid,
    this.odate,
    this.did,
    this.address,
    this.items,
  });

  String? id;
  String? userid;
  String? vendor;
  String? subtotal;
  String? total;
  dynamic status;
  String? txnId;
  String? pmode;
  String? paid;
  String? deleted;
  DateTime? dt;
  String? tax;
  String? shipping;
  String? placed;
  String? aid;
  dynamic odate;
  String? did;
  Address? address;
  List<Item>? items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    userid: json["userid"],
    vendor: json["vendor"],
    subtotal: json["subtotal"],
    total: json["total"],
    status: json["status"],
    txnId: json["txn_id"],
    pmode: json["pmode"],
    paid: json["paid"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
    tax: json["tax"],
    shipping: json["shipping"],
    placed: json["placed"],
    aid: json["aid"],
    odate: json["odate"],
    did: json["did"],
    address: Address.fromJson(json["address"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "vendor": vendor,
    "subtotal": subtotal,
    "total": total,
    "status": status,
    "txn_id": txnId,
    "pmode": pmode,
    "paid": paid,
    "deleted": deleted,
    "dt": dt!.toIso8601String(),
    "tax": tax,
    "shipping": shipping,
    "placed": placed,
    "aid": aid,
    "odate": odate,
    "did": did,
    "address": address!.toJson(),
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.id,
    this.userid,
    this.fname,
    this.lname,
    this.phone,
    this.houeNo,
    this.apartment,
    this.street,
    this.area,
    this.city,
    this.pin,
    this.type,
    this.aname,
    this.deleted,
    this.dt,
    this.latitude,
    this.longitude,
  });

  String? id;
  String? userid;
  String? fname;
  String? lname;
  String? phone;
  String? houeNo;
  String? apartment;
  String? street;
  String? area;
  String? city;
  String? pin;
  String? type;
  String? aname;
  String? deleted;
  DateTime? dt;
  dynamic latitude;
  dynamic longitude;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    userid: json["userid"],
    fname: json["fname"],
    lname: json["lname"],
    phone: json["phone"],
    houeNo: json["houe_no"],
    apartment: json["apartment"],
    street: json["street"],
    area: json["area"],
    city: json["city"],
    pin: json["pin"],
    type: json["type"],
    aname: json["aname"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "fname": fname,
    "lname": lname,
    "phone": phone,
    "houe_no": houeNo,
    "apartment": apartment,
    "street": street,
    "area": area,
    "city": city,
    "pin": pin,
    "type": type,
    "aname": aname,
    "deleted": deleted,
    "dt": dt!.toIso8601String(),
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Item {
  Item({
    this.id,
    this.userid,
    this.oid,
    this.product,
    this.variants,
    this.price,
    this.qty,
    this.total,
    this.deleted,
    this.dt,
    this.placed,
    this.vendor,
    this.status,
    this.pname,
    this.discount,
    this.vendorName,
    this.dprice,
    this.imgs,
    this.delivered,
  });

  String? id;
  String? userid;
  String? oid;
  String? product;
  String? variants;
  String? price;
  String? qty;
  String? total;
  String? deleted;
  DateTime? dt;
  String? placed;
  String? vendor;
  String? status;
  String? pname;
  String? discount;
  String? vendorName;
  String? dprice;
  List<Img>? imgs;
  dynamic delivered;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    userid: json["userid"],
    oid: json["oid"],
    product: json["product"],
    variants: json["variants"],
    price: json["price"],
    qty: json["qty"],
    total: json["total"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
    placed: json["placed"],
    vendor: json["vendor"],
    status: json["status"],
    pname: json["pname"],
    discount: json["discount"],
    vendorName: json["vendor_name"],
    dprice: json["dprice"],
    imgs: List<Img>.from(json["imgs"].map((x) => Img.fromJson(x))),
    delivered: json["delivered"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "oid": oid,
    "product": product,
    "variants": variants,
    "price": price,
    "qty": qty,
    "total": total,
    "deleted": deleted,
    "dt": dt!.toIso8601String(),
    "placed": placed,
    "vendor": vendor,
    "status": status,
    "pname": pname,
    "discount": discount,
    "vendor_name": vendorName,
    "dprice": dprice,
    "imgs": List<dynamic>.from(imgs!.map((x) => x.toJson())),
    "delivered": delivered,
  };
}

class Img {
  Img({
    this.id,
    this.product,
    this.imgpath,
    this.deleted,
    this.dt,
    this.iorder,
  });

  String? id;
  String? product;
  String? imgpath;
  String? deleted;
  DateTime? dt;
  String? iorder;

  factory Img.fromJson(Map<String, dynamic> json) => Img(
    id: json["id"],
    product: json["product"],
    imgpath: json["imgpath"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
    iorder: json["iorder"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product,
    "imgpath": imgpath,
    "deleted": deleted,
    "dt": dt!.toIso8601String(),
    "iorder": iorder,
  };
}
