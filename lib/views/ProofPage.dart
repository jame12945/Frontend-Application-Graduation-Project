import 'package:bookingapp/widgets/proof_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class  ProofPage extends StatelessWidget{

  final String name;
  ProofPage({required this.name});  @override
  Widget build (BuildContext context){
    return Scaffold(
       body: ProofWidget(name: name)
    );
  }
}