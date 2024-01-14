import 'package:flutter/material.dart';
import '../widgets/allBooking_widget.dart';
class AllBookingPage extends StatelessWidget {
  const AllBookingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:allBookingWidget()
    );
  }
}
