import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KanjiNumberInput extends StatefulWidget {
  final int maxKanjis;
  final ValueChanged<int> onChanged;

  const KanjiNumberInput({
    super.key,
    required this.maxKanjis,
    required this.onChanged,
  });

  @override
  State<KanjiNumberInput> createState() => _KanjiNumberInputState();
}

class _KanjiNumberInputState extends State<KanjiNumberInput> {
  late TextEditingController _controller;
  int _currentValue = 0;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    final intValue = int.tryParse(value) ?? 0;
    if (intValue > widget.maxKanjis) {
      _controller.text = widget.maxKanjis.toString();
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
      setState(() {
        _currentValue = widget.maxKanjis;
      });
      widget.onChanged(_currentValue);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Este nivel solo tiene ${widget.maxKanjis} kanjis disponibles.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      setState(() {
        _currentValue = intValue;
      });
      widget.onChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
  // maxLength eliminado, el control es por valor
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
        ),
        onChanged: _onChanged,
      ),
    );
  }
}