import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';  // Del Grupo 4

// Clase AppRoutes (del archivo /lib/routes/app_routes.dart que proporcionaste)
class AppRoutes {
  static const String home = 'home';
  static const String details = 'details';
  static const String settings = 'settings';
  // mas variables (puedes agregar más const aquí)

  // Método getRoutes adaptado para generar GoRoutes dinámicamente
  static List<GoRoute> getGoRoutes() {
    return [
      GoRoute(
        path: '/$home',  // Path basado en el name
        name: home,
        builder: (context, state) => const HomeScreen(),  // Instanciar el widget
      ),
      GoRoute(
        path: '/$details',
        name: details,
        builder: (context, state) => const DetailsScreen(),
      ),
      GoRoute(
        path: '/$settings',
        name: settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      // Agrega más GoRoutes aquí para "mas variables"
    ];
  }
}

// Definición de rutas nombradas (del aporte de noticias, renombrada para evitar conflicto)
class AppRoutesNoticias {
  static const String noticias = '/noticias';
}

// Importa las pantallas de los otros grupos (ajusta rutas reales).
import 'grupo1/grupo1_screen.dart';  // Placeholder para Grupo 1
import 'grupo2/grupo2_screen.dart';  // Placeholder para Grupo 2
import 'grupo4/settings_page.dart';  // Del Grupo 4
import 'grupo5/grupo5_screen.dart';
import 'grupo6/grupo6_screen.dart';
import 'grupo7/grupo7_screen.dart';
import 'grupo9/grupo9_screen.dart';  // Placeholder para Grupo 9
import 'grupo10/grupo10_screen.dart';

// Importación para Visor3D del Grupo 8
import 'package:f_2526_prt_s7_2/features/visor.dart';

// Importación para NoticiasScreen (del aporte anterior)
import 'features/noticias_screen.dart';  // Asumido path; cambia si es necesario

// Importación para TextRecognitionScreen (del aporte anterior)
import 'features/text_recognition/presentation/text_recognition_screen.dart';  // Ajusta si el archivo es diferente

// Nuevos imports para las pantallas de AppRoutes (del nuevo aporte)
import 'package:flutter_rutas/screens/home_screen.dart';
import 'package:flutter_rutas/screens/details_screen.dart';
import 'package:flutter_rutas/screens/settings_screen.dart';

// Nueva importación para DetectorScreen (del último aporte)
import 'features/detection/presentation/pages/detector_screen.dart' as detector;  // Con alias como indicas

// Importación del Grupo 4 para el proveedor de tema
import 'providers/theme_provider.dart';  // Ajusta la ruta si está en grupo4/providers/

// Pantalla principal del Grupo 3: El menú de navegación
class NavegacionCentralScreen extends StatelessWidget {
  const NavegacionCentralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navegación Central - Grupo 3'),
        backgroundColor: Colors.blue,  // Se adaptará al tema dinámico
      ),
      drawer: const MenuDrawer(),  // El menú lateral con enlaces
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dashboard, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Bienvenido al Núcleo del Proyecto',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Usa el menú lateral para navegar a otros grupos.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Drawer con botones/enlaces a las pantallas de otros grupos
class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú Principal - Grupo 3',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          // Botones para rutas básicas de AppRoutes
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => context.goNamed(AppRoutes.home),  // Navegación por nombre
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Details'),
            onTap: () => context.goNamed(AppRoutes.details),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings (Básico)'),
            onTap: () => context.goNamed(AppRoutes.settings),
          ),
          // Botón para Grupo 1
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Grupo 1'),
            onTap: () => context.go('/grupo1'),
          ),
          // Botón para Grupo 2
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Grupo 2'),
            onTap: () => context.go('/grupo2'),
          ),
          // Tu propio grupo (inicio)
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Grupo 3 - Navegación'),
            onTap: () => context.go('/'),
          ),
          // Botón para Grupo 4 (Ajustes)
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Grupo 4 - Ajustes'),
            onTap: () => context.go('/ajustes'),
          ),
          // Botones para los otros grupos...
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Grupo 5'),
            onTap: () => context.go('/grupo5'),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Grupo 6'),
            onTap: () => context.go('/grupo6'),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Grupo 7'),
            onTap: () => context.go('/grupo7'),
          ),
          // ListTile para Noticias
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('Noticias'),
            onTap: () => context.go(AppRoutesNoticias.noticias),
          ),
          // ListTile para Reconocimiento de Texto
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Reconocimiento de Texto'),
            onTap: () => context.go('/text_recognition'),
          ),
          // Nuevo ListTile para DetectorScreen
          ListTile(
            leading: const Icon(Icons.search),  // Ícono sugerido para detección
            title: const Text('Detector Screen'),
            onTap: () => context.go('/detectorScreen'),  // Navegación a la nueva ruta
          ),
          // ListTile para Grupo 8 (Visor 3D)
          ListTile(
            leading: Icon(Icons.threed_rotation),
            title: const Text("Visor 3D (Grupo 8)"),
            onTap: () {
              context.go('/visor3d');
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Grupo 9'),
            onTap: () => context.go('/grupo9'),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Grupo 10'),
            onTap: () => context.go('/grupo10'),
          ),
          // Opción para cerrar el drawer
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Cerrar'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// Configuración de GoRouter (appRouter)
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,  // Inicia en /home (de AppRoutes)
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NavegacionCentralScreen(),
    ),
    // Rutas dinámicas de AppRoutes (integradas via getGoRoutes())
    ...AppRoutes.getGoRoutes(),  // Agrega las nuevas rutas automáticamente
    // Rutas para los otros grupos (placeholders)
    GoRoute(
      path: '/grupo1',
      builder: (context, state) => const Grupo1Screen(),
    ),
    GoRoute(
      path: '/grupo2',
      builder: (context, state) => const Grupo2Screen(),
    ),
    // Ruta del Grupo 4
    GoRoute(
      path: '/ajustes',
      name: 'ajustes',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/grupo5',
      builder: (context, state) => const Grupo5Screen(),
    ),
    GoRoute(
      path: '/grupo6',
      builder: (context, state) => const Grupo6Screen(),
    ),
    GoRoute(
      path: '/grupo7',
      builder: (context, state) => const Grupo7Screen(),
    ),
    // Ruta para Noticias
    GoRoute(
      path: AppRoutesNoticias.noticias,
      name: 'noticias',
      builder: (context, state) => const NoticiasScreen(),
    ),
    // Ruta para TextRecognitionScreen
    GoRoute(
      path: '/text_recognition',
      name: 'text_recognition',
      builder: (context, state) => const TextRecognitionScreen(),
    ),
    // Nueva ruta para DetectorScreen
    GoRoute(
      path: '/detectorScreen',
      name: 'detectorScreen',
      builder: (context, state) => detector.DetectorScreen(),  // Usa el alias del import
    ),
    // Ruta del Grupo 8
    GoRoute(
      path: '/visor3d',
      name: 'visor3d',
      builder: (context, state) => const Visor3D(),
    ),
    GoRoute(
      path: '/grupo9',
      builder: (context, state) => const Grupo9Screen(),
    ),
    GoRoute(
      path: '/grupo10',
      builder: (context, state) => const Grupo10Screen(),
    ),
  ],
);

// Función main con Provider del Grupo 4
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Estructura con ChangeNotifierProvider y Consumer<ThemeProvider>
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            title: 'Proyecto Grupos - Navegación Central',
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}