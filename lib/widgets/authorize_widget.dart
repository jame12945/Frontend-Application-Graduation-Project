import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class AuthorizeWidget extends StatefulWidget {
  @override
  _AuthorizeWidgetState createState() => _AuthorizeWidgetState();
}

class _AuthorizeWidgetState extends State<AuthorizeWidget> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    controller = CameraController(camera, ResolutionPreset.medium);

    // Ensure the controller is initialized
    await controller?.initialize();

    if (mounted) {
      setState(() {});
    }

    // เรียกใช้ captureAndSaveImage เมื่อกล้องถูกเริ่มใช้งาน
    Future.delayed(Duration(seconds: 2),(){
      captureAndSaveImage();
    });

  }
  void captureAndSaveImage() async{
    if(controller!=null && controller!.value.isInitialized){
      try{
          final path = '/storage/emulated/0/Android/data/com.example.bookingapp/files/GetPic';
          final directory = Directory(path);
          if(!directory.existsSync()){
            directory.createSync(recursive: true);
          }
          if(controller!.value.isTakingPicture){
            print("Camera is already taking a picture");
          }
          else{
            final image = await controller!.takePicture();
            final imageBytes = await image.readAsBytes();
            final saveFile = File('$path/image.jpg');
            await saveFile.writeAsBytes(imageBytes);
            print("Image saved succesfully");
            final imageFile = File('/storage/emulated/0/Android/data/com.example.bookingapp/files/GetPic/image.jpg');
            if(imageFile.existsSync()){
              print('Have Picture In Path');
            }else{
              print('Dont Have Picture In Path');
            }
          }
      }
      catch(e){
        print("Error capyuring and saving image: $e");
      }
    }
  }

  // Future<void> uploadImage(File imageFile) async {
  //   final url = Uri.parse('YOUR_BACKEND_UPLOAD_URL');
  //   final request = http.MultipartRequest('POST', url);
  //   request.files.add(
  //     http.MultipartFile(
  //       'image',
  //       imageFile.readAsBytes().asStream(),
  //       imageFile.lengthSync(),
  //       filename: 'image.jpg',
  //     ),
  //   );
  //
  //   final response = await request.send();
  //   if (response.statusCode == 200) {
  //     print('อัปโหลดภาพสำเร็จ');
  //   } else {
  //     print('เกิดข้อผิดพลาดในการอัปโหลดภาพ: ${response.reasonPhrase}');
  //   }
  // }

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
      child: Column(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 1220,
                color:Color(0xFF101010),
                child: Transform.translate(
                  offset: Offset(0.0, -100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:130.0,vertical:180 ),
                    child: AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: CameraPreview(controller!),
                    ),
                  ),

                ),

              ),
              Transform.translate(
                offset:Offset(0, -1100),
                  child: Text(
                      "Look at the camera",
                    style:TextStyle(
                      fontSize: 28.0,
                      color: Colors.white

                    ) ,
              ),
              )

              
            ],
          ),
     
          // Transform.translate(
          //   offset:  Offset(0.0, -600),
          //   child: Center(
          //     child: Image.file(
          //       File('/storage/emulated/0/Android/data/com.example.bookingapp/files/GetPic/image.jpg'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
