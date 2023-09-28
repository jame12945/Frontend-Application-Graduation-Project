import 'package:bookingapp/Utils/app.constrain.dart';
import 'package:bookingapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
Widget detailWidget(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Expanded(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,

         children: [

           textWidget(text: AppConstants.topicRoom),
           textWidget(text: AppConstants.detailtopicRoom,fontSize: 20,fontWeight: FontWeight.w500,fontColor: Colors.grey )
         ],
       ),
    ),
  );
}