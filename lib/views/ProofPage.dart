import 'package:bookingapp/widgets/proof_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class  ProofPage extends StatelessWidget{

  final String name;
  final int reservationID;
  ProofPage({required this.name,required this.reservationID});  @override
  Widget build (BuildContext context){
    String startTime = ''; // ดึงค่า startTime จาก FoundUserPage
    String endTime = ''; // ดึงค่า endTime จาก FoundUserPage
    String dateReserve = '';
    return Scaffold(
       body: ProofWidget(
         name: name,
         reservationID: reservationID,
         startTime: startTime,
         endTime: endTime,
         dateReserve: dateReserve,)
    );
  }
}