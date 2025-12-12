import 'package:flutter/material.dart';
import '../data/noticia_data.dart';
import '../widgets/noticia_card.dart';

class NoticiasScreen extends StatelessWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Noticias UIDE',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF8B004F),
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: noticiasData.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final noticia = noticiasData[index];
          return NoticiaCard(noticia: noticia);
        },
      ),
    );
  }
}
