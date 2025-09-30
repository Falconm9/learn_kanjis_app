import 'package:flutter/material.dart';
import 'package:learn_kanjis_app/components/inputs/kanji_input_number.dart';
import 'package:learn_kanjis_app/components/RamdomGenerator/kanjis_generator.dart';

class KanjisPage extends StatefulWidget {
  const KanjisPage({super.key});

  @override
  State<KanjisPage> createState() => _KanjisPageState();
}

class _KanjisPageState extends State<KanjisPage> {
  final List<Map<String, String>> kanjiLevels = [
    /*{'level': 'N1', 'totalKanjis': '5000'},
    {'level': 'N2', 'totalKanjis': '3000'},
    {'level': 'N3', 'totalKanjis': '2000'},
    {'level': 'N4', 'totalKanjis': '1500'},*/
    {'level': 'N5', 'totalKanjis': '620'},
  ];

  String selectedLevel = '';
  int totalKanjis = 0;
  String _order = 'random';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿Qué nivel quieres que probemos?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: kanjiLevels.map((level) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child:
                     ChoiceChip(
                      label: Text(level['level']!),
                      selected: selectedLevel == '${level['level']}',
                      onSelected: (selected) {
                      setState(() {
                          selectedLevel = level['level']!;
                          totalKanjis = 0; // Reinicia el número de kanjis al cambiar de nivel
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),
            if (selectedLevel != '') ...[
              Text(
                '¿Cuantos Kanjis quieres aprender?',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 24),
              KanjiNumberInput(
                maxKanjis: int.parse(
                  kanjiLevels.firstWhere((level) => level['level'] == selectedLevel)['totalKanjis']!,
                ),
                onChanged: (value) {
                  setState(() {
                  totalKanjis = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: Text('En orden'),
                    selected: _order == 'ordered',
                    onSelected: (selected) {
                      setState(() {
                        _order = 'ordered';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text('Aleatorio'),
                    selected: _order == 'random',
                    onSelected: (selected) {
                      setState(() {
                        _order = 'random';
                      });
                    },
                  ),
                ],
              )
            ],
            const SizedBox(height: 32),
            if (selectedLevel != '' && totalKanjis > 0) ...[
              Text(
                'Estas a punto de comenzar a aprender $totalKanjis kanjis del nivel $selectedLevel',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KanjisGeneratorPage(kanjiLevel: selectedLevel, totalKanjis: totalKanjis, order: _order),
                    ),
                  );
                  // Navegar a la página de generación de kanjis  
                },
                child: const Text('Comenzar', style: TextStyle(fontSize: 32)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}