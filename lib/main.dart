import 'package:big_basket_deliveryboy/screens/introduction_screen/introduction.dart';
import 'package:big_basket_deliveryboy/screens/login_page/login_page.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'constant/constant.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var loginStatus = false;
  var introStatus = false;
  loginStatus = prefs.getBool('isLoggedIn') ?? false;
  introStatus = prefs.getBool('intro') ?? false;

  runApp(MaterialApp(

      color: themeColor,
      // routes: {
      //   "/login": (context) => Login(),
      // },
      debugShowCheckedModeBanner: false,
      home: loginStatus == true ? DashBoardNew() :introStatus == true? const Login():
      const Introduction_screen()
  ));
}
