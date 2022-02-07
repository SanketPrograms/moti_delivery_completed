import 'dart:convert';


import 'package:big_basket_deliveryboy/constant/api.dart';
import 'package:big_basket_deliveryboy/constant/constant.dart';
import 'package:big_basket_deliveryboy/constant/singleton.dart';
import 'package:big_basket_deliveryboy/screens/google_map/google_map.dart';
import 'package:big_basket_deliveryboy/screens/order_details/order_details_modalclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderDetails extends StatefulWidget {
  final orderId;
  OrderDetails({Key? key, this.orderId}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int? noProductFlag;
  bool isLoading = true;
  var deliveryID;
  late final viewDeliveryModalclass;

  late final orderHistoryModalclass;
  @override
  void initState() {
    // TODO: implement initState
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:backgroundColor,

      appBar: AppBar(
        backgroundColor: themeColor,
        title: Column(
          children: [

            Text("Order Details",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 16)),
          ],
        ),
      ),
      body: isLoading == true
          ? Center(
        child: loaderWidget(),
      )
          : noProductFlag == 1
          ? Center(child: Image.asset("assets/images/no_product_found.png"))
          : SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width:150,
                      child: Text(
                        "Txn ID ${orderHistoryModalclass.result!.txnId}",
                        style: GoogleFonts.poppins(
                            color: lightFontColor, fontSize: fontw500),
                      ),
                    ),
                    Container(
                      width:150,

                      child: Text(
                        "Total: ${orderHistoryModalclass.result!.total.split(".").first}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width:150,

                    child: Text("Date:"+
                        orderHistoryModalclass.result!.items[0].dt
                            .toString()
                            .split(" ")
                            .first,
                      style: GoogleFonts.poppins(
                          color: lightFontColor, fontSize: fontw500),
                    ),
                  ),

                  Container(
                    width:150,

                    child: Text(
                        orderHistoryModalclass.result.address.phone,
                      style: GoogleFonts.poppins(
                          color: Colors.black87, fontSize: fontw500),

                    ),
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
                child: Row(
                  children: [


                    Expanded(
                      child: Text("Address:- House No:${orderHistoryModalclass.result.address.houeNo},Area:${orderHistoryModalclass.result.address.area}, ${orderHistoryModalclass.result.address.city} - ${orderHistoryModalclass.result.address.pin}",style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45
                      ),),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          MapUtils.openMap(-3.823216,-38.481700);

  //todo:uncomment this in Live Apk
                          // MapUtils.openMap(orderHistoryModalclass.result.address.latitude,orderHistoryModalclass.result.address.longitude);

                        });
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(CupertinoIcons.location_solid,size: 15,color: Colors.black,),
                          ),
                          Text("Location",
                              style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black)),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                         // primary: themeColor,
                          // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: GoogleFonts.poppins(
                            // fontSize: 30,
                              fontWeight: FontWeight.w500)),
                    ),

                  ],
                ),
              ),
              dynamicListview(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton(
                    onPressed: () {
                      showDeliveredAlertDialog();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(CupertinoIcons.check_mark_circled_solid,size: 15,),
                        ),
                        Text("Deliver",
                            style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500)),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: themeColor,
                        // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: GoogleFonts.poppins(
                          // fontSize: 30,
                            fontWeight: FontWeight.w500)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showCancelAlertDialog();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(CupertinoIcons.multiply_square_fill,size: 15,),
                        ),
                        Text("Cancel",
                            style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500)),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: redColor,
                        // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: GoogleFonts.poppins(
                          // fontSize: 30,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),

              SizedBox(height: 20,),


            ],
          ),
        ),
      ),
    );
  }

  Widget dynamicListview() {
    // print("this is findword $findWord");
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
        itemCount: orderHistoryModalclass.result!.items.length,
        //  itemCount: title.length,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        //  physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name: ${orderHistoryModalclass.result!.items[index].pname}",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Price: ${orderHistoryModalclass.result!.items[index].price.toString().split(".").first}",
                              style: GoogleFonts.poppins(
                                  color: lightFontColor, fontSize: fontw500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //    trailing: Icon(Icons.add_shopping_cart),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Qty:${orderHistoryModalclass.result!.items[index].qty}",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                    Divider(thickness: 1),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Total: ${orderHistoryModalclass.result!.items[index].total.split(".").first}",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, color: redColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userID = prefs.getString("userId");
    var response = await http.get(
        Uri.parse("$orderDetailsApi?userid=$userID&oid=${widget.orderId}"));
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
   orderHistoryModalclass = orderDetailsModalclassFromJson(response.body);


    if (body["status"] == "400" ||
        orderHistoryModalclass.result!.items!.isEmpty) {
      noProductFlag = 1;
    } else {
      noProductFlag = 0;
    }
    isLoading = false;
    setState(() {});
  }

  // getDeliveryBoyData() async{
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final userID = prefs.getString("userId");
  //   var response = await http.get(Uri.parse("$viewDeliveryBoy?userid=$userID}"));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     debugPrint(data.toString());
  //     viewDeliveryModalclass = viewDeliveryModalclassFromJson(response.body);
  //
  //     setState(() {
  //       isLoading = false;
  //     });
  //
  //   }
  // }

  // _showMyDialog(context) async {
  //   return showDialog<void>(
  //       context: context,
  //       barrierDismissible: false, // user must tap button!
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //
  //             title: Text(
  //               'Assign Delivery Boy!',
  //               style: GoogleFonts.poppins(
  //                   fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //             content: Card(
  //                 child: ListView.builder(
  //                     itemCount: viewDeliveryModalclass.result.length,
  //                     //  itemCount: title.length,
  //                     shrinkWrap: true,
  //                     physics: const BouncingScrollPhysics(),
  //
  //                     itemBuilder: (context, index) {
  //                       return Card(
  //                         child: Column(
  //                           children: [
  //                             ListTile(title:  Text(viewDeliveryModalclass.result![index].name,style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
  //
  //                               subtitle: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(viewDeliveryModalclass.result![index].phone,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),
  //                                 ],
  //                               ),
  //
  //                               trailing:  ElevatedButton(
  //                                 onPressed: () {
  //                                   setState(() {
  //                                     assignDeliveryBoy(viewDeliveryModalclass.result![index].id,viewDeliveryModalclass.result![index].name);
  //                                     Navigator.pop(context);
  //                                   });
  //                                 },
  //                                 child: Text("Assign",
  //                                     style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
  //                                 style: ElevatedButton.styleFrom(
  //                                     primary: themeColor,
  //                                     // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
  //                                     textStyle: GoogleFonts.poppins(
  //                                       // fontSize: 30,
  //                                         fontWeight: FontWeight.w500)),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     })
  //             )
  //
  //
  //         );
  //       });
  // }

  orderDelivered(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userID = prefs.getString("userId");

    final dataBody = {
      "userid": userID,
      "status": status,
      "oid": widget.orderId,

    };
    var response =
    await http.post(Uri.parse(orderDeliveredApi), body: dataBody);
    var body = jsonDecode(response.body);

    debugPrint(body.toString());
    if(body["success"]==1){
      setState(() {

      });
      if(status == "Rejected"){
        Singleton.showmsg(context, "Message", "Order Cancelled Successfully!");

      }
      else {
        Singleton.showmsg(context, "Message", "Order Delivered Successfully!");
      }
    }
    else{
      Singleton.showmsg(context, "Message", "Something Went Wrong");

    }

    debugPrint(body.toString());
  }

  showCancelAlertDialog() {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: GoogleFonts.poppins(),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",style: GoogleFonts.poppins(),),
      onPressed:  () {
        orderDelivered("Rejected");

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.bold),),
      content: Text("Are You Sure To Cancel The Order",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),
      actions: [
      //  cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showDeliveredAlertDialog() {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: GoogleFonts.poppins(),),
      onPressed:  () {
        Navigator.of(context).pop();

      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",style: GoogleFonts.poppins(),),
      onPressed:  () {
        orderDelivered("Completed");

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: Text("Message",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 14),),
      content: Text("Are You Sure To Deliver Order",style: GoogleFonts.poppins(fontSize: 12),),
      actions: [
        //cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
