class CalculatorLogic {
  String _expression = '';

  void setExpression(String expression) {
    _expression = expression;
  }

  void clear() {
    _expression = '';
  }

  String calculateExpression() {
    try {
      // Use the 'dart:math' library to perform the calculation
      // You can extend this logic to support more complex expressions
      // For simplicity, this example handles basic arithmetic operations
      return _evaluateExpression();
    } catch (e) {
      return 'Error';
    }
  }

  String _evaluateExpression() {
    // Replace 'x' with '*' for multiplication
    String cleanedExpression = _expression.replaceAll('x', '*');
    // Use the 'dart:math' library to evaluate the expression
    double result = eval(cleanedExpression);
    return result.toString();
  }

  // Basic arithmetic evaluation
  double eval(String expression) {
    List<String> operators = ['+', '-', '*', '/'];
    for (String operator in operators) {
      List<String> parts = expression.split(operator);
      if (parts.length > 1) {
        double left = eval(parts[0]);
        double right = eval(parts[1]);
        switch (operator) {
          case '+':
            return left + right;
          case '-':
            return left - right;
          case '*':
            return left * right;
          case '/':
            return left / right;
        }
      }
    }
    return double.parse(expression); // If no operator is found, parse the expression
  }
}
