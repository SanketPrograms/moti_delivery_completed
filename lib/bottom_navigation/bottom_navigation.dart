import 'package:big_basket_deliveryboy/constant/constant.dart';
import 'package:big_basket_deliveryboy/screens/cancel_order/cancel_order.dart';
import 'package:big_basket_deliveryboy/screens/delivered_order/delivery_order.dart';
import 'package:big_basket_deliveryboy/screens/my_account/my_account.dart';
import 'package:big_basket_deliveryboy/screens/notification/notification.dart';
import 'package:big_basket_deliveryboy/screens/pending_order/pending_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardNew extends StatefulWidget {
  DashBoardNew({Key? key}) : super(key: key);

  @override
  State<DashBoardNew> createState() => _DashBoardNewState();
}

class _DashBoardNewState extends State<DashBoardNew> {
  var currentPosition;

  var currentLocationAddress;
  var getLocationAddress;

  var CartLength;
  // List homeScreenList = [
  //   HomePage(),
  //   CategorySubCategory(),
  //   TotalOrderPending(),
  //   NotificationScreen(),
  //   MyAccount(),
  // ];
  // CupertinoTabController? tabController;
  CupertinoTabController tabController = CupertinoTabController();

  int _index = 0;

  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fifthTabNavKey = GlobalKey<NavigatorState>();
  var activeColor = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listOfKeys = [
      firstTabNavKey,
      secondTabNavKey,
      thirdTabNavKey,
      fourthTabNavKey,
      fifthTabNavKey
    ];

    return WillPopScope(
      onWillPop: () async {
        return !await listOfKeys[tabController.index].currentState!.maybePop();
      },
      child: CupertinoTabScaffold(
        // backgroundColor: Colors.black,
        controller: tabController, //set tabController here

        tabBar: CupertinoTabBar(
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
              activeColor = value;
            });
          },
          inactiveColor: Colors.white,
          activeColor: themeColor,
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => DashBoardNew()));
                  });
                },
                child: Image.asset(
                    "assets/images/bottom_navigation/dashboard.png",
                    height: 20,
                    color: activeColor == 0 ? Colors.green : Colors.white),
              ),
              //  title: Text('Home'),
              backgroundColor: Colors.black,

              title: Text(
                'Home',
                style: GoogleFonts.poppins(fontSize: 10),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/bottom_navigation/box.png",
                  height: 20,
                  color: activeColor == 1 ? Colors.green : Colors.white),
              //    title: Text('Search'),
              backgroundColor: Colors.black,
              title: Text(
                'Cancelled',
                style: GoogleFonts.poppins(fontSize: fontw500),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/bottom_navigation/list.png",
                  height: 20,
                  color: activeColor == 2 ? Colors.green : Colors.white),
              //    title: Text('Search'),
              backgroundColor: Colors.black,
              title: Text(
                'Delivered',
                style: GoogleFonts.poppins(fontSize: fontw500),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/bottom_navigation/bell.png",
                  height: 20,
                  color: activeColor == 3 ? Colors.green : Colors.white),
              //    title: Text('Profile'),
              backgroundColor: Colors.black,
              title: Text(
                'Notification',
                style: GoogleFonts.poppins(fontSize: fontw500),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/bottom_navigation/user.png",
                  height: 20,
                  color: activeColor == 4 ? Colors.green : Colors.white),
              title: Text(
                'Account',
                style: GoogleFonts.poppins(fontSize: fontw500),
              ),
              backgroundColor: Colors.black,
            ),
          ],
          backgroundColor: Colors.black,
          iconSize: 25,
        ),
        // BottomNavigationBarItem(

        tabBuilder: (BuildContext context, int index) {
          _index = index;

          return CupertinoTabView(
            builder: (BuildContext context) {
              switch (index) {
                case 0:
                  return CupertinoTabView(
                    navigatorKey: firstTabNavKey,
                    builder: (BuildContext context) {
                      return TotalPendingOrder();
                    },
                  );
                case 1:
                  return CupertinoTabView(
                    navigatorKey: secondTabNavKey,
                    builder: (BuildContext context) {
                      return CancelledOrder();
                    },
                  );
                case 2:
                  return CupertinoTabView(
                    navigatorKey: thirdTabNavKey,
                    builder: (BuildContext context) {
                      return DeliveredOrder();
                    },
                  );
                case 3:
                  return CupertinoTabView(
                    navigatorKey: fourthTabNavKey,
                    builder: (BuildContext context) {
                      return NotificationScreen();
                    },
                  );
                default:
                  return CupertinoTabView(
                    navigatorKey: fifthTabNavKey,
                    builder: (BuildContext context) {
                      return MyAccount();
                    },
                  );
              }
            },
          );
        },
      ),
    );
  }
}
