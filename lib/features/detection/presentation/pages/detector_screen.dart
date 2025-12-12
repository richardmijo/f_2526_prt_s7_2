import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../widgets/face_painter.dart';
import '../utils/camera_utils.dart';
// Note: We are using the FaceEntity from domain just as a data holder for now,
// or better yet, let's just use the ML Kit Face object directly to be even simpler
// and avoid importing the domain layer which we want to delete.
// But FacePainter expects FaceEntity.
// Let's refactor FacePainter too or just map it here to a simple local class or use Face directly.
// To satisfy "simple", I will change FacePainter to accept ML Kit Face.

class DetectorScreen extends StatefulWidget {
  const DetectorScreen({super.key});

  @override
  State<DetectorScreen> createState() => _DetectorScreenState();
}

class _DetectorScreenState extends State<DetectorScreen> {
  CameraController? _cameraController;
  FaceDetector? _faceDetector;

  bool _isDetecting = false;
  List<Face> _faces = []; // Using ML Kit Face directly
  Size? _imageSize;
  InputImageRotation _rotation = InputImageRotation.rotation0deg;
  CameraLensDirection _cameraLensDirection = CameraLensDirection.front;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: false,
        enableLandmarks: false,
      ),
    );
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      _cameraLensDirection = camera.lensDirection;

      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() {
        _isInitialized = true;
      });

      _cameraController!.startImageStream(_processImage);
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  void _processImage(CameraImage image) async {
    if (_isDetecting || !_isInitialized || _faceDetector == null) return;
    _isDetecting = true;

    try {
      final inputImage = CameraUtils.convertCameraImageToInputImage(
        image,
        _cameraController!.description,
      );
      if (inputImage == null) {
        _isDetecting = false;
        return;
      }

      // Update image size and rotation for the painter
      final size = inputImage.metadata?.size;
      final rotation =
          inputImage.metadata?.rotation ?? InputImageRotation.rotation0deg;

      Size? processedSize = size;
      if (rotation == InputImageRotation.rotation90deg ||
          rotation == InputImageRotation.rotation270deg) {
        if (size != null) {
          processedSize = Size(size.height, size.width);
        }
      }

      final faces = await _faceDetector!.processImage(inputImage);

      if (mounted) {
        setState(() {
          _faces = faces;
          _imageSize = processedSize;
          _rotation = rotation;
        });
      }
    } catch (e) {
      debugPrint("Error detecting faces: $e");
    } finally {
      _isDetecting = false;
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detector de Rostros (Grupo 6)')),
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(_cameraController!),
                if (_imageSize != null)
                  CustomPaint(
                    painter: FacePainter(
                      faces: _faces,
                      imageSize: _imageSize!,
                      rotation: _rotation,
                      cameraLensDirection: _cameraLensDirection,
                    ),
                  ),
              ],
            ),
    );
  }
}
