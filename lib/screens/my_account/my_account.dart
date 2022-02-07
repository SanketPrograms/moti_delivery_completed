import 'dart:convert';

import 'package:big_basket_deliveryboy/constant/api.dart';
import 'package:big_basket_deliveryboy/constant/constant.dart';
import 'package:big_basket_deliveryboy/screens/login_page/login_page.dart';
import 'package:big_basket_deliveryboy/screens/my_account/get_profile_modalclass.dart';
import 'package:big_basket_deliveryboy/screens/pending_order/order_details_modalclass.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  int? totalOrder;
  String? deliveredOrder;
  String? receivedOrder;
  String? rejectedOrder;
  var isExpanded = false;
   bool isLoading = true;
   bool savePassword = true;
       TextEditingController StoreNameController = TextEditingController();
       TextEditingController StoreNumberController = TextEditingController();
       TextEditingController StoreEmailController = TextEditingController();
  _onExpansionChanged(bool val) {
    setState(() {
      isExpanded = val;
    });
  }

   getUserData(){
     StoreNameController.text = "Sanket Jadhav";
     StoreNumberController.text = "9403407979";
     StoreEmailController.text = "Sanket@gmail.com";
   }
@override
  void initState() {
    // TODO: implement initState
  getOrdersData();
  getData();
  getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.transparent,
      bottomNavigationBar: GestureDetector(

        onTap: (){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              Login()), (Route<dynamic> route) => false);
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0,vertical: 4),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.logout,color: redColor,),
              ),
              const SizedBox(width: 2,),
              Text("Logout",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 16)),

            ],
          ),
        ),
      ),
        appBar: AppBar(
        backgroundColor: themeColor,
        title: Column(
        children: [
        Row(
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(CupertinoIcons.person_alt_circle,),
            ),
            Text("My Account",
            style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500, fontSize: 16)),
          ],
        ),
    ],
    ),
        ),
      body:isLoading == true?Center(child:
      loaderWidget(),) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Card(
                      elevation: card_elevation,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height/6,
                        width: MediaQuery.of(context).size.height/8,
                        child: ListTile(
                          title: Text("Total \nOrder",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold
                          ),),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical:18.0),
                            child: Text(totalOrder.toString(),style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ),
                      ),
                    )),
                    Expanded(child: Card(
                      elevation: card_elevation,

                      child: SizedBox(
                        height: MediaQuery.of(context).size.height/6,
                        width: MediaQuery.of(context).size.height/8,
                        child: ListTile(
                          title: Text("Delivered \nOrder",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold
                          ),),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical:18.0),
                            child: Text(deliveredOrder.toString(),style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Card(
                      elevation: card_elevation,

                      child: SizedBox(
                        height: MediaQuery.of(context).size.height/6,
                        width: MediaQuery.of(context).size.height/8,
                        child: ListTile(
                          title: Text("Rejected \nOrder",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold
                          ),),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical:18.0),
                            child: Text(rejectedOrder.toString(),style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ),
                      ),
                    )),
                    Expanded(child: Card(
                      elevation: card_elevation,

                      child: SizedBox(
                        height: MediaQuery.of(context).size.height/6,
                        width: MediaQuery.of(context).size.height/8,
                        child: ListTile(
                          title: Text("Received \nOrder",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold
                          ),),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical:18.0),
                            child: Text(receivedOrder.toString(),style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: TextField(
                  controller: StoreNameController,
                  decoration: const InputDecoration(
                      hintText: "Full Name",
                      labelText: "Name"),
                  style:
                  GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: TextField(
                  controller: StoreNumberController,
                  decoration:const InputDecoration(
                      hintText: "Phone Number",
                      labelText: "Contact Number To Say Hello"),
                  style:
                  GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 2),
                child: TextField(
                  controller: StoreEmailController,
                  decoration:const InputDecoration(
                      hintText: "Email Address",
                      labelText: "Mail Id"),
                  style:
                  GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
               const SizedBox(height: 20,),
              Row(
                children: [
                  Text("Mobile Number",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  Text("Not Available",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 14)),
                  Transform.scale(
                    scale: 0.6,
                    child: CupertinoSwitch(
                        activeColor: Colors.cyanAccent,
                        // inactiveThumbColor: Colors.white,
                        // inactiveTrackColor: Colors.white70,
                        thumbColor: Colors.white,
                        trackColor: Colors.black,
                        value: savePassword,
                        onChanged: (val) {
                          setState(() {
                            savePassword = !savePassword;
                          });
                        }),
                  ),
                ],
              ),
              const Divider(thickness: 1,),

            ],
          ),
        ),
      ),
    );
  }

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userID = prefs.getString("userId");
    var response = await http.get(Uri.parse("$getProfileApi?userid=$userID&mode=pending"));
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    final getProfileModalclass = getProfileModalclassFromJson(response.body);

    StoreNameController.text =  getProfileModalclass.result!.name.toString();
    StoreEmailController.text = getProfileModalclass.result!.email!.toString();
    StoreNumberController.text = getProfileModalclass.result!.phone.toString();

    isLoading = false;
    setState(() {});

  }

  getOrdersData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userID = prefs.getString("userId");
    var response = await http.get(Uri.parse("$viewOrderApi?userid=$userID"));
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
   final orderHistoryModalclass = viewOrdersModalClassFromJson(response.body);


    deliveredOrder = orderHistoryModalclass.delivered.toString();
   receivedOrder =  orderHistoryModalclass.received.toString();
    rejectedOrder = orderHistoryModalclass.rejected.toString();
    totalOrder = orderHistoryModalclass.delivered! + orderHistoryModalclass.received! +orderHistoryModalclass.rejected!;

    isLoading = false;
    setState(() {});

  }
}
