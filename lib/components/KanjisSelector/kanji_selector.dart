import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_kanjis_app/utils/helper.dart';
import 'package:learn_kanjis_app/components/options/kanji_lecture.dart';

class KanjiSelector extends StatefulWidget {
  const KanjiSelector({
    super.key,
    required this.kanjis,
    this.onKanjiSelected,
  });  
  final List<Kanji> kanjis;
  final void Function(String selectedKanji)? onKanjiSelected;

  @override
  State<KanjiSelector> createState() => _KanjiSelectorState();
}

class _KanjiSelectorState extends State<KanjiSelector> {
  int _currentIndex = 0;
  late List<Kanji> _remainingKanjis;
  bool enabledButtons = true;
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  @override
  void initState() {
    super.initState();
    _remainingKanjis = List<Kanji>.from(widget.kanjis);
  }

  void _selectNextKanji() {
    if (_remainingKanjis.isNotEmpty) {
      final selectedKanji = _remainingKanjis.removeAt(0);
      widget.onKanjiSelected?.call(selectedKanji.kanji);
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_remainingKanjis.isEmpty) {
      return const Center(child: Text('¡Completado!'));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Progreso: $_currentIndex / ${widget.kanjis.length}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        const SizedBox(height: 24),
        Text(
          _remainingKanjis.first.kanji,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 90),
        ),
        const SizedBox(height: 24),
        KanjiLectureOptions(
          correctLecture: _remainingKanjis.first.lectura,
          kanjiLectures: widget.kanjis,
          enabled: enabledButtons,
          onSelected: (selected) {
            final isCorrect = selected == _remainingKanjis.first.lectura;
            final textToShow = isCorrect ? '¡Correcto! La respuesta es ${_remainingKanjis.first.lectura}. Significado: ${_remainingKanjis.first.significado}.' : 'Incorrecto, la respuesta correcta es ${_remainingKanjis.first.lectura}.';
            setState(() {
              enabledButtons = false;
              if (isCorrect) {
                correctAnswers++;
              } else {
                incorrectAnswers++;
              }
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(textToShow, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                duration: const Duration(seconds: 4),
                backgroundColor: isCorrect ? Colors.green : Colors.red
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 4),
            Text(': $correctAnswers'),
            const SizedBox(width: 16),
            const Icon(Icons.cancel, color: Colors.red),
            const SizedBox(width: 4),
            Text(': $incorrectAnswers'),
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: !enabledButtons
              ? () {
                  setState(() {
                    enabledButtons = true;
                  });
                  _selectNextKanji();
                }
              : null,
          child: const Text('Siguiente Kanji', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}