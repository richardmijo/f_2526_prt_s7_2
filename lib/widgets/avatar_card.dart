import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  // Parámetros requeridos para el widget
  final String photoUrl;
  final String name;
  final String detail; // Típicamente la carrera o el rol

  const AvatarCard({
    super.key,
    required this.photoUrl,
    required this.name,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Estilo de la tarjeta
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            // Foto de Perfil
            CircleAvatar(
              radius: 60,
              // Usar una imagen de red (reemplazar con un asset si no tienen URL)
              backgroundImage: NetworkImage(photoUrl),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 20),
            // Nombre Completo
            Text(
              name,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor, // Color principal de la app
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            // Detalle/Carrera
            Text(
              detail,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}