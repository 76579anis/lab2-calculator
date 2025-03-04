import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double _num1 = 0;
  double _num2 = 0;
  String? _operator;
  bool _isNewInput = false;

  @override
  void initState() {
    super.initState();
    _loadLastValue();
  }

  Future<void> _loadLastValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _display = prefs.getString('lastValue') ?? '0';
    });
  }

  Future<void> _saveLastValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastValue', _display);
  }

  void _onDigitPress(String digit) {
    setState(() {
      if (_isNewInput || _display == '0') {
        _display = digit;
        _isNewInput = false;
      } else if (_display.length < 8) {
        _display += digit;
      }
    });
  }

  void _onOperatorPress(String operator) {
    setState(() {
      _num1 = double.tryParse(_display) ?? 0;
      _operator = operator;
      _isNewInput = true;
    });
  }

  void _calculateResult() {
    setState(() {
      _num2 = double.tryParse(_display) ?? 0;
      double result = 0;

      if (_operator != null) {
        switch (_operator) {
          case '+':
            result = _num1 + _num2;
            break;
          case '-':
            result = _num1 - _num2;
            break;
          case '*':
            result = _num1 * _num2;
            break;
          case '/':
            if (_num2 != 0) {
              result = _num1 / _num2;
            } else {
              _display = 'ERROR';
              return;
            }
            break;
        }

        if (result.abs() > 99999999) {
          _display = 'OVERFLOW';
        } else {
          _display = result.toStringAsFixed(2);
        }

        _saveLastValue();
      }
    });
  }

  void _clearDisplay() {
    setState(() {
      _display = '0';
      _num1 = 0;
      _num2 = 0;
      _operator = null;
      _isNewInput = false;
    });
  }

  Widget _buildButton(String text, {Color? color, Function()? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.grey[800],
          padding: const EdgeInsets.all(20),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7', onPressed: () => _onDigitPress('7')),
              _buildButton('8', onPressed: () => _onDigitPress('8')),
              _buildButton('9', onPressed: () => _onDigitPress('9')),
              _buildButton('/', color: Colors.orange, onPressed: () => _onOperatorPress('/')),
            ],
          ),
          Row(
            children: [
              _buildButton('4', onPressed: () => _onDigitPress('4')),
              _buildButton('5', onPressed: () => _onDigitPress('5')),
              _buildButton('6', onPressed: () => _onDigitPress('6')),
              _buildButton('*', color: Colors.orange, onPressed: () => _onOperatorPress('*')),
            ],
          ),
          Row(
            children: [
              _buildButton('1', onPressed: () => _onDigitPress('1')),
              _buildButton('2', onPressed: () => _onDigitPress('2')),
              _buildButton('3', onPressed: () => _onDigitPress('3')),
              _buildButton('-', color: Colors.orange, onPressed: () => _onOperatorPress('-')),
            ],
          ),
          Row(
            children: [
              _buildButton('0', onPressed: () => _onDigitPress('0')),
              _buildButton('C', color: Colors.red, onPressed: _clearDisplay),
              _buildButton('=', color: Colors.green, onPressed: _calculateResult),
              _buildButton('+', color: Colors.orange, onPressed: () => _onOperatorPress('+')),
            ],
          ),
        ],
      ),
    );
  }
}

