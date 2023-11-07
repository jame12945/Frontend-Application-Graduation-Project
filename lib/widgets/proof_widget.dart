import 'package:bookingapp/views/detail_page.dart';
import 'package:bookingapp/widgets/detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProofWidget extends StatefulWidget{
  final String name;
  final int reservationID;
  ProofWidget({required this.name,required this.reservationID});


  @override
  _ProofWidgetState createState() => _ProofWidgetState();

}
class  _ProofWidgetState extends State<ProofWidget>{
  Widget build (BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(

        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0, left: 0),
        child: Container(
          color: Colors.green,
          width: 800,
          height:1400,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: Offset(0, 120),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(

                    width: 600,
                    height: 1000,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Transform.translate(
                      offset: Offset(0, 80),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text('Room Confirmed '
                        ,style:TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700
                          ) ,),
                      ),
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(310, -770),
                child: Image.asset(
                    'assets/correct.png',
                  width: Get.width*0.25,
                  height: Get.height*0.25,
                ),
              ),
              Transform.translate(
                offset:  Offset(190, -780),
                child: Text(
                  'Please check your email for room \n        confirmation and details.',
                  style: TextStyle(
                    fontSize: 26
                  ),
                ),
              ),
              Transform.translate(
                offset:  Offset(270, -730),
                child: Row(
                  children: [
                    Text(
                      'Host Name :',
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.black54
                      ),
                    ),
                    Text(
                      '   '+widget.name,
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.green
                      ),
                    ),


                  ],
                ),
              )
              ,
              Transform.translate(
                offset:  Offset(270, -730),
                child: Row(
                  children: [
                    Text(
                      'Booking ID  :',
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.black54
                      ),
                    ),
                    Text(
                      '    ' + widget.reservationID.toString(),
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.green
                      ),
                    ),


                  ],
                ),
              ),
              Transform.translate(
                  offset:Offset(290, -650),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPage(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 80,vertical: 10)
                  ),
                  child: Text(
                    'Return',
                    style:TextStyle(
                      fontSize: 24,
                    ) ,
                  ),
                ),

              )

            ],

          ),
        ),
      ),
    );
  }
}