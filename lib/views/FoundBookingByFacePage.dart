import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FoundBookingByFacePage extends StatefulWidget {
  final dynamic reservationData;

  FoundBookingByFacePage({required this.reservationData});

  @override
  _FoundBookingByFacePageState createState() => _FoundBookingByFacePageState();
}

class _FoundBookingByFacePageState extends State<FoundBookingByFacePage> {
  String doorStatus = 'Fetching...';

  @override
  void initState() {
    super.initState();
    closeDoor();
  }

  Future<void> fetchDoorStatus() async {
    final response = await http.get(Uri.parse('http://192.168.1.10/status'));
    if (response.statusCode == 200) {
      setState(() {
        doorStatus = response.body;
      });
    } else {
      setState(() {
        doorStatus = 'Error fetching status';
      });
    }
  }

  Future<void> closeDoor() async {
    final response = await http.get(Uri.parse('http://192.168.1.10/open'));
    if (response.statusCode == 200) {
      fetchDoorStatus(); // Update door status after opening
    } else {
      // Handle error opening door
    }
  }

  Future<void> openDoor() async {
    final response = await http.get(Uri.parse('http://192.168.1.10/close'));
    if (response.statusCode == 200) {
      fetchDoorStatus();
    } else {
      // Handle error closing door
    }
  }

  @override
  Widget build(BuildContext context) {
    String DateReserve = widget.reservationData['date_reservation'];
    DateTime dateReserveDateTime = DateTime.parse(DateReserve);
    DateTime adjustedDateReserve = dateReserveDateTime.add(Duration(hours: 7));
    String formattedDate = DateFormat('yyyy-MM-dd').format(adjustedDateReserve);




    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/statusPic2.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
          child: Card(
            color: Color.fromRGBO(255, 255, 255, 0.45),
            margin: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 220),
            child: Column(
              children: [
                ListTile(
                  title: Text("Reservation ID"),
                  subtitle: Text("${widget.reservationData["reservation_id"]}", style: TextStyle(color: Colors.black45)),
                  leading: Icon(Icons.confirmation_number, color: Colors.lightGreen),
                ),
                Divider(),
                ListTile(
                  title: Text("Start Time"),
                  subtitle: Text("${widget.reservationData["start_time"]}", style: TextStyle(color: Colors.black45)),
                  leading: Icon(Icons.access_time, color: Colors.lightGreen),
                ),
                Divider(),
                ListTile(
                  title: Text("End Time"),
                  subtitle: Text("${widget.reservationData["end_time"]}", style: TextStyle(color: Colors.black45)),
                  leading: Icon(Icons.access_time, color: Colors.lightGreen),
                ),
                Divider(),
                ListTile(
                  title: Text("Date"),
                  subtitle: Text(formattedDate, style: TextStyle(color: Colors.black45)),
                  leading: Icon(Icons.date_range, color: Colors.lightGreen),
                ),
                Divider(),
                ListTile(
                  title: Text("Create"),
                  subtitle: Text("${widget.reservationData["create_reservlog"]}", style: TextStyle(color: Colors.black45)),
                  leading: Icon(Icons.create, color: Colors.lightGreen),
                ),
                Divider(),
                ListTile(
                  title: Text("Update"),
                  subtitle: Text("${widget.reservationData["update_reservlog"]}", style: TextStyle(color: Colors.black45)),
                  leading: Icon(Icons.update, color: Colors.lightGreen),
                ),
                Divider(),
                ListTile(
                  title: Text("Attendee list"),
                  subtitle: Text("${widget.reservationData["attendee_email"]}", style: TextStyle(color: Colors.black45)),
                  leading: Icon(Icons.people, color: Colors.lightGreen),
                ),
                Divider(),
                ListTile(
                  title: Text("Door Status"),
                  subtitle: Text("Opening", style: TextStyle(color: Colors.black45)),
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
