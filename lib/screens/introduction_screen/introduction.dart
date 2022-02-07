import 'package:big_basket_deliveryboy/constant/constant.dart';
import 'package:big_basket_deliveryboy/screens/login_page/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introduction_screen extends StatelessWidget {
  const Introduction_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/intro_screen.png'),
    fit: BoxFit.cover,
    ),
    ),
    child:Scaffold(
    backgroundColor: Colors.transparent,
    body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(),
        SizedBox(),
        SizedBox(),
       loginBtn(context),

      ],
    ),
    ));
  }

  Widget loginBtn(context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              onPressed: () {

                setData(context);
              },
              child: Text("Login",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                  primary: redColor,
                  // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: GoogleFonts.poppins(
                    // fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }

  setData(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("intro", true);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }
}
