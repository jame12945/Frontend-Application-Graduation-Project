import 'dart:convert';
import 'dart:io';

import 'package:bookingapp/services/api.dart';
import 'package:bookingapp/views/AuthorizePage.dart';
import 'package:bookingapp/views/FoundUserPage.dart';
import 'package:bookingapp/views/HomePage.dart';
import 'package:bookingapp/widgets/authorize_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
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
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  TextEditingController dateInput       = TextEditingController();
  List<String> emails=['63010382@kmitl.ac.th','63010445@kmitl.ac.th','63010522@kmitl.ac.th','63010630@kmitl.ac.th','63010631@kmitl.ac.th','63010632@kmitl.ac.th'];
  List<String> images = [];
  List<String?> _availableTimes = [
    '6:00:00', '7:00:00', '8:00:00',
    '9:00:00', '10:00:00', '11:00:00',
    '12:00:00', '13:00:00', '14:00:00',
    '15:00:00', '16:00:00', '17:00:00',
    '18:00:00', '19:00:00', '20:00:00',
    '21:00:00', '22:00:00', '23:00:00',
    '0:00:00', '1:00:00', '2:00:00',
    '3:00:00', '4:00:00', '5:00:00',
  ];

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

  List<DropdownMenuItem<String?>> _buildDropdownMenuItems() {
    return _availableTimes.map((String? value) {
      return DropdownMenuItem<String?>(
        value: value,
        child: Text(
          value ?? '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
      );
    }).toList();
  }

  void sendReservationData() async {
    final String url = 'http://10.0.2.2:3000/appreserveroom/9'; // แก้ไข URL ตามที่คุณต้องการ

    final Map<String, dynamic> reservationData = {
      "start_time": _selectedValue, // แก้ไขค่าตามที่คุณต้องการ
      "end_time": _selectedEndTimeValue, // แก้ไขค่าตามที่คุณต้องการ
      "date_reservation": dateInput.text, // แก้ไขค่าตามที่คุณต้องการ
      "update_reservlog": "2020-10-23", // แก้ไขค่าตามที่คุณต้องการ

    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(reservationData),
    );

    if (response.statusCode == 200) {
      // บันทึกข้อมูลสำเร็จ

      print('บันทึกข้อมูลการจองสำเร็จ');
    } else {
      // มีข้อผิดพลาดในการบันทึกข้อมูล
      print('ไม่สามารถบันทึกข้อมูลการจอง รหัสสถานะ: ${response.statusCode}');
    }

  }
  Future<void> fetchEmailsFromAPI() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/selectAttendee'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<String> apiEmails = List<String>.from(data['email']);

        setState(() {
          emails = apiEmails;
        });
      } else {
        print('Failed to fetch emails from API');
      }
    } catch (error) {
      print('Error: $error');
    }
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
                padding: const EdgeInsets.only(top: 490, left: 85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
                        Column(
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
                                    width: Get.width * 0.35,
                                    height: Get.height*0.04,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Colors.brown, width: 1.0),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Selected Time'),
                                              content: Container(
                                                width: 300,
                                                height: 300,
                                                child: ListView.builder(
                                                  itemCount: _availableTimes.length,
                                                  itemBuilder: (context, index) {
                                                    final time = _availableTimes[index];
                                                    if (_selectedValue == time) {
                                                      return SizedBox.shrink();
                                                    } else {
                                                      return ListTile(
                                                        title: Text(time ?? ''),
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedValue = time;
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
                                      child: Row(
                                        children: [
                                          Transform.translate(
                                              offset: Offset(10, 0),
                                              child: Icon(Icons.access_time,
                                                size: 35,)
                                          ),
                                          SizedBox(width: 10),
                                          Transform.translate(
                                            offset: Offset(40, 0),
                                            child: Text(
                                              _selectedValue ?? "Choose time",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 20),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Text(
                                    'End Time',
                                    style: TextStyle(
                                      fontSize: 21,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,top:40),
                                  child: Container(
                                    width: Get.width * 0.35,
                                    height: Get.height*0.04,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Colors.brown, width: 1.0),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Selected Time'),
                                              content: Container(
                                                width: 300,
                                                height: 300,
                                                child: ListView.builder(
                                                  itemCount: _availableTimes.length,
                                                  itemBuilder: (context, index) {
                                                    final time = _availableTimes[index];
                                                    if (_selectedEndTimeValue == time) {
                                                      return SizedBox.shrink();
                                                    } else {
                                                      return ListTile(
                                                        title: Text(time ?? ''),
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedEndTimeValue = time;
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
                                      child: Row(
                                        children: [
                                          Transform.translate(
                                              offset: Offset(10, 0),
                                              child: Icon(Icons.access_time,size: 35,)
                                          ),
                                          SizedBox(width: 10),
                                          Transform.translate(
                                            offset: Offset(40, 0),
                                            child: Text(
                                              _selectedEndTimeValue ?? "Choose time",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                            onPressed: () async{
                              await fetchEmailsFromAPI();
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
                                  sendReservationData();
                                  var data = {
                                    "pname":_nameController.text,
                                    "pphone": _phoneController.text,
                                    "pemail":_emailController.text
                                  };
                                  Api.addproduct(data);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AuthorizePage(),
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