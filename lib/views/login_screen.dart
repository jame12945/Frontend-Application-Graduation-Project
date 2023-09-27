
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/green_Intro_widget.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
                       greenIntroWidget()
          ],
        ),
      ),
    );
  }
}