// 1) Написать функцию, которая проверяет строку на палиндром.

bool checkPalindrome(String? p) => p != null && p.isNotEmpty && _compare(p);

bool _compare(String source) {
  List<String> elements = source.split('');
  for (int i = 0; i < elements.length / 2; i++) {
    if (elements[i] != elements[elements.length - 1 - i]) {
      return false;
    }
  }
  return true;
}

// 2) Написать функцию, которая удаляет из всей строки заданный символ.

String removeSub(String source, String symbol) => source.replaceAll(symbol, '');

// 3) Написать функцию, которая возвращает количество простых чисел до числа N.

int countSimple(int n) => n < 1
    ? 0
    : [for (int i = 2; i <= n; i++) i].where((e) => _isPrime(e)).length;

bool _isPrime(int n) {
  for (var i = 2; i <= n / i; ++i) {
    if (n % i == 0) {
      return false;
    }
  }
  return true;
}

// 4) Написать рекурсивную функцию, которая возвращает последовательность чисел Фибоначчи до числа N.

List<int> fibonacci(int n) {
  if (n <= 0) {
    return [];
  } else if (n == 1) {
    return [1, 1];
  } else {
    List<int> seq = [];
    _fillSequence(seq, n, n);
    return [1, 1, ...seq];
  }
}

void _fillSequence(List<int> seq, int initN, int n) {
  if (n < 3) {
    if (initN == 2) seq.insert(0, initN);
    if (initN == 3) seq.insert(seq.length, initN);
    return;
  }
  int result = _fibonacciPosition(n);
  if (result <= initN) seq.insert(0, result);
  _fillSequence(seq, initN, n - 1);
}

int _fibonacciPosition(int n) {
  if (n == 1 || n == 2) {
    return 1;
  }
  return _fibonacciPosition(n - 1) + _fibonacciPosition(n - 2);
}

// 5) Написать функцию, которая возвращает первый неповторяющийся символ в строке – если такого нет, то возвращает null.

String? findFirstUnique(String source) {
  List<String> list = source.split('');
  for (var el in list) {
    if (list.where((e) => e == el).length == 1) {
      return el;
    }
  }
  return null;
}

// 6) Написать функцию, которая возвращает количество рабочих дней в текущем месяце.

int countWeekdays(DateTime dateTime) {
  var date = DateTime(dateTime.year, dateTime.month + 1, 0);
  int maxDay = date.day;

  int weekendDays = 0;
  for (int day = 1; day <= maxDay; day++) {
    int weekday = DateTime(dateTime.year, dateTime.month, day).weekday;
    if (weekday == 6 || weekday == 7) {
      weekendDays++;
    }
  }

  return maxDay - weekendDays;
}

/*
7) Напишите функцию извлечения квадратного корня, не пользуясь 
встроенными в язык средствами нахождения корня и возведения в степень.
*/

double calculateSQRT(int number) {
  double t = 0;
  double squareRoot = number / 2;
  do {
    t = squareRoot;
    squareRoot = (t + (number / t)) / 2;
  } while ((t - squareRoot) != 0);
  return squareRoot;
}

/*
8) Написать функцию, которая принимает строку и возвращает 
список email'ов, которые содержатся в данной строке.
*/

List<String> lookForEmails(String source) {
  RegExp regExp = RegExp("[\\[](.*?)[)\\]]");
  var matches = regExp.allMatches(source);
  var emails = <String>[];
  for (var match in matches) {
    emails.add(match.group(1) ?? '');
  }
  return emails;
}

/*
9) Написать функцию, которая проверяет на валидность 
CCN (credit card number) и возвращает true если CCN валиден.

A credit card number must have between 13 and 16 digits. It must start with:

4 for Visa cards
5 for Master cards
37 for American Express cards
6 for Discover cards
*/

bool isValidCCN(String number) =>
    (number.startsWith('4') ||
        number.startsWith('5') ||
        number.startsWith('37') ||
        number.startsWith('6')) &&
    (number.length >= 13 && number.length <= 16) &&
    _checkLuhn(number);

bool _checkLuhn(String number) {
  List<String> digits = number.split('');
  int sum = 0;
  bool isSecond = false;
  for (int i = digits.length - 1; i >= 0; i--) {
    try {
      int digit = int.parse(digits[i]);
      if (isSecond) digit *= 2;
      sum += digit ~/ 10;
      sum += digit % 10;
      isSecond = !isSecond;
    } on FormatException {
      return false;
    }
  }
  return sum % 10 == 0;
}

/*
10) Написать функцию, которая возвращает результат арифметической операции, 
заданной в виде строки (например, 2+4*7+2/4). Доступные арифметические операции: 
умножение, сложение, вычитание и деление. Если введенная строка не 
соответствует правильному формату, то нужно выбрасывать исключение.

* Реализовать возможность использования скобок ()
*/

String calculate(String expression) {
  if (expression.isEmpty) throw Exception('Empty expression!!!');

  if (expression.startsWith('-')) expression = '0$expression';
  if (expression.endsWith(')')) expression = '$expression+0';

  if (!_isValid(expression)) throw Exception('Incorrect math expression!!!');

  expression = _simplyExpression(expression);

  RegExp regExp = RegExp("[*/+-]");
  List<String> values = expression.split(regExp);
  regExp = RegExp("[0-9.]");
  List<String> operations = expression.replaceAll(regExp, '').split('');

  // * and / operations
  while (operations.contains('*') || operations.contains('/')) {
    int i = operations.indexOf('*');
    if (i == -1) i = operations.indexOf('/');

    String value = _operate(values[i], values[i + 1], operations[i]);
    values.removeAt(i);
    values[i] = value;
    operations.removeAt(i);
  }

  // + and - operations
  while (values.length != 1) {
    String value = _operate(values[0], values[1], operations[0]);
    values.removeAt(0);
    values[0] = value;
    operations.removeAt(0);
  }

  return values[0];
}

bool _isValid(String expression) {
  // Don't start expression with signs
  RegExp regExp = RegExp('[*/+]');
  if (expression.startsWith(regExp)) return false;

  // It has contains only 0-9 and + - * / .
  regExp = RegExp(r'[0-9*/+-]+$');
  if (!regExp.hasMatch(expression)) return false;

  // Don't let more than two signs in a row
  List<String> oper = ['+', '-', '*', '/'];
  for (int i = 0; i < oper.length; i++) {
    for (int j = 0; j < oper.length; j++) {
      if (expression.contains('${oper[i]}${oper[j]}')) return false;
    }
  }

  return true;
}

String _simplyExpression(String expression) {
  while (RegExp('[()]').hasMatch(expression)) {
    try {
      int lastOpenBracket = expression.lastIndexOf('(');
      int firstCloseBracket = expression.indexOf(')', lastOpenBracket);
      String subExpression =
          expression.substring(lastOpenBracket + 1, firstCloseBracket);
      expression = expression.replaceRange(
          lastOpenBracket, firstCloseBracket + 1, calculate(subExpression));
    } on RangeError {
      throw Exception('Incorrect math expression!!!');
    }
  }
  return expression;
}

String _operate(String value1, String value2, String operator) {
  num result = 0;
  num v1 = num.parse(value1);
  num v2 = num.parse(value2);
  if (v2 == 0 && operator == '/') throw Exception('Zero division error!');
  switch (operator) {
    case '+':
      result = v1 + v2;
      break;
    case '-':
      result = v1 - v2;
      break;
    case '*':
      result = v1 * v2;
      break;
    case '/':
      result = v1 / v2;
      break;
  }
  return '$result';
}
