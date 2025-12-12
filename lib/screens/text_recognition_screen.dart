import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({super.key});

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  File? _image;

  String _recognizedText = '';
  
  bool _isBusy = false;
  
  final ImagePicker _picker  = ImagePicker();

  final TextRecognizer _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin
  );

  // Para salir del escaner
  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reconocimiento de texto'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber
                ),
                child: _image != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_image!, fit: BoxFit.cover),
                ): Center(
                  child: Icon(Icons.image, size: 80, color: Colors.blue),
                )
              ),

              SizedBox(height: 20,),

              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    label: Text('Cámara'),
                    icon: Icon(Icons.camera_alt),
                  ),

                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery), 
                    label: Text('Galería'),
                    icon: Icon(Icons.photo_library),
                  )
                ],
              ),

              SizedBox(height: 30,),

              Text('Texto reconocido:'),

              SizedBox(height: 10,),

              _isBusy 
                ? Center(child: CircularProgressIndicator(),)
                : Container(
                  child: Text(
                    _recognizedText.isEmpty
                      ? 'Aquí aparacerá el texto detectado.'
                      : _recognizedText,
                      style: TextStyle(fontSize: 16),
                  ),
                )

            ],
          ),
        ),
      ),
    );

  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _recognizedText = '';
        });

        _processImage(_image!);
      }
    } catch (e) {
      print("Error al seleccionar imagen: $e");
    }
  }

  Future<void> _processImage(File image) async {
    setState(() {
      _isBusy = true;
    });

    try {
      final inputImage = InputImage.fromFile(image);

      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);

      setState(() {
        _recognizedText = recognizedText.text;
      });
    } catch (e) {
      print("Error al procesar el texto: $e");
      _recognizedText = "Ocurrió un error al reconocer el texto.";
    } finally {
      setState(() {
        _isBusy = false;
      });
    }
  }
}