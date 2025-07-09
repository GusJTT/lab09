// lib/native_calculator.dart (recomendado)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCalculator extends StatefulWidget {
  @override
  _NativeCalculatorState createState() => _NativeCalculatorState();
}

class _NativeCalculatorState extends State<NativeCalculator> {
  static const platform = MethodChannel('com.ejemplo/calculadora');

  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  String resultado = '';

  Future<void> _calcular(String operacion) async {
    final String num1Text = num1Controller.text;
    final String num2Text = num2Controller.text;

    // Validar que ambos campos tengan números
    if (num1Text.isEmpty || num2Text.isEmpty) {
      setState(() {
        resultado = 'Por favor, ingresa ambos números.';
      });
      return;
    }

    int? a = int.tryParse(num1Text);
    int? b = int.tryParse(num2Text);

    if (a == null || b == null) {
      setState(() {
        resultado = 'Los valores deben ser números enteros.';
      });
      return;
    }

    try {
      final result = await platform.invokeMethod(operacion, {'a': a, 'b': b});
      setState(() {
        resultado = 'Resultado: $result';
      });
    } on PlatformException catch (e) {
      setState(() {
        resultado = 'Error: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Número 1'),
            ),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Número 2'),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => _calcular('sumar'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('restar'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('multiplicar'),
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('dividir'),
                  child: const Text('/'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(resultado, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}