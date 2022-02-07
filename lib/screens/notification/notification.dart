import 'dart:convert';

import 'package:big_basket_deliveryboy/constant/api.dart';
import 'package:big_basket_deliveryboy/constant/constant.dart';
import 'package:big_basket_deliveryboy/screens/notification/notification_modalclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = true;
  late final notificationModalClass;


  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: themeColor,
        title: Column(
          children: [
            Row(
              children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Icon(CupertinoIcons.bell_circle_fill),
               ),
                Text("Notification",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
      body: isLoading == true
          ? Center(
        child: loaderWidget(),
      ):Container(
        color: backgroundColor,
        child: dynamicListview(),
      ),
    );
  }

  Widget dynamicListview() {
    // print("this is findword $findWord");
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
        itemCount: notificationModalClass.result.length,
        //  itemCount: title.length,
        shrinkWrap: true,
        //  physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notificationModalClass.result[index].title.toString(),
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                notificationModalClass.result[index].message,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          Text(
                            "Mode: ${notificationModalClass.result[index].pmode}",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(
                                notificationModalClass.result[index].dt.toString().split(" ").first,
                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
                              ),
                            SizedBox(height: 10,),

                           Text(
                                notificationModalClass.result[index].dt.toString().split(" ").last.split(".").first,
                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),

                            ),
                          ],
                        ),
                         Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(
                                "",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                              ),
                            Text(
                                "Total: ${notificationModalClass.result[index].total}₹",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: redColor),
                              ),

                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ),
                //    trailing: Icon(Icons.add_shopping_cart),

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
        Uri.parse("$notificationApi?userid=$userID"));
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
     notificationModalClass = notificationModalClassFromJson(response.body);




    isLoading = false;
    setState(() {});
  }
}
