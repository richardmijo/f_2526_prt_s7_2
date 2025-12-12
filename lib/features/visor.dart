import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Visor3D extends StatelessWidget {
  const Visor3D({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visor 3D - Grupo 8"),
        centerTitle: true,
      ),
      body: const Center(
        child: ModelViewer(
          src: 'assets/models/68-laptop.glb', 
          alt: "Modelo 3D del Logo",
          ar: true,                   
          autoRotate: true,           
          cameraControls: true,       
          disablePan: false,
          exposure: 1,
        ),
      ),
    );
  }
}
