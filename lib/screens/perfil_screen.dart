import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/avatar_card.dart'; 

// ASUMIMOS la ruta de Login de G1
// import 'login_screen.dart'; //

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  // Datos Ficticios
  final String studentFirstName = "Carlos Eduardo";
  final String studentLastName = "Pérez González";
  final String studentCareer = "Ingeniería de Software";
  final String studentSemester = "Séptimo"; // Solo el número/nombre del semestre
  final String studentEnrollment = "2022-II"; // Periodo de ingreso
  final String studentId = "A00213456"; 
  final String studentEmail = "carlos.perez@campus.edu";
  
  // URL de imagen de prueba
  final String photoUrl = "https://i.pravatar.cc/150?img=60"; 

  @override
  Widget build(BuildContext context) {
    // Definimos el color principal de la universidad para darle consistencia
    final Color universityColor = Theme.of(context).primaryColor; 
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil del Estudiante"),
        elevation: 0, // Para un look más moderno
        backgroundColor: universityColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 1. Cabecera con AvatarCard y Datos Clave
            _buildHeaderSection(context, universityColor),
            
            const SizedBox(height: 20),

            // 2. Sección de Datos Académicos Detallados
            _buildAcademicDetails(context, universityColor),

            const SizedBox(height: 20),

            // 3. Opciones de Cuenta (Logout)
            _buildAccountOptions(context),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES PARA EL DISEÑO CHEVERE ---

  // 1. Sección de Cabecera (Avatar + Nombre + Carrera)
  Widget _buildHeaderSection(BuildContext context, Color color) {
    return Column(
      children: [
        // Uso del Widget Personalizado
        AvatarCard(
          photoUrl: photoUrl,
          name: "$studentFirstName $studentLastName",
          detail: studentCareer,
        ),
        
        // Datos extra debajo del AvatarCard
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSmallInfoCard(context, Icons.calendar_month, "Ingreso", studentEnrollment),
              _buildSmallInfoCard(context, Icons.class_, "Semestre", studentSemester),
            ],
          ),
        ),
      ],
    );
  }

  // 2. Sección de Detalles Académicos (Datos de Matrícula y Contacto)
  Widget _buildAcademicDetails(BuildContext context, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Información de Contacto y Matrícula",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: color
                ),
              ),
              const Divider(height: 20),
              
              _buildDetailRow(Icons.email, "Correo Institucional", studentEmail),
              _buildDetailRow(Icons.badge, "Cód. Matrícula", studentId),
              _buildDetailRow(Icons.person_pin, "Nombre(s)", studentFirstName),
              _buildDetailRow(Icons.person_pin, "Apellido(s)", studentLastName),

            ],
          ),
        ),
      ),
    );
  }

  // 3. Sección de Opciones y Logout
  Widget _buildAccountOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _buildOptionTile(context, Icons.settings, "Configuración de App", () {}),
            _buildOptionTile(context, Icons.lock, "Cambiar Contraseña", () {}),
            _buildOptionTile(context, Icons.logout, "Cerrar Sesión", () async {
              // **Lógica de Colaboración con Grupo 1**
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false); // Elimina el estado de sesión

              // Navega y limpia la pila de rutas para volver al Login de G1
              Navigator.of(context).pushAndRemoveUntil(
                // Usar la pantalla de Login del Grupo 1
                MaterialPageRoute(builder: (context) => const LoginScreen()), 
                (Route<dynamic> route) => false,
              );
            }, isDestructive: true),
          ],
        ),
      ),
    );
  }

  // Widget para las filas detalladas (usado en la sección académica)
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 10),
          SizedBox(
            width: 120, // Ancho fijo para la etiqueta
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para las tarjetas de información pequeña (usado bajo el AvatarCard)
  Widget _buildSmallInfoCard(BuildContext context, IconData icon, String label, String value) {
    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.1), // Un color suave institucional
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width * 0.35, // 35% del ancho de pantalla
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget para las opciones (usado en la sección de Logout)
  Widget _buildOptionTile(BuildContext context, IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Theme.of(context).primaryColor),
      title: Text(
        title,
        style: TextStyle(color: isDestructive ? Colors.red : Colors.black, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}