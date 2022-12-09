// ignore_for_file: depend_on_referenced_packages

import 'package:test/test.dart';
import 'tasks.dart';

main() {
  test("Taks 1 - Palindrome", () {
    expect(checkPalindrome('AABAA'), equals(true));
    expect(checkPalindrome('AABBA'), equals(false));
    expect(checkPalindrome('123456'), equals(false));
    expect(checkPalindrome(''), equals(false));
    expect(checkPalindrome(null), equals(false));
    expect(checkPalindrome('123456654321'), equals(true));
    expect(checkPalindrome('123456787654321'), equals(true));
    expect(checkPalindrome('12345677654321'), equals(true));
    expect(checkPalindrome('aabAa'), equals(false));
  });

  test("Task 2 - Removing", () {
    expect(removeSub('Hell234o world234234!', '234'), equals('Hello world!'));
    expect(removeSub('qwertytytytytytyty', 'ty'), equals('qwer'));
    expect(removeSub('LOLOL', '8'), equals('LOLOL'));
    expect(removeSub('uuyuuyuuyuuyuuy', 'y'), equals('uuuuuuuuuu'));
    expect(removeSub('Dietrich', 'd'), equals('Dietrich'));
    expect(removeSub('Dietrich', 'D'), equals('ietrich'));
  });

  test("Task 3 - Simple count", () {
    expect(countSimple(10), equals(4));
    expect(countSimple(-2), equals(0));
    expect(countSimple(0), equals(0));
    expect(countSimple(1), equals(0));
    expect(countSimple(20), equals(8));
    expect(countSimple(100), equals(25));
    expect(countSimple(98), equals(25));
    expect(countSimple(99), equals(25));
    expect(countSimple(1000), equals(168));
    expect(countSimple(9000), equals(1117));
  });

  test("Task 4 - Fibonacci", () {
    expect(createFibSequence(3), equals([1, 1, 2, 3]));
    expect(createFibSequence(4), equals([1, 1, 2, 3]));
    expect(createFibSequence(5), equals([1, 1, 2, 3, 5]));
    expect(createFibSequence(6), equals([1, 1, 2, 3, 5]));
    expect(createFibSequence(7), equals([1, 1, 2, 3, 5]));
    expect(createFibSequence(8), equals([1, 1, 2, 3, 5, 8]));
    expect(createFibSequence(9), equals([1, 1, 2, 3, 5, 8]));
    expect(createFibSequence(2), equals([1, 1, 2]));
    expect(createFibSequence(1), equals([1, 1]));
    expect(createFibSequence(0), equals([]));
    expect(createFibSequence(-1), equals([]));
    expect(createFibSequence(40), equals([1, 1, 2, 3, 5, 8, 13, 21, 34]));
  });

  test("Task 5 - The first unique symbol", () {
    expect(findFirstUnique("qqqwwwaeweee"), equals('a'));
    expect(findFirstUnique("popcorn"), equals('c'));
    expect(findFirstUnique("&&&&34]]]]]]"), equals('3'));
    expect(findFirstUnique("JJaaammees Alexs"), equals(' '));
    expect(findFirstUnique("JJaaammeesAlexs"), equals('A'));
    expect(findFirstUnique("1122334455"), equals(null));
    expect(findFirstUnique(""), equals(null));
  });

  test("Task 6 - Weekdays", () {
    expect(countWeekdays(DateTime(2022, 11)), equals(22));
    expect(countWeekdays(DateTime(2022, 12)), equals(22));
    expect(countWeekdays(DateTime(2023, 1)), equals(22));
    expect(countWeekdays(DateTime(2023, 2)), equals(20));
    expect(countWeekdays(DateTime(2023, 3)), equals(23));
    expect(countWeekdays(DateTime(2020, 8)), equals(21));
  });

  test("Task 7 - SQRT", () {
    expect(calculateSQRT(16), equals(4));
    expect(calculateSQRT(4), equals(2));
    expect(calculateSQRT(1), equals(1));
    expect(calculateSQRT(256), equals(16));
    expect(calculateSQRT(25), equals(5));
    expect(calculateSQRT(125), equals(11.180339887498949));
    expect(calculateSQRT(3), equals(1.7320508075688772));
  });

  test("Task 8 - List of emails", () {
    expect(lookForEmails('''
sdafljkldafjljqwertt[quick@gmail.com]
presentation   [mail@mail.by]
education [pro@bsuir.by]
'''), equals(['quick@gmail.com', 'mail@mail.by', 'pro@bsuir.by']));
  });

  test("Task 9 - CCN validation", () {
    expect(isValidCCN('379354508162306'), equals(true));
    expect(isValidCCN('4388576018402626'), equals(false));
    expect(isValidCCN('389354508162306'), equals(false));
    expect(isValidCCN('119354508162306'), equals(false));
    expect(isValidCCN('6363570812'), equals(false));
    expect(isValidCCN('63634325464325570812'), equals(false));
    expect(isValidCCN('3793545081623o6'), equals(false));
    expect(isValidCCN('5196081888500645'), equals(true));
    expect(isValidCCN('371449635398431'), equals(true));
    expect(isValidCCN('30569309025904'), equals(false));
    expect(isValidCCN('6011111111111117'), equals(true));
    expect(isValidCCN('3530111333300000'), equals(false));
    expect(isValidCCN('5555555555554444'), equals(true));
    expect(isValidCCN('4111111111111111'), equals(true));
  });

  test("Task 10 - Arithmetic operations", () {
    expect(calculate('2+2'), equals('4'));
    expect(calculate('2+2*2'), equals('6'));
    expect(calculate('(2+2)*2'), equals('8'));
    expect(calculate('2+4*7+2/4'), equals('30.5'));
    expect(calculate('10/4'), equals('2.5'));
    expect(calculate('5*(6+(13-9))'), equals('50'));
    expect(calculate('1+2-3*4/5'), equals('0.6000000000000001'));
    expect(calculate('2.+3'), equals('5.0'));
    expect(calculate('2.5/0.5'), equals('5.0'));
    expect(calculate('1+2*3*4*5*6*7'), equals('5041'));
    expect(calculate('-3*6+24'), equals('6'));
    expect(calculate('.5+0.5'), equals('1.0'));
    expect(calculate('(2)'), equals('2'));
    expect(calculate('(2+2)'), equals('4'));
    expect(calculate('((2+1)+2)*(3-1*(2-1))'), equals('10'));
  });
}
