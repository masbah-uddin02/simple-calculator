// lib/screens/calculator_screen.dart

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  List<String> _history = [];

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_input);
          ContextModel cm = ContextModel();
          double result = exp.evaluate(EvaluationType.REAL, cm);
          String expressionHistory = '$_input = ${result.toString()}';
          _history.add(expressionHistory);
          _input = result.toString();
        } catch (e) {
          _input = 'Error';
        }
      } else if (buttonText == 'C') {
        _input = '';
      } else {
        _input += buttonText;
      }
    });
  }

  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Calculation History'),
          content: Column(
            children: _history.map((entry) => ListTile(title: Text(entry))).toList(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.grey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Calculation History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text('History'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _showHistoryDialog();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                _input,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton(text: '7', onPressed: () => _onButtonPressed('7')),
                CalculatorButton(text: '8', onPressed: () => _onButtonPressed('8')),
                CalculatorButton(text: '9', onPressed: () => _onButtonPressed('9')),
                CalculatorButton(text: '÷', onPressed: () => _onButtonPressed('÷')),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton(text: '4', onPressed: () => _onButtonPressed('4')),
                CalculatorButton(text: '5', onPressed: () => _onButtonPressed('5')),
                CalculatorButton(text: '6', onPressed: () => _onButtonPressed('6')),
                CalculatorButton(text: '×', onPressed: () => _onButtonPressed('×')),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton(text: '1', onPressed: () => _onButtonPressed('1')),
                CalculatorButton(text: '2', onPressed: () => _onButtonPressed('2')),
                CalculatorButton(text: '3', onPressed: () => _onButtonPressed('3')),
                CalculatorButton(text: '-', onPressed: () => _onButtonPressed('-')),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton(text: '0', onPressed: () => _onButtonPressed('0')),
                CalculatorButton(text: '.', onPressed: () => _onButtonPressed('.')),
                CalculatorButton(text: '=', onPressed: () => _onButtonPressed('=')),
                CalculatorButton(text: '+', onPressed: () => _onButtonPressed('+')),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton(text: 'C', onPressed: () => _onButtonPressed('C'), isClearButton: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
