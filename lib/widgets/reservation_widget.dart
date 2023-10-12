import 'dart:io';

import 'package:bookingapp/views/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
class ReservationWidget extends StatefulWidget {
  @override
  _ReservationWidgetState createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {
  String? _selectedValue;
  String? _selectedEndTimeValue;
  List<String> selectedEmails = [];
  String selectedEmail ='';
  bool showEmailList = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController dateInput       = TextEditingController();
  List<String> emails=['63010382@kmitl.ac.th','63010445@kmitl.ac.th','63010522@kmitl.ac.th','63010630@kmitl.ac.th','63010631@kmitl.ac.th','63010632@kmitl.ac.th'];
  List<String> images = [];

  Future<void> _addImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        images.add(pickedFile.path);
      });
    }
  }
  Future<void> _inviteByEmail() async {
    final email = 'recipient@example.com';
    final subject = 'Invitation to view images';
    final body = 'Check out these images: ${images.join(', ')}';

    final url = 'mailto:$email?subject=$subject&body=$body';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error if unable to launch the URL
      print('Could not launch $url');
    }
  }


  @override
  void dispose() {
    // ควรจะ dispose controllers เมื่อไม่ได้ใช้งานเพื่อป้องกันการหลุดหน่วยความจำ
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    dateInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color customColor = Color(0xFFDAC3A6);

    return SingleChildScrollView(

      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Room4person-Home.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 400),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 9),
                    decoration: BoxDecoration(
                      color: customColor,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Text(
                      ' Room 1',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        backgroundColor: customColor,
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 490, left: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 21),
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: _nameController,
                          style: TextStyle(color: Colors.brown, fontSize: 18),
                          decoration: InputDecoration(hintText: 'Enter your name'),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Phone',
                      style: TextStyle(fontSize: 21),
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: _phoneController,
                          style: TextStyle(color: Colors.brown, fontSize: 18),
                          decoration: InputDecoration(hintText: 'Enter your phone'),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 21),
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.brown, fontSize: 18),
                          decoration: InputDecoration(hintText: 'Enter your email'),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Text('Date',style: TextStyle(fontSize: 21),),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                         width: 640,
                          child: Center(

                              child: TextField(
                                style: TextStyle(fontSize: 18) ,
                                controller: dateInput,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_today), //icon of text field
                                    labelText: "Enter Date" //label text of field
                                ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100),
                                  );

                                  if (pickedDate != null) {
                                    print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                              ))),
                    )
,
                    Stack(
                     children: [
                       Row(
                         children: [
                           Stack(
                             children: [
                               Text(
                                 'Start Time',
                                 style: TextStyle(
                                   fontSize: 21,
                                 ),
                               ),
                               SizedBox(height: 6),
                               Padding(
                                 padding: const EdgeInsets.only(top: 40.0),
                                 child: Container(
                                   width: Get.width*0.35,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(8.0),
                                     border: Border.all(color: Colors.brown, width: 1.0),
                                   ),
                                   child: DropdownButton<String?>(
                                     icon: Padding(
                                       padding: const EdgeInsets.only(left: 68.0),
                                       child: Icon(Icons.arrow_drop_down_circle_outlined),
                                     ),
                                     items: <String?>['18.00', '19.00','20.00', '21.00', '22.00'].map<DropdownMenuItem<String?>>((String? value) {
                                       return DropdownMenuItem<String?>(
                                         value: value,
                                         child: Padding(
                                           padding: const EdgeInsets.only(left: 100.0),
                                           child: Text(
                                             value ?? '',
                                             style: TextStyle(
                                               color: Colors.black,
                                               fontSize: 19,

                                             ),
                                           ),
                                         ),
                                       );
                                     }).toList(),
                                     onChanged: (String? value) {
                                       setState(() {
                                         _selectedValue = value;
                                       });
                                       print('value');
                                       print(_selectedValue);
                                     },
                                     hint: Padding(
                                       padding: const EdgeInsets.only(left: 48.0),
                                       child: Text(
                                         " Choose time",
                                         style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 18,
                                         ),
                                       ),
                                     ),
                                     value: _selectedValue,
                                   ),

                                 ),
                               ),

                             ],
                           ),


                           Stack(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(left:84.0),
                                 child: Text(
                                   'End Time',
                                   style: TextStyle(
                                     fontSize: 21,
                                   ),
                                 ),
                               ),
                               SizedBox(height: 4),
                               Padding(
                                 padding: const EdgeInsets.only(left: 84.0,top:40),
                                 child: Container(
                                   width: Get.width*0.35,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(8.0),
                                     color: Colors.white,
                                     border: Border.all(color: Colors.brown, width: 1.0),
                                   ),
                                   child: DropdownButton<String?>(
                                     icon: Padding(
                                       padding: const EdgeInsets.only(left: 68.0),
                                       child: Icon(Icons.arrow_drop_down_circle_outlined),
                                     ),
                                     items: <String?>[ '19.00','20.00', '21.00', '22.00'].map<DropdownMenuItem<String?>>((String? value) {
                                       return DropdownMenuItem<String?>(
                                         value: value,
                                         child: Padding(
                                           padding: const EdgeInsets.only(left: 100.0),
                                           child: Text(
                                             value ?? '',
                                             style: TextStyle(
                                               color: Colors.black,
                                               fontSize: 19,

                                             ),
                                           ),
                                         ),
                                       );
                                     }).toList(),
                                     onChanged: (String? value) {
                                       setState(() {
                                         _selectedEndTimeValue = value;
                                       });
                                       print('value');
                                       print(_selectedEndTimeValue);
                                     },
                                     hint: Padding(
                                       padding: const EdgeInsets.only(left: 48.0),
                                       child: Text(
                                         " Choose time",
                                         style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 18,
                                         ),
                                       ),
                                     ),
                                     value: _selectedEndTimeValue,
                                   ),

                                 ),
                               ),
                             ],
                           ),

                         ],
                       )
                     ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text('Add Attendee',style: TextStyle(fontSize: 21),),
                        Transform.translate(
                          offset: Offset(0.0, 1.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 220.0),
                            child: Text('Attendee Join',style: TextStyle(fontSize: 21),),
                          ),
                        )

                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 650),
                          width: 80,
                          height: 80,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Selected Attendee Email'),
                                    content: Container(
                                      width: 300, // ปรับขนาดของ Dialog ตามที่ต้องการ
                                      height: 300, // ปรับขนาดของ Dialog ตามที่ต้องการ
                                      child: ListView.builder(
                                        itemCount: emails.length,
                                        itemBuilder: (context, index) {
                                          final email = emails[index];
                                          if (selectedEmails.contains(email)) {
                                            // ไม่แสดง email ที่ถูกเลือกแล้ว
                                            return SizedBox.shrink(); // จะทำให้รายการไม่แสดง
                                          }
                                          else {
                                            return ListTile(
                                              title: Text(emails[index]),
                                              onTap: () {
                                                setState(() {
                                                  selectedEmails.add(emails[index]); // เพิ่มรายชื่อ Email ที่ถูกเลือก
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          }

                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Image.asset('assets/icons8-add-50.png'),
                          ),
                        ),
                        if (selectedEmails.isNotEmpty)
                          Padding(
                            
                            padding: const EdgeInsets.only(left: 365.0),
                            child: Container(
                              
                              child: Transform.translate(
                                offset: Offset(0.0, -62.0),
                                child: Column(
                                  children: selectedEmails.map((email) {
                                    return Row(
                                      children: [
                                        Container(
                                         width: 40 , height: 60,
                                            child: Image.asset('assets/icons8-person.png')),
                                        SizedBox(height: 40), // ระยะห่างระหว่าง icon และรายชื่อ Email
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Text(email,style: TextStyle(fontSize: 18),),
                                        ), // แสดงรายชื่อ Email ที่ถูกเลือก
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        Transform.translate(
                          offset: Offset(-30,-15),
                          child: Container(

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
                                  padding:EdgeInsets.symmetric(horizontal: 150 , vertical: 10)
                              ),

                              child: Text(
                                'Booking',
                                style: TextStyle(
                                  color: Colors.white, // สีข้อความ
                                  fontSize: 22,

                                ),
                              ),
                            ),
                        )
                        )
                      ],
                    )

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
