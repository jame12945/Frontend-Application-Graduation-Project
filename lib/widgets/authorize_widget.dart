import 'package:bookingapp/views/AuthorizePage.dart';
import 'package:bookingapp/views/FoundUserPage.dart';
import 'package:bookingapp/views/ReservationProcess_Page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';



class AuthorizeWidget extends StatefulWidget {
  @override
  _AuthorizeWidgetState createState() => _AuthorizeWidgetState();
}

class _AuthorizeWidgetState extends State<AuthorizeWidget> {
  CameraController? controller;
  bool isError = false;
  bool isLoading = true;
  bool isIdentityVerified = false;
  bool newName = false;
  bool notShow = false;
  String name = "";

  // String? detectedName;


  @override
  void initState() {
    super.initState();
    initCamera();
    resetName();
  }

  void initCamera() async {
    try {
      await requestPermission();
      final cameras = await availableCameras();
      // เลือกกล้องหน้า
      final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
      );
      controller = CameraController(frontCamera, ResolutionPreset.medium);

      // รอให้คอนโทรลเลอร์เตรียมพร้อม
      await controller?.initialize();

      if (mounted) {
        setState(() {});
      }

      // เรียกใช้ captureAndSaveImage เมื่อกล้องเริ่มทำงาน
      final path = '/storage/emulated/0/Download';
      Future.delayed(Duration(seconds: 2),(){
        captureAndSaveImage();
        uploadImage(File('$path/image.jpg'));
      });
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> requestPermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print("Storage permission granted");
      // ทำงานที่ต้องการทำหลังจากได้รับสิทธิ์
    } else {
      print("Storage permission denied");
      // จัดการกรณีที่ไม่ได้รับสิทธิ์
    }
  }

  void captureAndSaveImage() async {
    if (controller != null && controller!.value.isInitialized) {
      try {
        final path = '/storage/emulated/0/Download';
        final directory = Directory(path);
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }
        if (controller!.value.isTakingPicture) {
          print("Camera is already taking a picture");
        } else {
          final image = await controller!.takePicture();
          final imageBytes = await image.readAsBytes();
          final saveFile = File('$path/image.jpg');
          await saveFile.writeAsBytes(imageBytes);
          print("Image saved successfully");
          final imageFile = File('/storage/emulated/0/Download/image.jpg');
          if (imageFile.existsSync()) {
            print('Have Picture In Path');

            // ตอนนี้เรียก uploadImage ด้วยไฟล์ที่ถูกบันทึกแล้ว
            uploadImage(saveFile);
            setState(() {
              isLoading = false;
            });
            Future.delayed(Duration(seconds: 1),(){
              setState(() {
                isError = true;
              });
            });


          } else {
            print('Dont Have Picture In Path');
          }
        }
      } catch (e) {
        print("Error capturing and saving image: $e");
      }
    }
  }
  void resetName() {
    setState(() {
      name = "";
    });
  }
  void captureAndVerifyIdentity(){
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        isLoading = true;
        isIdentityVerified = true;
      });
    });
  }


  void uploadImage(File imageFile) async {
    final String apiUrl ='${dotenv.env['BASE_URL2']}recognize-face/';
    final modelUrl = Uri.parse(apiUrl);

    final request = http.MultipartRequest('POST', modelUrl);
    request.files.add(
      http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'image.jpg',
      ),
    );
    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('อัปโหลดภาพสำเร็จ');

        // ดำเนินการตรวจสอบ recognized_data ที่ถูกส่งกลับจากเซิร์ฟเวอร์
        final responseJson = await response.stream.bytesToString();
        print('รับข้อมูลจากเซิร์ฟเวอร์: $responseJson');

        // แปลง JSON ไปเป็น Map
        Map<String, dynamic> data = json.decode(responseJson);

        // อ่านชื่อจาก Map
        String recognizedName = data["name"];


        // อัปเดตค่า name ด้วยชื่อที่ได้รับจากเซิร์ฟเวอร์
        setState(() {
          name = recognizedName;
          isIdentityVerified = true;
        });


        print(newName);
        if (newName == true) {
          setState(() {
            name = recognizedName;
            newName = true;
          });
          await sendNameToServer(name);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoundUserPage(name: recognizedName),
            ),
          );
        } //ถ้าไม่ค่า name เหมือนเดิมให้ส่งค่า newName = true
        else if (recognizedName == name) {

          setState(() {
            newName = true;
          });
        }

        else {
          setState(() {
            newName = false;
          });
        }
      }
    }catch (e) {
      setState(() {
        newName = true;

      });
    }

  }
  Future<void> sendNameToServer(String name) async {
    final String apiUrl ='${dotenv.env['BASE_URL']}faceRecognition';
    final nodeUrl = Uri.parse(apiUrl);
    final Map<String, dynamic> nameData = {
      "nameFromFaceRecognition": name,
    };

      final response = await http.post(
        nodeUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(nameData),
      );

      if (response.statusCode == 200) {
        print('ส่งค่า name ไปยังเซิร์ฟเวอร์สำเร็จ');
        print('Response from server: ${response.body}');
      } else {
        print('ไม่สามารถส่งค่า name ไปยังเซิร์ฟเวอร์ รหัสสถานะ: ${response
            .statusCode}');
      }

  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return CircularProgressIndicator();
    }


    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 1220,
                color: Color(0xFF101010),
                child: Transform.translate(
                  offset: Offset(0.0, -100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 130.0, vertical: 180),
                    child: RotationTransition(turns: AlwaysStoppedAnimation(0/360),
                      child: CameraPreview(controller!),)
                    ,
                  ),

                ),


              ),


              Transform.translate(
                offset: Offset(0, -1100),
                child: Text(
                  "Look at the camera",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white

                  ),
                ),
              ),



            ],
          ),
          if (isLoading)
            Transform.translate(
              offset: Offset(0.0, -300),
              child: Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Text("loading",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20
                      ),
                    ),
                  ),



                ],
              ),
            ),
          if(isError == true)
            Transform.translate(
              offset: Offset(0.0, -200.0),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top:0.0),
                    child: ElevatedButton(
                      onPressed:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>AuthorizePage())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,


                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        padding:EdgeInsets.symmetric(horizontal: 100 , vertical: 10)
                        ,
                      ),
                      child: Text("Retry",style: TextStyle(
                        color: Colors.red,
                        fontSize: 26,

                      ),),

                    ),
                  )
              ),
            )


        ],
      ),
    );
  }
}
