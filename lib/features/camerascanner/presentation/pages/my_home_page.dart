import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:scanini/features/camerascanner/presentation/pages/camera_screen.dart' as camera_screen;
import 'package:scanini/main.dart';

class MyHomePage extends StatelessWidget {
  final List<CameraDescription> cameras;

  MyHomePage(this.cameras);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Scanner App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Card Scanner App!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the image capture screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => camera_screen.Camerascreen()));
              },
              child: Text('Scan a card'),
            ),
          ],
        ),
      ),
    );
  }
}