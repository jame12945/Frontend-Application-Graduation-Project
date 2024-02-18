import 'package:bookingapp/views/ProofPage.dart';
import 'package:bookingapp/views/ReservationProcess_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoundUserPage extends StatefulWidget {
  final String name;



  FoundUserPage({required this.name});

  @override
  _FoundUserPageState createState() => _FoundUserPageState();
}

class _FoundUserPageState extends State<FoundUserPage> {
  String startTime = '';
  String endTime = '';
  String dateReserve = '';
  int attendanceID = 0;
  int reservationID = 0;

  Future<void> fetchStartTime() async {

    final url = Uri.parse('http://192.168.1.5:3000/getLastreservations');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final reservations = jsonData['reservations'];
      if (reservations != null && reservations.isNotEmpty) {
        final latestReservation = reservations.last;

        setState(() {
          String startFullTime = latestReservation['start_time'];
          startTime = startFullTime.substring(0,5);
          String endFullTime = latestReservation['end_time'];
          endTime = endFullTime.substring(0,5);
          String DateReserve = latestReservation['date_reservation'];
          DateTime dateReserveDateTime = DateTime.parse(DateReserve);
          DateTime adjustedDateReserve = dateReserveDateTime.add(Duration(hours: 7));
          String formattedDate = adjustedDateReserve.toLocal().toString();
          dateReserve = formattedDate.substring(0, 10);
          attendanceID = latestReservation['user_id'];
          reservationID = latestReservation['reservation_id'];
        });
      }
    }
  }
Future<Map<String,dynamic>> deleteLastReservation() async
{
  final url = Uri.parse('http://192.168.1.5:3000/deleteLastReservation');
  final response = await http.delete(url);
  if(response.statusCode== 200){
    print('delete successful');
    return json.decode(response.body);
  }
  else{
    throw Exception('Failed to delete  reservation');
  }
}
  @override
  void initState() {
    super.initState();
    fetchStartTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0, left: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              child: Center(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        color: Colors.green,
                      ),
                      Transform.translate(
                        offset: Offset(0, -75),
                        child: Text(
                          'Attendance Detection',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(-5, 40),
                        child: Container(
                          width: 600,
                          height: 900,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),

                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -810),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/correct.png',
                              width: Get.width*0.10,
                              height: Get.height*0.10,
                            ),
                            Text(
                              'Congratuation',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 22,
                                fontWeight: FontWeight.w600

                              ),
                            ),

                            Text(
                              'you are  member of our system already.\n                       Enjoy your work!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400

                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0,-30),
                              child: Image.asset(
                                'assets/picafterauthen.gif',
                                width: Get.width*0.40,
                                height: Get.height*0.25,
                              ),
                            ),
                             Transform.translate(
                               offset: Offset(0, -80),
                               child: Text(
                                'Mr.'+widget.name, // ใช้ค่า name ที่รับมาจาก constructor
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.brown
                                ),
                            ),
                             ),
                            Column(
                              children: [
                                Transform.translate(
                                  offset: Offset(-120,-30),
                                  child: Text(
                                    'Attendance ID',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                //เดี๋ยวต้องดึงข้อมูล Database ตรงนี้
                                Transform.translate(
                                  offset: Offset(-166,-25),
                                  child: Text(
                                    attendanceID.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.brown,


                                    ),
                                  ),
                                )
                              ],

                            ),
                            Column(
                              children: [
                                Transform.translate(
                                  offset: Offset(120,-87),
                                  child: Text(
                                    'Start - End  Time',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                //เดี๋ยวต้องดึงข้อมูล Database ตรงนี้
                                Transform.translate(
                                  offset: Offset(104,-81),
                                  child: Text(
                                    startTime + '-'+endTime,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.brown,


                                    ),
                                  ),
                                )
                              ],

                            ),
                            Column(
                              children: [
                                Transform.translate(
                                  offset: Offset(-160,-30),
                                  child: Text(
                                    'Role',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                //เดี๋ยวต้องดึงข้อมูล Database ตรงนี้
                                Transform.translate(
                                  offset: Offset(-156,-25),
                                  child: Text(
                                    "Host",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.brown,


                                    ),
                                  ),
                                )
                              ],

                            ),
                            Column(
                              children: [
                                Transform.translate(
                                  offset: Offset(72,-87),
                                  child: Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                //เดี๋ยวต้องดึงข้อมูล Database ตรงนี้
                                Transform.translate(
                                  offset: Offset(100,-81),
                                  child: Text(
                                    dateReserve,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.brown,


                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0, -60),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await fetchStartTime();
                                        final result = await Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ProofPage(name: widget.name, reservationID: reservationID),
                                        ));

                                        if (result != null && result is Map<String, dynamic>) {
                                          setState(() {
                                            startTime = result['startTime'];
                                            endTime = result['endTime'];
                                            dateReserve = result['dateReserve'];
                                            reservationID = result['reservationID'];
                                          });

                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                           backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 60,vertical: 8)
                                      ),
                                    child: Text(
                                      'Next',
                                      style:TextStyle(
                                        fontSize: 20,
                                      ) ,
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                    offset: Offset(0,-58),
                                child: ElevatedButton(
                                  onPressed:() async {
                                    final deleteResult = await deleteLastReservation();
                                    final result = await Navigator.of(context).push(
                                        MaterialPageRoute(builder:(context) => ReservationPage(),));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 48,vertical: 7)

                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  ),
                                ),)
                              ],

                            ),



                          ],

                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
