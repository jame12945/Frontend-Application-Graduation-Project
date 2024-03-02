import 'package:bookingapp/views/HomePage.dart';
import 'package:bookingapp/views/ReservationProcess_Page.dart';

import 'package:bookingapp/views/SignUpPage.dart';
import 'package:bookingapp/views/StatusFirstRoomPage.dart';
import 'package:bookingapp/views/LoginPage.dart';
import 'package:bookingapp/views/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await dotenv.load(fileName: "env/dev.env");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(textTheme),
      ),
      home: StatusPage(),
      routes: {
        '/homePage': (context) => HomePage(),
        '/loginPage': (context) => LoginPage(),
        '/statusPage':(context) => StatusPage(),
        '/signUpPage':(context) => SignUpPage(),
        '/reservationPage':(context) => ReservationPage(),

      },
    );
  }
}
