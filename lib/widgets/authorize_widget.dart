import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;


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
  }
  void captureAndSaveImage() async {
    if (controller != null && controller!.value.isInitialized) {
      // Wait for 2 seconds
      await Future.delayed(Duration(seconds: 2));

      try {
        final path = '/storage/emulated/0/Android/data/com.example.bookingapp/files/GetPic';
        final directory = Directory(path);
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }

        // Ensure that the camera is ready to take a picture
        if (controller!.value.isTakingPicture) {
          print("Camera is already taking a picture.");
        } else {
          final image = await controller!.takePicture();
          final imageBytes = await image.readAsBytes();
          final savedFile = File('$path/image.jpg');
          await savedFile.writeAsBytes(imageBytes);
          print("Image saved successfully.");
          final imageFile = File('/storage/emulated/0/Android/data/com.example.bookingapp/files/GetPic/image.jpg');
          if (imageFile.existsSync()) {
            // มีภาพอยู่
            print('มีภาพอยู่ในพาธ GetPic');
          } else {
            // ไม่มีภาพ
            print('ไม่มีภาพในพาธ GetPic');
          }

        }
      } catch (e) {
        print("Error capturing and saving image: $e");
      }
    }
  }
//after facenet
  Future<void> uploadImage(File imageFile) async {
    final url = Uri.parse('YOUR_BACKEND_UPLOAD_URL'); // เปลี่ยน YOUR_BACKEND_UPLOAD_URL เป็น URL ของ backend ของคุณ
    final request = http.MultipartRequest('POST', url);
    request.files.add(
      http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'image.jpg',
      ),
    );

    final response = await request.send();
    if (response.statusCode == 200) {
      print('อัปโหลดภาพสำเร็จ');
    } else {
      print('เกิดข้อผิดพลาดในการอัปโหลดภาพ: ${response.reasonPhrase}');
    }
  }

//////////




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

    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: CameraPreview(controller!),
        ),
        ElevatedButton(
          onPressed: () {
            captureAndSaveImage();
          },
          child: Text("ถ่ายภาพ"),
        ),
        Center(
          child: Image.file(
            File('/storage/emulated/0/Android/data/com.example.bookingapp/files/GetPic/image.jpg'),
          ),
        ),


      ],
    );
  }
}