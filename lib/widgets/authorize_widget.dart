import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // ต้อง import แพ็กเกจ camera
class AuthorizeWidget extends StatefulWidget {
  @override
  //add overide
  _AuthorizeWidgetState createState() => _AuthorizeWidgetState();//เพื่อ Create State
}

class _AuthorizeWidgetState extends State<AuthorizeWidget> {
  late CameraController controller;//declare Here

  @override
  //overide+function
  void initState() {
    super.initState();
    // Initialize the camera
    initCamera();
  }
  void initCamera() async {
    final cameras = await availableCameras();

    // Choose a camera (e.g., the first available camera)
    final camera = cameras.first;

    // Initialize the camera controller
    controller = CameraController(camera, ResolutionPreset.medium);

    // Ensure the controller is initialized
    await controller.initialize();
    //update screen
    if (mounted) {
      setState(() {});
    }
  }

  @override
  //มา override และ dispose ที่เป็น function พิเศษอีกทีก่อนเป็น Widget
  void dispose() {
    // Dispose of the camera controller when the widget is removed from the widget tree
    controller?.dispose();
    super.dispose();
  }
//override + Widget
  @override
  Widget build(BuildContext context) {
    //ใต้ widget จะเป็นเงื่อนไข ตอนนี้ข้องบนเป็น If เพราะมี return ข้างล่างเป็น else
    if (controller == null || !controller.value.isInitialized) {
      return CircularProgressIndicator(); // Display a loading indicator
    }
// return ค่าปรกติแล้วที่เคยทำ พวก Scaffold,Stack บลาๆ
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
        ElevatedButton(
          onPressed: () {
            // Take a picture or perform any camera-related action
          },
          child: Text('Take Picture'),
        ),
      ],
    );
  }
}
