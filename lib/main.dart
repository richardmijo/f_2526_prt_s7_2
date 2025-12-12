import 'package:f_2526_prt_s7_2/features/text_recognition/presentation/text_recognition_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return TextRecognitionScreen();
  }
}
