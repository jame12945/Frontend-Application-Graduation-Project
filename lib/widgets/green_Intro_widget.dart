import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget greenIntroWidget() {
  return Container(
    width: Get.width,
    height: Get.height * 0.52,
    child: Transform.translate(
      offset: Offset(0.0, -40.0), // ขยับขึ้นไป 10px ด้านบน
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Room4person-Home.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 58.0),
                child: Image.asset(
                  'assets/backIcon.png',
                  width: Get.width * 0.05,
                  height: Get.height * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
