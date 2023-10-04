import 'package:bookingapp/views/HomePage.dart';
import 'package:bookingapp/views/StatusFirstRoomPage.dart';
import 'package:bookingapp/views/LoginPage.dart';
import 'package:bookingapp/views/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
      home: DetailPage(), // Pass the context here
      routes: {
        '/homePage': (context) => HomePage(),
        '/loginPage': (context) => LoginPage(),
        '/statusPage':(context) => StatusPage(),
      },
    );
  }
}
