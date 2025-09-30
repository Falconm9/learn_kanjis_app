import 'package:flutter/material.dart';
import 'package:learn_kanjis_app/utils/helper.dart';
import 'package:learn_kanjis_app/components/KanjisSelector/kanji_selector.dart';

class KanjisGeneratorPage extends StatelessWidget {
  const KanjisGeneratorPage({super.key,  required this.kanjiLevel, required this.totalKanjis, required this.order});
  final String kanjiLevel;
  final int totalKanjis;
  final String order;

  Future<List<Kanji>> _getKanjis() async {
    final kanjis = await loadKanjis(kanjiLevel);
    return kanjis;
  }


  List<Kanji> getSelectedKanjis(List<Kanji> allLevelKanjis) {
    final newKanjiListToReturn = List<Kanji>.from(allLevelKanjis);
    if (order == 'random') {
      newKanjiListToReturn.shuffle();
      return newKanjiListToReturn.take(totalKanjis).toList();
    } else {
      return newKanjiListToReturn.take(totalKanjis).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kanjis Nivel: $kanjiLevel'),
      ),
      body: Center(
        child: FutureBuilder<List<Kanji>>(
          future: _getKanjis(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child:  Column(
                  children: [
                    Text('Error al cargar los kanjis: ${snapshot.error}'),
                    SizedBox(height: 16),
                    Icon(Icons.sentiment_dissatisfied, size: 48),
                  ],
                )
              );
            } else {
              return KanjiSelector(
                kanjis: getSelectedKanjis(snapshot.data!),
              );
            }
          },
        ),
      ),
    );
  }
}