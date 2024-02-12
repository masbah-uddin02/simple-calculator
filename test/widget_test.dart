import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _history = '';

  void _updateExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
    });
  }

  void _calculate() {
    Parser p = Parser();
    ContextModel cm = ContextModel();
    Expression exp = p.parse(_expression);
    double result = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _history = '$_expression = $result\n$_history';
      _expression = result.toString();
    });
  }

  void _clearHistory() {
    setState(() {
      _history = '';
    });
  }

  void _openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(history: _history),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('7', _updateExpression),
              CalculatorButton('8', _updateExpression),
              CalculatorButton('9', _updateExpression),
              CalculatorButton('/', _updateExpression),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('4', _updateExpression),
              CalculatorButton('5', _updateExpression),
              CalculatorButton('6', _updateExpression),
              CalculatorButton('*', _updateExpression),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('1', _updateExpression),
              CalculatorButton('2', _updateExpression),
              CalculatorButton('3', _updateExpression),
              CalculatorButton('-', _updateExpression),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('0', _updateExpression),
              CalculatorButton('.', _updateExpression),
              CalculatorButton('C', (_) => _clear()),
              CalculatorButton('+', _updateExpression),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('MR', (_) => _updateExpression(_history)),
              CalculatorButton('=', (_) => _calculate(), color: Colors.blue),
              CalculatorButton('MC', (_) => _clearHistory(), color: Colors.red),
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _openHistory,
            child: Text('View History'),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function(String) callback;
  final Color color;

  CalculatorButton(this.text, this.callback, {this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () => callback(text),
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.all(20.0),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  final String history;

  HistoryScreen({required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculation History'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            history,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
