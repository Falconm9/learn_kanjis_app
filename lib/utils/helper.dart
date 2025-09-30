import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Define la clase Kanji según la estructura de tus objetos en el JSON
class Kanji {
  final String kanji;
  final String lectura;
  final String significado;

  Kanji({
    required this.kanji,
    required this.lectura,
    required this.significado,
  });

  factory Kanji.fromJson(Map<String, dynamic> json) {
    return Kanji(
      kanji: json['kanji'] as String,
      lectura: json['lectura'] as String,
      significado: json['significado'] as String,
    );
  }
}

// Función para cargar y procesar el archivo kanjis_N5.json
Future<List<Kanji>> loadKanjis(String level) async {
  final String jsonString = await rootBundle.loadString('lib/utils/kanjis_$level.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => Kanji.fromJson(json)).toList();
}