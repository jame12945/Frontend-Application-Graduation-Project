import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoundBookingByFacePage extends StatelessWidget {
  final dynamic reservationData;

  FoundBookingByFacePage({required this.reservationData});

  @override
  Widget build(BuildContext context) {
    String DateReserve = reservationData['date_reservation'];
    DateTime dateReserveDateTime = DateTime.parse(DateReserve);
    DateTime adjustedDateReserve = dateReserveDateTime.add(Duration(hours: 7));
    String formattedDate = adjustedDateReserve.toLocal().toString().substring(0,10);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/statusPic2.jpg'), // เปลี่ยนเป็นชื่อไฟล์ภาพที่คุณมี
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Container(
            padding: EdgeInsets.only(top: 250),
            child: Card(
              color: Color.fromRGBO(255, 255, 255, 0.45),
              margin: EdgeInsets.only(top: 16.0, right: 40.0, bottom:250, left: 40.0),

              child: Column(
                children: [
                  ListTile(
                    title: Text("Reservation ID"),
                    subtitle: Text("${reservationData["reservation_id"]}",style: TextStyle(color: Colors.black45),),
                    leading: Icon(Icons.confirmation_number, color: Colors.lightGreen
                  ),
            ),              Divider(),
                  ListTile(
                    title: Text("Start Time"),
                    subtitle: Text("${reservationData["start_time"]}",style: TextStyle(color: Colors.black45),),
                    leading: Icon(Icons.access_time, color: Colors.lightGreen),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("End Time"),
                    subtitle: Text("${reservationData["end_time"]}",style: TextStyle(color: Colors.black45),),
                    leading: Icon(Icons.access_time, color: Colors.lightGreen),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Date"),
                    subtitle: Text(formattedDate,style: TextStyle(color: Colors.black45),),
                    leading: Icon(Icons.date_range, color: Colors.lightGreen),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Create"),
                    subtitle: Text("${reservationData["create_reservlog"]}",style: TextStyle(color: Colors.black45),),
                    leading: Icon(Icons.create, color: Colors.lightGreen),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Update"),
                    subtitle: Text("${reservationData["update_reservlog"]}",style: TextStyle(color: Colors.black45),),
                    leading: Icon(Icons.update, color: Colors.lightGreen),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Attendee list"),
                    subtitle: Text("${reservationData["attendee_email"]}",style: TextStyle(color: Colors.black45),),
                    leading: Icon(Icons.people, color: Colors.lightGreen),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Door Status"),
                    subtitle: Text("Opening",style: TextStyle(color: Colors.black45),),
                    leading: Icon(Icons.door_front_door_outlined, color: Colors.lightGreen),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
