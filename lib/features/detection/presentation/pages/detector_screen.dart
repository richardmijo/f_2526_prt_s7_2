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
        (c) => c.lensDirection == _cameraLensDirection,
        orElse: () => cameras.first,
      );
      _cameraLensDirection = camera.lensDirection;

      _cameraController = CameraController(
        camera,
        ResolutionPreset
            .low, // Changed to low to prevent freezing on low-end devices
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

  int _frameCounter = 0;
  void _processImage(CameraImage image) async {
    // Throttling: only process 1 out of every 10 frames to unblock UI
    _frameCounter++;
    if (_frameCounter % 10 != 0) return;

    if (_isDetecting || !_isInitialized || _faceDetector == null) return;
    _isDetecting = true;
    debugPrint("Processing frame $_frameCounter...");

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
      debugPrint("Faces detected: ${faces.length}");

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

                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black54,
                    child: Text(
                      'Rostros: ${_faces.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleCamera,
        child: const Icon(Icons.cameraswitch),
      ),
    );
  }

  Future<void> _toggleCamera() async {
    if (_cameraController == null) return;

    // 1. Stop processing to avoid errors
    _isDetecting = false;
    _faceDetector?.close(); // Reset detector to avoid conflicts
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: false,
        enableLandmarks: false,
      ),
    );

    // 2. Dispose current controller
    await _cameraController!.dispose();

    // 3. Update state to switch lens
    if (mounted) {
      setState(() {
        _isInitialized = false;
        _faces = [];
        _imageSize = null;
        _cameraLensDirection = _cameraLensDirection == CameraLensDirection.front
            ? CameraLensDirection.back
            : CameraLensDirection.front;
      });
    }

    // 4. Re-initialize
    _initializeCamera();
  }
}
