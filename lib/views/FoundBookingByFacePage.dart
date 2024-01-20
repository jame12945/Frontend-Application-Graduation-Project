import 'package:bookingapp/views/AuthorizePage.dart';
import 'package:bookingapp/views/FoundUserPage.dart';
import 'package:bookingapp/views/ReservationProcess_Page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../views/detail_page.dart';
import 'package:permission_handler/permission_handler.dart';

class FoundBookingByFacePage extends StatelessWidget {
  final dynamic reservationData;
  FoundBookingByFacePage({required this.reservationData});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text("Reservation Details")

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("Reservation ID:${reservationData["reservation_id"]}"),
            Text("Start Time: ${reservationData["start_time"]}"),
            Text("End Time: ${reservationData["end_time"]}"),
            Text("Date: ${reservationData["date_reservation"]}"),
            Text("Create: ${reservationData["create_reservlog"]}"),
            Text("Update: ${reservationData["update_reservlog"]}"),
            Text("attendee list: ${reservationData["attendee_email"]}"),
          ]
        ),
      ),
    );
  }
}