import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
            // Take a picture or perform any camera-related action
          },
          child: Text('Take Picture'),
        ),
      ],
    );
  }
}
