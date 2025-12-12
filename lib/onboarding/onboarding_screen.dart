import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart'; // para poder navegar a MyHomePage

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _paginaActual = 0;

  final List<Map<String, String>> _paginas = const [
    {
      'titulo': 'Bienvenido',
      'descripcion': 'Esta app te ayudará a entender cómo funciona Flutter.',
    },
    {
      'titulo': 'Contador',
      'descripcion':
          'En la pantalla principal podrás incrementar un contador y ver cambios en tiempo real.',
    },
    {
      'titulo': '¡Listo!',
      'descripcion':
          'Pulsa el botón para comenzar a usar la app por primera vez.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _marcarOnboardingComoVisto() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_visto', true);

    if (!mounted) return;

    // Reemplazamos la pantalla actual por el Home
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }

  void _siguientePagina() {
    if (_paginaActual < _paginas.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _marcarOnboardingComoVisto();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool esUltima = _paginaActual == _paginas.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _paginas.length,
                onPageChanged: (index) {
                  setState(() {
                    _paginaActual = index;
                  });
                },
                itemBuilder: (context, index) {
                  final pagina = _paginas[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          index == 0
                              ? Icons.app_registration
                              : index == 1
                              ? Icons.plus_one
                              : Icons.check_circle_outline,
                          size: 120,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          pagina['titulo']!,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pagina['descripcion']!,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Indicadores (los puntitos)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _paginas.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: _paginaActual == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _paginaActual == index
                        ? Colors.deepPurple
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _siguientePagina,
                  child: Text(esUltima ? 'Comenzar' : 'Siguiente'),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
