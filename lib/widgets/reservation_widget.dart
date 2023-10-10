import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class ReservationWidget extends StatefulWidget {
  @override
  _ReservationWidgetState createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {
  String? _selectedValue;
  String? _selectedEndTimeValue;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController dateInput       = TextEditingController();

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

    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Stack(
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
            padding: const EdgeInsets.only(top: 520, left: 60),
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
                Text('Dates',style: TextStyle(fontSize: 21),),
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



              ],
            ),
          ),
        ],
      ),
    );
  }
}
