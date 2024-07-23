import 'package:flutter/foundation.dart';

import 'calculator_action.dart';

class CalculatorNotifier extends ChangeNotifier {
  String firstNumber = '0';
  String secondNumber = '';
  String action = '';
  CalculatorAction? calculatorAction;
  bool hasAction = false;
  String firstHistoryNumber = '';
  List<String> historyList = [];

  void increment() {
    if (hasAction == true) {
      makeAction();
    }
    calculatorAction = CalculatorAction.increment;
    action = '+';
    hasAction = true;
    notifyListeners();
  }

  void reduce() {
    if (hasAction == true) {
      makeAction();
    }
    calculatorAction = CalculatorAction.reduce;
    action = '-';
    hasAction = true;
    notifyListeners();
  }

  void multiple() {
    if (hasAction == true) {
      makeAction();
    }
    calculatorAction = CalculatorAction.multiple;
    action = '*';
    hasAction = true;
    notifyListeners();
  }

  void divide() {
    if (hasAction == true) {
      makeAction();
    }
    calculatorAction = CalculatorAction.divide;
    action = ':';
    hasAction = true;
    notifyListeners();
  }

  void getPercent() {
    if (secondNumber == '' || secondNumber == '0') {
      double number = double.tryParse(firstNumber) ?? 0;
      number = number / 100;
      firstNumber = number.toStringAsFixed(2);
      if (number % 1 == 0.0) {
        firstNumber = number.toStringAsFixed(0);
      } else if (number % 0.1 == 0.0) {
        firstNumber = number.toStringAsFixed(1);
      }
    } else {
      double number = double.tryParse(secondNumber) ?? 0;
      number = number / 100;
      secondNumber = number.toStringAsFixed(2);
      if (number % 1 == 0.0) {
        secondNumber = number.toStringAsFixed(0);
      } else if (number % 0.1 == 0.0) {
        secondNumber = number.toStringAsFixed(1);
      }
    }
    notifyListeners();
  }

  void removeAll() {
    firstNumber = '0';
    secondNumber = '';
    action = '';
    hasAction = false;
    historyList = [];
    notifyListeners();
  }

  void remove() {
    if (secondNumber.isNotEmpty) {
      secondNumber = secondNumber.substring(0, secondNumber.length - 1);
      if (firstNumber == '') firstNumber = '0';
    } else if (action.isNotEmpty) {
      action = '';
      hasAction = false;
    } else if (firstNumber.isNotEmpty) {
      firstNumber = firstNumber.substring(0, firstNumber.length - 1);
      if (firstNumber == '') firstNumber = '0';
    }
    notifyListeners();
  }

  void getFractionalNumber() {
    if (hasAction == false) {
      if (firstNumber.isNotEmpty) {
        if (firstNumber.contains('.') == false) {
          firstNumber += '.';
        }
      }
    } else {
      if (secondNumber.isNotEmpty) {
        if (secondNumber.contains('.') == false) {
          secondNumber += '.';
        }
      }
    }
    notifyListeners();
  }

  void equal() {
    if (firstNumber.lastIndexOf('.') == firstNumber.length) {
      firstNumber = firstNumber.substring(0, firstNumber.length - 1);
    }
    if (secondNumber.lastIndexOf('.') == secondNumber.length) {
      secondNumber = secondNumber.substring(0, secondNumber.length - 1);
    }
    makeAction();
    hasAction = true;
    action = '';
    notifyListeners();
  }

  void makeAction() {
    if (secondNumber != '') {
      double firstNum = double.tryParse(firstNumber) ?? 0;
      double secondNum = double.tryParse(secondNumber) ?? 0;
      double result = switch (calculatorAction) {
        CalculatorAction.increment => firstNum + secondNum,
        CalculatorAction.reduce => firstNum - secondNum,
        CalculatorAction.multiple => firstNum * secondNum,
        CalculatorAction.divide => firstNum / secondNum,
        null => firstNum,
      };
      firstHistoryNumber = firstNumber + action + secondNumber;

      historyList.add(firstNumber + action + secondNumber);
      secondNumber = '';
      action = '';

      firstNumber = result.toStringAsFixed(2);
      if (result % 1 == 0.0 && result != 0.0) {
        firstNumber = result.toStringAsFixed(0);
      }
      calculatorAction = null;
      notifyListeners();
    }
  }

  void addNumber(int number) {
    if (!hasAction) {
      addFirstNumber(number);
    } else {
      addSecondNumber(number);
    }
    notifyListeners();
  }

  void addFirstNumber(int number) {
    if (firstNumber != '0') {
      firstNumber += '$number';
    } else if (firstNumber == '0') {
      firstNumber = '$number';
    }
    notifyListeners();
  }

  void addSecondNumber(int number) {
    if (secondNumber != '0') {
      secondNumber += '$number';
    } else if (secondNumber == '0') {
      secondNumber = '$number';
    }
    notifyListeners();
  }
}
