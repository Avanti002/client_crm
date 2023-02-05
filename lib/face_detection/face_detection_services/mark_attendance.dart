import 'dart:async';
import 'package:quantbit_crm/face_detection/locator.dart';
import 'package:quantbit_crm/face_detection/user_model.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/auth_button.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/camera_detection_preview.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/camera_header.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/mattendance_form.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/single_picture.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/camera_service.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/ml_service.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/face_detector_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({Key? key}) : super(key: key);

  @override
  MarkAttendanceState createState() => MarkAttendanceState();
}

class MarkAttendanceState extends State<MarkAttendance> {
  CameraService _cameraService = locator<CameraService>();
  FaceDetectorService _faceDetectorService = locator<FaceDetectorService>();
  MLService _mlService = locator<MLService>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isPictureTaken = false;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _mlService.dispose();
    _faceDetectorService.dispose();
    super.dispose();
  }

  Future _start() async {
    setState(() => _isInitializing = true);
    await _cameraService.initialize();
    setState(() => _isInitializing = false);
    _frameFaces();
  }

  _frameFaces() async {
    bool processing = false;
    _cameraService.cameraController!
        .startImageStream((CameraImage image) async {
      if (processing) return; // prevents unnecessary overprocessing.
      processing = true;
      await _predictFacesFromImage(image: image);
      processing = false;
    });
  }

  Future<void> _predictFacesFromImage({@required CameraImage? image}) async {
    assert(image != null, 'Image is null');
    await _faceDetectorService.detectFacesFromImage(image!);
    if (_faceDetectorService.faceDetected) {
      _mlService.setCurrentPrediction(image, _faceDetectorService.faces[0]);
    }
    if (mounted) setState(() {});
  }

  Future<void> takePicture() async {
    if (_faceDetectorService.faceDetected) {
      await _cameraService.takePicture();
      setState(() => _isPictureTaken = true);
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(content: Text('No face detected!')));
    }
  }

  _onBackPressed() {
    Navigator.of(context).pop();
  }

  _reload() {
    if (mounted) setState(() => _isPictureTaken = false);
    _start();
  }

  Future<void> onTap() async {
    await takePicture();
    if (_faceDetectorService.faceDetected) {
      User? user = await _mlService.predict();
      var bottomSheetController = scaffoldKey.currentState!
          .showBottomSheet((context) => markAttendanceSheet(user: user!));
      bottomSheetController.closed.whenComplete(_reload);
    }
  }

  Widget getBodyWidget() {
    if (_isInitializing) return Center(child: CircularProgressIndicator());
    if (_isPictureTaken)
      return SinglePicture(imagePath: _cameraService.imagePath!);
    return CameraDetectionPreview();
  }

  @override
  Widget build(BuildContext context) {
    Widget header = CameraHeader("Mark Attendance", onBackPressed: _onBackPressed);
    Widget body = getBodyWidget();
    Widget? fab;
    if (!_isPictureTaken) fab = AuthButton(onTap: onTap);

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [body, header],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: fab,
    );
  }

  markAttendanceSheet({@required User? user}) => user == null
      ? Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Text(
            'User not Registered ! 😞',
            style: TextStyle(fontSize: 20),
          ),
        )
      : MarkAttendanceSheet(user: user);
}
