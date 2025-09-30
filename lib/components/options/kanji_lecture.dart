import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn_kanjis_app/utils/helper.dart';

class KanjiLectureOptions extends StatelessWidget {
  final String correctLecture;
  final List<Kanji> kanjiLectures;
  final void Function(String selected) onSelected;
  final bool enabled;

  const KanjiLectureOptions({
    super.key,
    required this.correctLecture,
    required this.kanjiLectures,
    required this.onSelected,
    required this.enabled
  });

  List<String> _generateOptions() {
    // Remove the correct lecture from the list to avoid duplicates
    final otherLectures = List<String>.from(kanjiLectures.map((kanji) => kanji.lectura))
      ..remove(correctLecture);

    // Shuffle and pick two random lectures
    otherLectures.shuffle(Random());
    final options = [correctLecture];
    options.addAll(otherLectures.take(2));

    // Shuffle the final options so the correct answer isn't always first
    options.shuffle(Random());
    return options;
  }

  @override
  Widget build(BuildContext context) {
    final options = _generateOptions();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: options.map((lecture) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: enabled ? () => onSelected(lecture) : null,
            child: Text(enabled ? lecture : correctLecture, style: const TextStyle(fontSize: 18)),
          ),
        ),
      );
      }).toList(),
    );
  }
}