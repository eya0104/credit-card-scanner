import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

class Camerascreen extends StatefulWidget {
  @override
  _CamerascreenState createState() => _CamerascreenState();
}

class _CamerascreenState extends State<Camerascreen> {
  late CameraController  _controller;
  Future<void>? _initializeControllerFuture;
  String _extractText = '';
  bool _scanning = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back);
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

   _scanCard() async {
    setState(() {
      _scanning = true;
    });
    try {

        final imagePicker = ImagePicker();
        final pickedImage = await imagePicker.pickImage(source: ImageSource.camera); // or ImageSource.camera
        if (pickedImage != null) {
          await FlutterTesseractOcr.extractText(pickedImage.path);
          setState(() {
           // print(extractedText);

           // _extractText = extractedText ;
            _scanning = false;
          });
        }



    } catch (e) {
      setState(() {
        _extractText = 'An error occurred: $e' ;
        _scanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Card Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: FutureBuilder(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            Text('${_extractText} characters extracted'),

            ElevatedButton(
              onPressed: _scanCard,
              child: Text('Scan Card'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}