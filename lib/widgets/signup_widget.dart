
import 'package:bookingapp/views/LoginPage.dart';
import 'package:bookingapp/views/StatusFirstRoomPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget signUpWidGet(BuildContext context) {
  Color customColor = Color(0xCCEFEEEE);
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
            margin: EdgeInsets.only(top: 180.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
              color: Colors.white,
            ),
            width: Get.width*0.75,
            height: Get.height*0.6,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Sign Up',
                    style:TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold

                    ),
                  ),
                ),
                SizedBox(height: 20,),

                Container(
                  width: Get.width * 0.65,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      hintText: 'Firstname', // ข้อความตัวอย่างในช่องใส่ข้อความ
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: customColor,

                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  width: Get.width * 0.65,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                        hintText: 'Phone', // ข้อความตัวอย่างในช่องใส่ข้อความ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: customColor
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  width: Get.width * 0.65,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                        hintText: 'Email', // ข้อความตัวอย่างในช่องใส่ข้อความ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: customColor
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  width: Get.width * 0.65,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                        hintText: 'Password', // ข้อความตัวอย่างในช่องใส่ข้อความ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: customColor
                    ),
                  ),
                ),


                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // สีพื้นหลังของปุ่ม
                          foregroundColor: Colors.white, // สีของข้อความ
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          padding:EdgeInsets.symmetric(horizontal: 152 , vertical: 13)

                      ),
                      child: Text("Confirm",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    ),
  );
}
