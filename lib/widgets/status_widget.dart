

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../views/detail_page.dart';
Widget statusWidget(){
  DateTime now = DateTime.now();
  String formatteTime = DateFormat('HH:mm ').format(now);
  String formatteDate = DateFormat('EEE MMM d').format(now);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0.0),
    child: SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: 240,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.black, Colors.black, Colors.green, Colors.green, Colors.green],
                stops: [0.0, 0.15, 0.84, 0.75, 1.0],
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 60.0,left:40.0),
                child: Row(
                  children: [
                    Text(
                      formatteTime,
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0 ),
                      child: Text(
                        formatteDate,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          height: 2.4,
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
                  padding: const EdgeInsets.only(top:90.0,left: 40.0),
                  child: Text(
                    'Meeting Room',
                    style: TextStyle(
                      fontSize: 58.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Transform.translate(
                    offset: Offset(-222, 95),
                    child: Container(
                      width: 300,
                      height: 1,
                      color: Colors.white70,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-422, 105),
                    child: Container(
                      width: 300,
                      height: 1,
                      color: Colors.white70,
                    ),
                  ),]
              )
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child:Padding(
              padding: const EdgeInsets.only(left: 450.0,top:50.0 ),
              child: Text(
                '01',
                style: TextStyle(
                  fontSize: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:240,),
                child: Container(
                  width:1100,
                  height: 1100,
                  child: Image.asset(
                    'assets/statusPic2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Transform.translate(
              offset: Offset(0, -1100),
                child: Container(
                  width: 1100,
                  height: 1100,
                  color: Colors.black.withOpacity(0.55),
                ),
              ),
              Transform.translate(
                offset: Offset(-140, -2100),
                child: Stack(
                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(11.0),
                        color: Color.fromRGBO(78, 175, 83, 1.0).withOpacity(0.85),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Available',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    ),
                   Transform.translate(
                     offset: Offset(0, 60),
                       child: Text('Scrum Meeting',
                         style:TextStyle(
                           color: Colors.white,
                           fontSize: 38
                         ),
                       )
                   )
                    ,
                    Transform.translate(
                        offset: Offset(0, 110),
                        child: Text('16:00'+' - '+'17:00',
                          style:TextStyle(
                              color: Colors.white,
                              fontSize: 72,
                              fontWeight: FontWeight.bold
                          ),
                        )),
                    Transform.translate(
                        offset: Offset(5, 200),
                        child: Text('By Admin',
                          style:TextStyle(
                              color: Colors.white,
                              fontSize: 28
                          ),
                        )),


                  ],

                ),

              ),
            ],
          ),
          Transform.translate(
            offset: Offset(260, 900),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPage(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(78, 175, 83, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                  ),
                  child: Text(
                    'See Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(100,1000),
            child: Column(
              children: [
                Transform.translate(
                  offset: Offset(-100, 0),
                  child: Container(
                  width: 580,
                  height: 1,
                  color: Colors.white70,
                                ),
                ),
                Transform.translate(
                  offset: Offset(-120, 40),
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('18:00 '+'-'+' 19.00' +' Host Name',
                        style:TextStyle(
                          fontSize: 24,
                          color: Colors.white70
                        ) ,),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(-120, 40),
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text( '19:00 '+'-'+' 20.00' +' Host Name',
                        style:TextStyle(
                            fontSize: 24,
                            color: Colors.white70
                        ) ,),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(-100, 80),
                  child: Container(
                    width: 580,
                    height: 1,
                    color: Colors.white,
                  ),
                ),
                Transform.translate(
                  offset: Offset(-100, 100),
                  child: Text(
                     'Show All Bookings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),
                  )
                ),
              ]
            ),
          ),
        ],
      ),
    ),
  );
}
