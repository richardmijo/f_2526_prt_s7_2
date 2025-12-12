import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String? error;

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();

    final correctUser = dotenv.env['USERNAME'] ?? 'admin';
    final correctPass = dotenv.env['PASSWORD'] ?? '1234';

    if (userCtrl.text == correctUser && passCtrl.text == correctPass) {
      await prefs.setBool("isLoggedIn", true);
      context.go('/home');
    } else {
      setState(() => error = "Credenciales incorrectas");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login", style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: 20),

            TextField(
              controller: userCtrl,
              decoration: const InputDecoration(
                labelText: "Usuario",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: login,
              child: const Text("Ingresar"),
            ),
          ],
        ),
      ),
    );
  }
}
