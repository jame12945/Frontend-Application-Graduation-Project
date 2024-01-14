import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../views/AllBookingPage.dart';
import '../views/detail_page.dart';
import 'dart:async';
class statusWidget extends StatefulWidget {
  @override
  _statusWidgetWidgetState createState() => _statusWidgetWidgetState();
}

class _statusWidgetWidgetState extends State<statusWidget>{
  List<dynamic>? timeSlots;
  List<dynamic>? timeNextSlots;
  List<Map<String, dynamic>>? bookings;
  String? formattedCurrentTime;
  bool x = false;
  bool y = false;
  late Timer _timer;
  Future<Map<String, dynamic>> fetchTimeSlots() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/selectStatusTime'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'ok') {
          timeSlots = data['message'];
          formattedCurrentTime = data['time'];
          // ให้ x มีค่าเท่ากับค่าที่มีอยู่จริงใน response
          x = data['message']?.isNotEmpty == true;
          return {
            'status': 'ok',
            'message': 'Time slots retrieved successfully',
            'timeSlots': timeSlots,
            'formattedCurrentTime': formattedCurrentTime,
          };
        } else {
          // ให้ x เป็น false เมื่อ status เป็น error
          setState(() {
            x = false;
          });
          return {
            'status': 'error',
            'message': 'Error retrieving time slots',
          };
        }
      } else {
        // ให้ x เป็น false เมื่อไม่ได้รับ response 200
        setState(() {
          x = false;
        });
        return {
          'status': 'error',
          'message': 'Failed to retrieve data from the server',
        };
      }

    } catch (error) {

      return {
        'status': 'error',
        'message': 'An error occurred: $error',
      };
    }
  }

  Future<List<Map<String, dynamic>>> getSelectNextBooking() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/selectNextBooking'),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'ok') {
        List<Map<String, dynamic>> bookings = [];
        y = data['message']?.isNotEmpty == true;
        for (var booking in data['message']) {
          Map<String, dynamic> userDetails = booking['user_details'];

          bookings.add({
            'start_time': booking['start_time'],
            'end_time': booking['end_time'],
            'user_id': booking['user_id'],
            'user_fname': userDetails['user_fname'],
            'user_lname': userDetails['user_lname'],

          }); print(bookings);
        }

        return bookings;
      } else {
        throw Exception('Error: ${data['message']}');
      }
    } else {
      throw Exception('Failed to load booking information');
    }
  }

  Future<void> fetchData() async {
    await fetchTimeSlots();
    final result = await getSelectNextBooking();
    bookings = result;
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    fetchData(); // เรียก fetchData ทั้งครั้งแรกเมื่อ initState เริ่มต้น
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      fetchData();
    });
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  Widget build(BuildContext context){
    DateTime now = DateTime.now();
    String formatteTime = DateFormat('HH:mm ').format(now);
    String formatteDate = DateFormat('EEE MMM d').format(now);

    Widget buildBookingInfo() {
      if (timeSlots?.isNotEmpty == true) {
        String startTime = timeSlots?[0]['start_time'];
        String endTime = timeSlots?[0]['end_time'];

        if (startTime != null && endTime != null) {
          List<String> startParts = startTime.split(':');
          List<String> endParts = endTime.split(':');

          if (startParts.length >= 2 && endParts.length >= 2) {
            startTime = '${startParts[0]}:${startParts[1]}';
            endTime = '${endParts[0]}:${endParts[1]}';
          }
          // x= true;
          return Text(
            '$startTime - $endTime',
            style: TextStyle(
              color: Colors.white,
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
          );
        }
      }


      // x = false;

      return Text(
        'No Booking',
        style: TextStyle(
          color: Colors.white,
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    Widget buildNextStatusInfo() {
      if (bookings?.isNotEmpty == true ) {
        List<Widget> bookingWidgets = [];

        for (var booking in bookings!) {
          String startTime = DateFormat('HH:mm').format(DateTime.parse('2022-01-06 ${booking['start_time']}'));
          String endTime = DateFormat('HH:mm').format(DateTime.parse('2022-01-06 ${booking['end_time']}'));
          String hostName = '${booking['user_fname']} ${booking['user_lname']}';

          bookingWidgets.add(
            Stack(
              children:[
                Transform.translate(
                  offset: Offset(0, 0),
                  child: Container(
                    width: 580,
                    height: 2,
                    color: Colors.white24,
                  ),
                ),
                Transform.translate(
                  offset: Offset(145, 40),
                  child: Row(
                    children: [
                      Text(
                        '$startTime - $endTime',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' By $hostName',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 140),
                  child: Container(
                    width: 580,
                    height: 2,
                    color: Colors.white24,
                  ),
                ),
              ]
            ),
          );
        }

        return Column(
          children: bookingWidgets,
        );
      } else {
        return Stack(
          children: [
            Transform.translate(
              offset: Offset(0, 0),
              child: Container(
                width: 580,
                height: 1,
                color: Colors.white70,
              ),
            ),
            Transform.translate(
              offset: Offset(242, 40),
              child: Text(
                'No Booking',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 115),
              child: Container(
                width: 580,
                height: 1,
                color: Colors.white70,
              ),
            ),

          ]
        );
      }
    }


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
                  colors: x ? [Colors.black, Colors.black, Colors.red, Colors.red, Colors.red]
                      : [Colors.black, Colors.black, Colors.green, Colors.green, Colors.green],
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
                            color: x
                                ? Colors.red.withOpacity(0.85)
                                : Color.fromRGBO(78, 175, 83, 1.0).withOpacity(0.85),
                          ),


                          child: x
                              ? Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Unavailable',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ) // ถ้า x เป็น true
                              : Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Available',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          )

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
                        child: buildBookingInfo(),
                      ),


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
                      backgroundColor: x ?Colors.red.withOpacity(0.85)
                          :Color.fromRGBO(78, 175, 83, 1.0),
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
                   
                    buildNextStatusInfo(),

                  ]
              ),
            ),
            Transform.translate(
              offset: Offset(20, 0),
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(horizontal: 100,vertical: 1170),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AllBookingPage())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,

                    ),
                    child: Text(
                      'View All Bookings',
                      style: TextStyle(

                          fontSize: 22,
                          color:  Colors.white70
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}