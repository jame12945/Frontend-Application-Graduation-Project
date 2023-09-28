
import '../widgets/detail_widget.dart';
import '../widgets/description_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/green_Intro_widget.dart';

class DetailPage extends StatelessWidget{
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,//ไว้บน children ถ้าจะขยับไรงี้
          children: [
            greenIntroWidget(),
            const SizedBox(height: 10,),
            detailWidget(),
            const SizedBox(height: 18,),
            descriptionWidget(),
          ],
        ),
      ),
    );
  }
}