// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _displayText = '';
  double _result = 0;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _result = _calculateResult();
        _displayText = _result.toString();
      } else if (buttonText == 'C') {
        _displayText = '';
        _result = 0;
      } else if (buttonText == 'x') {
        _displayText += '*'; // Replace 'x' with '*'
      } else {
        _displayText += buttonText;
      }
    });
  }

  double _calculateResult() {
    try {
      return eval(_displayText);
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      backgroundColor: Colors.black, // Set the background color to black
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _displayText,
                style: const TextStyle(fontSize: 32.0, color: Colors.white),
              ),
            ),
          ),
          const Divider(color: Colors.white),
          Column(
            children: <Widget>[
              _buildRow(['7', '8', '9', '/']),
              _buildRow(['4', '5', '6', 'x']),
              _buildRow(['1', '2', '3', '-']),
              _buildRow(['0', '.', '=', '+']),
              _buildRow(['C']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((buttonText) {
        return ElevatedButton(
          onPressed: () => _onButtonPressed(buttonText),
          child: Text(buttonText, style: const TextStyle(fontSize: 24.0)),
        );
      }).toList(),
    );
  }

  // Helper method to evaluate math expressions
  double eval(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }
}
