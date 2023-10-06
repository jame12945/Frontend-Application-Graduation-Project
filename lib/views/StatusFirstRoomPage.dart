
import 'package:bookingapp/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              statusWidget()

            ],
          ),
        )
    );
  }
}



