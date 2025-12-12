import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appName = dotenv.env['APP_NAME'] ?? "Aplicación";
    final version = dotenv.env['APP_VERSION'] ?? "1.0.0";
    final author = dotenv.env['APP_AUTHOR'] ?? "Desconocido";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Aplicación: $appName", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("Versión: $version", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("Autor: $author", style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
