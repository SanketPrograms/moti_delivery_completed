import 'dart:convert';


import 'package:big_basket_deliveryboy/constant/api.dart';
import 'package:big_basket_deliveryboy/constant/constant.dart';
import 'package:big_basket_deliveryboy/screens/google_map/google_map.dart';
import 'package:big_basket_deliveryboy/screens/order_details/order_details.dart';
import 'package:big_basket_deliveryboy/screens/pending_order/order_details.dart';
import 'package:big_basket_deliveryboy/screens/pending_order/order_details_modalclass.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CancelledOrder extends StatefulWidget {
  CancelledOrder({Key? key}) : super(key: key);

  @override
  State<CancelledOrder> createState() => _CancelledOrderState();
}

class _CancelledOrderState extends State<CancelledOrder> {
  bool isLoading = true;

  late final orderHistoryModalclass;

  int? noProductFlag;


  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: themeColor,
        title: Column(
          children: [
            Text("Cancelled Order",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 16)),
          ],
        ),
      ),
      body: isLoading == true?Center(child:
      loaderWidget(),) :orderHistoryModalclass.result!.length==0?Card(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    Image.asset("assets/images/no_orders.gif"),
    Text("No Cancelled Orders Found!",style: GoogleFonts.poppins(
    fontWeight: FontWeight.bold
    ),)
    ],
    )):SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Container(
          color: backgroundColor,
          child: dynamicListview(),
        ),
      ),
    );
  }

  Widget dynamicListview() {
    // print("this is findword $findWord");

    return ListView.builder(
      itemCount: orderHistoryModalclass.result!.length,
      //  itemCount: title.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderDetails(orderId: orderHistoryModalclass.result![index].id),));

              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Card(
                  elevation: cardElevation,
                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(cardBorderRadius)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mode:"+ orderHistoryModalclass.result[0].pmode,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),
                            ),

                            Text(
                              "Txn ID:"+ orderHistoryModalclass.result[0].txnId,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.grey),
                            ),
                          ],
                        ),
                        //    trailing: Icon(Icons.add_shopping_cart),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: sizedBoxlessHeight,),
                                Text(
                                  "Qty:1",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),
                                ),
                                const SizedBox(height: sizedBoxlessHeight,),

                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Rs."+orderHistoryModalclass.result[0].total,
                                    style: TextStyle(fontWeight: FontWeight.w500,color: redColor,fontSize: fontw500),
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    orderHistoryModalclass.result[0].dt.toString().split(" ").first,
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    orderHistoryModalclass.result[0].status??"",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

  }

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userID = prefs.getString("userId");
    debugPrint("$viewOrderApi?userid=$userID&mode=cancelled");
    var response = await http.get(Uri.parse("$viewOrderApi?userid=$userID&mode=rejected"));
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    orderHistoryModalclass = viewOrdersModalClassFromJson(response.body);


    // orderHistoryModalclass.result[0].items[0].pname;
    // orderHistoryModalclass.result[0].txnId;
    // orderHistoryModalclass.result[0].total;
    // orderHistoryModalclass.result[0].status;
    // orderHistoryModalclass.result[0].pmode;
    // orderHistoryModalclass.result[0].dt.toString().split(" ").first;

    isLoading = false;
    setState(() {});

  }}
