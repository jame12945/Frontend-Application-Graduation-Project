import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/StatusFirstRoomPage.dart';
import '../views/detail_page.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class allBookingWidget extends StatefulWidget {
  @override
  _allBookingWidgetState createState() => _allBookingWidgetState();
}

class _allBookingWidgetState extends State<allBookingWidget> {
  List<Map<String, dynamic>>? bookings;

  Future<List<Map<String, dynamic>>> getAllBooking() async {
    final String apiUrl ='${dotenv.env['BASE_URL']}selectAllRoomBooking';
    final response = await http.get(
      Uri.parse(apiUrl),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'ok') {
        List<Map<String, dynamic>> bookings = [];
        for (var booking in data['resultData']) {
          bookings.add({
            'reservation_id': booking['reservation_id'],
            'start_time': booking['start_time'],
            'end_time': booking['end_time'],
            'user_id': booking['user_id'],
            'date_reservation': booking['date_reservation'],
            'create_reservlog': booking['create_reservlog'],
            'update_reservlog': booking['update_reservlog'],
            'roomdetail_id': booking['roomdetail_id'],
            'attendee_email': booking['attendee_email'],
          });
          print('resuldata =====>');
          print(bookings);
        }
        return bookings;
      } else {
        throw Exception('Failed to load booking information');
      }
    }
    throw Exception('Failed to load booking information');
  }

  Future<void> fetchData() async {
    final result = await getAllBooking();
    bookings = result;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          color: Colors.black87,
          child: Stack(

            children: [
              // Add your UI widgets here
              Transform.translate(
                offset: Offset(30, 40),
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Reservation ID'
                    ,style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.brown,
                        fontSize: 15

                      ),)),
                    DataColumn(label: Text('Start Time',style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.brown,
                        fontSize: 15

                    ),)),
                    DataColumn(label: Text('End Time',style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.brown,
                        fontSize: 15

                    ),)),
                    DataColumn(label: Text('Date Reservation',style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.brown,
                        fontSize: 15

                    ),)),
                    DataColumn(label: Text('User ID',style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.brown,
                        fontSize: 15

                    ),)),
                  ],
                  rows: bookings?.map<DataRow>((booking) {
                    return DataRow(
                      cells: [
                        DataCell(Text(booking['reservation_id'].toString(),
                          style:TextStyle(
                            color: Colors.white
                          ) ,)),
                        DataCell(Text(booking['start_time'].toString(),
                          style:TextStyle(
                              color: Colors.white
                          ) ,)),
                        DataCell(Text(booking['end_time'].toString(),
                          style:TextStyle(
                              color: Colors.white
                          ) ,)),
                        DataCell(Text(
                          DateFormat('d/M/y').format(
                            DateTime.parse(booking['date_reservation']).toLocal(),
                          ),
                    style:TextStyle(
                    color: Colors.white
                    ) ,
                        )),
                        DataCell(Text(booking['user_id'].toString(),
                          style:TextStyle(
                              color: Colors.white
                          ) ,)),
                        // Add more DataCells for other columns
                      ],
                    );
                  }).toList() ?? [],
                ),
              ),
              Transform.translate(
                offset: Offset(10, 0),
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.symmetric(horizontal: 100,vertical: 1120),
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => StatusPage())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,

                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                             backgroundColor: Colors.brown,
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
      ),
    );
  }
}
