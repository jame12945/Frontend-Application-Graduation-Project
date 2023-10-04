import 'package:flutter/material.dart';
import 'package:bookingapp/Utils/app.constrain.dart';
import 'package:bookingapp/views/HomePage.dart';
import 'package:bookingapp/widgets/text_widget.dart';

Widget detailWidget(BuildContext context) { // เพิ่มพารามิเตอร์ context
  Color customColor = Color(0xFFF6E6D1);
  List<String> imageNames = [
    'Wifi.png',
    'air-conditioner.png',
    'Face-recognition.png',
    'Toilet.png',
    'Snack.png',
    'Computer.png',
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(text: AppConstants.topicRoom),
        textWidget(text: AppConstants.detailtopicRoom, fontSize: 20, fontWeight: FontWeight.w500, fontColor: Colors.grey),
        const SizedBox(
          height: 20,
        ),
        textWidget(text: AppConstants.Detail, fontSize: 22, fontWeight: FontWeight.w600, fontColor: Colors.black),
        textWidget(text: AppConstants.Detaildescription, fontSize: 18, fontWeight: FontWeight.w500, fontColor: Colors.grey),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Row(
            children: List.generate(
              6,
                  (index) => Container(
                width: 50, // ปรับขนาดตามที่คุณต้องการ
                height: 50, // ปรับขนาดตามที่คุณต้องการ
                margin: EdgeInsets.only(right: 28), // ระยะห่างระหว่างสี่เหลี่ยม
                child: ClipRect(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: customColor,
                    ),
                    padding: EdgeInsets.all(8.0), // ปรับขนาดรูปลง 10px ที่ด้านขอบของสี่เหลี่ยม
                    child: Image.asset('assets/${imageNames[index]}'),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child:ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // สีพื้นหลัง
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)
                ),
                padding:EdgeInsets.symmetric(horizontal: 40 , vertical: 10)
            ),

            child: Text(
              'Booking',
              style: TextStyle(
                color: Colors.white, // สีข้อความ
                fontSize: 20,

              ),
            ),
          ),
        ),

      ],
    ),
  );
}
