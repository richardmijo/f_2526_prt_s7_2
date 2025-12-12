import 'package:flutter/widgets.dart';
import 'package:flutter_rutas/screens/details_screen.dart';
import 'package:flutter_rutas/screens/home_screen.dart';
import 'package:flutter_rutas/screens/settings_screen.dart';

class AppRoutes {
  static const String home = 'home';
  static const String details = 'details';
  static const String settings = 'settings';
  // mas variables

  static Map<String, WidgetBuilder> getRoutes(){
    return {
      home: (context)=> HomeScreen(),
      details: (context)=> DetailsScreen(),
      settings: (context)=> SettingsScreen(),
      // instanciar el widget
    };
  }
}