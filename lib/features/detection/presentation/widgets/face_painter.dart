import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FacePainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  FacePainter({
    required this.faces,
    required this.imageSize,
    required this.rotation,
    required this.cameraLensDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.greenAccent;

    for (final face in faces) {
      final rect = face.boundingBox;

      // Calculate scaling factors
      // ImageSize is the raw buffer size (e.g. 1280x720).
      // Size is the widget size (e.g. 400x800).
      // We need to respect the rotation.

      // If rotation is 90 or 270, the image width is actually fitting the height of the widget or vice versa depending on orientation.
      // But typically we swap the imageSize dimensions before passing to painter if we want "logical" scaling?
      // No, let's process raw.

      // Actually, standard approach:
      // Translate X and Y

      double scaleX = size.width / imageSize.width;
      double scaleY = size.height / imageSize.height;

      // Because the camera feed is usually fitted 'cover' or 'fitWidth', assumptions must be made.
      // But here we assume the CustomPaint is overlayed exactly on CameraPreview which uses specific aspect ratio.

      // Let's implement simple scaling logic.
      double left = rect.left * scaleX;
      double top = rect.top * scaleY;
      double right = rect.right * scaleX;
      double bottom = rect.bottom * scaleY;

      if (cameraLensDirection == CameraLensDirection.front) {
        // Mirror horizontally
        left = size.width - right;
        right = size.width - (rect.left * scaleX);
      }

      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return oldDelegate.faces != faces ||
        oldDelegate.imageSize != imageSize ||
        oldDelegate.rotation != rotation;
  }
}
