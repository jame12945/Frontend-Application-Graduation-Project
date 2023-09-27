import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget greenIntroWidget(){
  return Container(
    width:Get.width,
    decoration: BoxDecoration(
      image:DecorationImage(
        image: AssetImage('assets/Room4person-Home.jpg'),
      )
    ),
    height: Get.height*0.4,
  );
}