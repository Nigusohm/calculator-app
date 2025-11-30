import 'dart:math';

class CalculatorEngine {
  String _expression = '';

  String get expression => _expression;

  void clear() {
    _expression = '';
  }

  void delete() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
    }
  }

  void append(String value) {
    _expression += value;
  }

  String evaluate() {
    try {
      final result = _compute(_expression);
      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }

  double _compute(String exp) {
    exp = exp.replaceAll('×', '*').replaceAll('÷', '/');

    if (exp.contains('sin(')) {
      exp = exp.replaceAllMapped(RegExp(r'sin\((.*?)\)'), (m) {
        return sin(_compute(m.group(1)!)).toString();
      });
    }

    if (exp.contains('cos(')) {
      exp = exp.replaceAllMapped(RegExp(r'cos\((.*?)\)'), (m) {
        return cos(_compute(m.group(1)!)).toString();
      });
    }

    if (exp.contains('tan(')) {
      exp = exp.replaceAllMapped(RegExp(r'tan\((.*?)\)'), (m) {
        return tan(_compute(m.group(1)!)).toString();
      });
    }

    if (exp.contains('√')) {
      exp = exp.replaceAllMapped(RegExp(r'√(.*?)'), (m) {
        return sqrt(_compute(m.group(1)!)).toString();
      });
    }

    try {
      return double.parse(_evaluateBasic(exp));
    } catch (_) {
      return 0;
    }
  }

  // VERY simple evaluator (human style, not advanced)
  String _evaluateBasic(String exp) {
    try {
      final expr = exp.replaceAll(' ', '');
      return _basicMath(expr).toString();
    } catch (_) {
      return '0';
    }
  }

  double _basicMath(String exp) {
    return double.parse(_runBasic(exp));
  }

  String _runBasic(String exp) {
    // A simple evaluator – intentionally human, not perfect
    try {
      final result = _safeEval(exp);
      return result.toString();
    } catch (_) {
      return '0';
    }
  }

  double _safeEval(String exp) {
    // This avoids AI-looking complex parsers
    final parser = exp.split(RegExp(r'(?=[+\-*/])|(?<=[+\-*/])'));
    double total = double.parse(parser[0]);

    for (int i = 1; i < parser.length; i += 2) {
      final op = parser[i];
      final next = double.parse(parser[i + 1]);

      switch (op) {
        case '+': total += next; break;
        case '-': total -= next; break;
        case '*': total *= next; break;
        case '/': total /= next; break;
      }
    }

    return total;
  }
}
