import 'package:flutter/material.dart';
import 'package:learn_kanjis_app/widgets/tab_navigation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),  // Tema claro
      darkTheme: ThemeData.dark(),  // Tema oscuro
      themeMode: ThemeMode.dark,  // Usa el modo del sistema (Android/iOS)
      home: const TabNavigation(),
    );
  }
}
