import 'package:flutter/material.dart';
import 'native_calculator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Calculadora Nativa')),
        body: NativeCalculator(),
      ),
    );
  }
}