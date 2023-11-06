import 'package:bookingapp/views/ProofPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class FoundUserPage extends StatefulWidget {
  final String name;


  FoundUserPage({required this.name});

  @override
  _FoundUserPageState createState() => _FoundUserPageState();
}

class _FoundUserPageState extends State<FoundUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0, left: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              child: Center(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        color: Colors.green,
                      ),
                      Transform.translate(
                        offset: Offset(0, -75),
                        child: Text(
                          'Attendance Detection',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(-5, 40),
                        child: Container(
                          width: 600,
                          height: 900,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),

                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -810),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/correct.png',
                              width: Get.width*0.10,
                              height: Get.height*0.10,
                            ),
                            Text(
                              'Congratuation',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 22,
                                fontWeight: FontWeight.w600

                              ),
                            ),

                            Text(
                              'you are  member of our system already.\n                       Enjoy your work!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400

                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0,-30),
                              child: Image.asset(
                                'assets/picafterauthen.gif',
                                width: Get.width*0.40,
                                height: Get.height*0.25,
                              ),
                            ),
                             Transform.translate(
                               offset: Offset(0, -80),
                               child: Text(
                                'Mr.'+widget.name, // ใช้ค่า name ที่รับมาจาก constructor
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.brown
                                ),
                            ),
                             ),
                            Column(
                              children: [
                                Transform.translate(
                                  offset: Offset(-120,-30),
                                  child: Text(
                                    'Attendance ID',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                //เดี๋ยวต้องดึงข้อมูล Database ตรงนี้
                                Transform.translate(
                                  offset: Offset(-166,-25),
                                  child: Text(
                                    "10",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.brown,


                                    ),
                                  ),
                                )
                              ],

                            ),
                            Column(
                              children: [
                                Transform.translate(
                                  offset: Offset(120,-87),
                                  child: Text(
                                    'Start - End  Time',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                //เดี๋ยวต้องดึงข้อมูล Database ตรงนี้
                                Transform.translate(
                                  offset: Offset(104,-81),
                                  child: Text(
                                    "19.00-20.00",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.brown,


                                    ),
                                  ),
                                )
                              ],

                            ),
                            Column(
                              children: [
                                Transform.translate(
                                  offset: Offset(-160,-30),
                                  child: Text(
                                    'Role',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                //เดี๋ยวต้องดึงข้อมูล Database ตรงนี้
                                Transform.translate(
                                  offset: Offset(-156,-25),
                                  child: Text(
                                    "Host",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.brown,


                                    ),
                                  ),
                                )
                              ],

                            ),
                            Column(
                              children: [
                                Transform.translate(
                                  offset: Offset(72,-87),
                                  child: Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                //เดี๋ยวต้องดึงข้อมูล Database ตรงนี้
                                Transform.translate(
                                  offset: Offset(100,-81),
                                  child: Text(
                                    "2023-11-16",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.brown,


                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0, -10),
                                  child: ElevatedButton(
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => ProofPage(name: widget.name),
                                        ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                           backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 60,vertical: 8)
                                      ),
                                    child: Text(
                                      'Next',
                                      style:TextStyle(
                                        fontSize: 20,
                                      ) ,
                                    ),
                                  ),
                                )
                              ],

                            ),



                          ],

                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
