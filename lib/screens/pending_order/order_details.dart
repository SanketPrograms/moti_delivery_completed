// import 'dart:convert';
//
// import 'package:big_basket_deliveryboy/constant/api.dart';
// import 'package:big_basket_deliveryboy/constant/constant.dart';
// import 'package:big_basket_deliveryboy/screens/pending_order/product_modalclass.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class OrderDetails extends StatefulWidget {
//   final orderId;
//   OrderDetails({Key? key, this.orderId}) : super(key: key);
//
//   @override
//   State<OrderDetails> createState() => _OrderDetailsState();
// }
//
// class _OrderDetailsState extends State<OrderDetails> {
//   int? noProductFlag;
//   bool isLoading = true;
//
//   late final orderHistoryModalclass;
//   @override
//   void initState() {
//     // TODO: implement initState
//     getData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: themeColor,
//         title: Column(
//           children: [
//             Text("Order Details",
//                 style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w500, fontSize: 16)),
//           ],
//         ),
//       ),
//       body: isLoading == true
//           ? Center(
//         child: loaderWidget(),
//       )
//           : noProductFlag == 1
//           ? Center(child: Image.asset("assets/images/no_product_found.png"))
//           : Container(
//         color: backgroundColor,
//         child: dynamicListview(),
//       ),
//     );
//   }
//
//   Widget dynamicListview() {
//     // print("this is findword $findWord");
//     return LayoutBuilder(builder: (context, constraints) {
//       return ListView.builder(
//         itemCount: orderHistoryModalclass.result!.items.length,
//         //  itemCount: title.length,
//         physics: BouncingScrollPhysics(),
//         shrinkWrap: true,
//         //  physics: const ScrollPhysics(),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Name: ${orderHistoryModalclass.result!.items[index].pname}",
//                             style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "ID ${orderHistoryModalclass.result!.txnId}",
//                             style: GoogleFonts.poppins(
//                                 color: lightFontColor, fontSize: fontw500),
//                           ),
//                         ],
//                       ),
//                     ),
//                     //    trailing: Icon(Icons.add_shopping_cart),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Qty:${orderHistoryModalclass.result!.items[index].qty}",
//                                 style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Text(
//                                 "",
//                                 style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Text(
//                                 orderHistoryModalclass.result!.items[index].dt
//                                     .toString()
//                                     .split(" ")
//                                     .first,
//                                 style: GoogleFonts.poppins(
//                                     color: lightFontColor, fontSize: fontw500),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Text(
//                                 orderHistoryModalclass.result!.items[index].dt
//                                     .toString()
//                                     .split(" ")
//                                     .last
//                                     .split(".")
//                                     .first,
//                                 style: GoogleFonts.poppins(
//                                     color: lightFontColor, fontSize: fontw500),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//
//                     Divider(thickness: 1),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "Order List",
//                         style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "Order Name",
//                             style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "Price: Rs.${orderHistoryModalclass.result!.items[index].price.toString().split(".").first}",
//                             style: GoogleFonts.poppins(
//                                 color: lightFontColor, fontSize: fontw500),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "Total: Rs.${orderHistoryModalclass.result!.items[index].total.split(".").first}",
//                             style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.bold, color: redColor),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
//
//   getData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     final userID = prefs.getString("userId");
//     var response = await http.get(
//         Uri.parse("$orderDetailsApi?userid=$userID&oid=${widget.orderId}"));
//     var body = jsonDecode(response.body);
//     debugPrint(body.toString());
//     orderHistoryModalclass = productDetailsModalclassFromJson(response.body);
//     if (body["status"] == "400" ||
//         orderHistoryModalclass.result!.items!.isEmpty) {
//       noProductFlag = 1;
//     } else {
//       noProductFlag = 0;
//     }
//     isLoading = false;
//     setState(() {});
//   }
// }
