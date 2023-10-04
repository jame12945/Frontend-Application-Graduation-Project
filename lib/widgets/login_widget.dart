
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget loginWidGet() {
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
        Opacity(
          opacity: 0.6, // ความโปร่งแสง
          child: Container(
            color: Colors.black,
            width: Get.width,
            height: Get.height,
          ),
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 160.0),
            child: Text(
              "Website \n  Name",
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
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
              onPressed:null,
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
              onPressed: null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                  padding:EdgeInsets.symmetric(horizontal: 80 , vertical: 10)

              ),
              child: Text("Continue As Guest",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,

                ),),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 160.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
              color: Colors.white,

            ),

            width: Get.width*0.75,
            height: Get.height*0.70,
          ),
        ),
      ],
    ),
  );
}
