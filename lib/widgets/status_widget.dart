import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
Widget statusWidget(){
  DateTime now = DateTime.now();
  String formatteTime = DateFormat('HH:mm ').format(now);
  //EEE MMM d
  String formatteDate = DateFormat('EEE MMM d').format(now);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0.0),


       child:Stack(

          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.16,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.black, Colors.green, Colors.green, Colors.green],
                  stops: [0.0, 0.15, 0.84, 0.75, 1.0], // 0.25, 0.5, 0.75 คืออัตราส่วนสีดำ 1 ส่วนต่อสีเขียว 4 ส่วน
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 40.0,left:30.0),
                   child: Row(
                     children: [
                       Text(
                         formatteTime,
                           style: TextStyle(
                             fontSize: 28,
                             color: Colors.white,
                             fontWeight: FontWeight.w700
                           ),
                       ),

                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal:10.0 ),
                         child: Text(
                           formatteDate ,
                           style: TextStyle(
                               fontSize: 18  ,
                              color: Colors.white,
                             height: 2.4
                           ),
                         ),
                       ),

                     ],


                   ),



                ),
              ),

            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top:70.0,left: 30.0),
                    child: Text(
                      'Meeting Room',
                      style: TextStyle(
                        fontSize: 38.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500


                      ),
                    ),
                  ),
                ),

              ],
              
            ),
            Align(
              alignment: Alignment.topCenter,
              child:Padding(
                padding: const EdgeInsets.only(left: 350.0,top:25.0 ),
                child: Text(
                  '01',
                  style: TextStyle(
                      fontSize: 80,
                      color: Colors.white
                  ),
                ),
              ),
            )


          ],
        ),


  );
}