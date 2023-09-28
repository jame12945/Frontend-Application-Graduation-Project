import 'package:bookingapp/Utils/app.constrain.dart';
import 'package:bookingapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
Widget descriptionWidget(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          textWidget(text: AppConstants.Detail,fontSize: 22,fontWeight: FontWeight.w600,fontColor: Colors.black ),
          textWidget(text: AppConstants.Detaildescription,fontSize: 18,fontWeight: FontWeight.w500,fontColor: Colors.grey ),

        ],
      ),
    ),
  );
}