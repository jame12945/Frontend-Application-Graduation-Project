
import 'package:bookingapp/widgets/reservation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReservationWidget(),
    );
  }
}

