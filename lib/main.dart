import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:scanini/features/camerascanner/presentation/pages/camera_screen.dart';
import 'package:scanini/features/camerascanner/presentation/pages/my_home_page.dart';



void main() {
  runApp(ScaniniApp());
}


class ScaniniApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: availableCameras(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CameraDescription> cameras = snapshot.data!;
          return MaterialApp(
            home: MyHomePage(cameras),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}