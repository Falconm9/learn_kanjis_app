import 'package:flutter/material.dart';
import 'package:learn_kanjis_app/pages/kanjis.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({super.key});

  @override
  State<TabNavigation> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _selectedIndex = 0;

  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return KanjisPage();
      // Puedes agregar más casos para otras páginas
      default:
        return const Center(child: Text('Selecciona una opción del menú'));
    }
  }

  
  Color getNavigationBarColor(BuildContext context) {
    final Color defaultColor = Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
      Theme.of(context).canvasColor; // fallback

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color darkenColor(Color color, {required bool isDark}) {
    final int alpha = isDark ? 80 : 20; // Ajusta la opacidad según el tema oscuro o claro  
    return Color.alphaBlend(Colors.black.withAlpha(alpha), color);
    }
    return darkenColor(defaultColor, isDark: isDark);
  }

  @override
  Widget build(BuildContext context) {
    final Color colorWithOpacity = getNavigationBarColor(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('USHIO Kanjis'),
        backgroundColor: colorWithOpacity,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Menú',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Kanjis'),
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            /*ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Kanjis'),
              selected: _selectedIndex == 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
                // Navegar a la pantalla de configuración
              },
            ),*/
          ],
        ),
      ),
      body: _getBody(),
    );
  }
}