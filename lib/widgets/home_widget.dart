import 'package:bookingapp/views/LoginPage.dart';
import 'package:bookingapp/views/StatusFirstRoomPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget homeWidGet(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0.0),
    child: Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/homePic.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 160.0),
            child: Text(
              "Website \n  Name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 780.0),
            child: ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // สีพื้นหลังของปุ่ม
                foregroundColor: Colors.white, // สีของข้อความ
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                  padding:EdgeInsets.symmetric(horizontal: 150 , vertical: 10)

              ),
              child: Text("Login",
              style: TextStyle(
             fontSize: 20
              ),),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 840.0),
            child: ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatusPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                  padding:EdgeInsets.symmetric(horizontal: 80 , vertical: 10)

              ),
              child: Text("Continue As Guest",
                style: TextStyle(
                    fontSize: 20
                ),),
            ),
          ),
        ),
      ],
    ),
  );
}
