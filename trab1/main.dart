import 'dart:io';
import 'dart:math';
import 'dart:core';

void main() {
  int number = readIntNumber();

  if (number == -1) {
    return;
  }

  if (isPrime(number)) {
    print('É primo!');
  } else {
    print('Não é primo!');
  }
}

int readIntNumber() {
  String? input = stdin.readLineSync();

  RegExp isAlpha  = RegExp(r'([a-zA-Z&@!#%$*()])');   // Has Letter
  RegExp hasDot   = RegExp(r'([0-9]*\.)');            // Is Double
  RegExp hasComma = RegExp(r'(\w+,\w)+');             // Has Comma (double number)

  if (input == null) {
    print('Entrada vazia!');
    return -1;
  }

  if (isAlpha.hasMatch(input)) {
    print('Não é um número!');
    return -1;
  }

  if (hasDot.hasMatch(input)) {
    print('Não é inteiro!');
    return -1;
  }

  if (hasComma.hasMatch(input)) {
    print('Formato numérico inválido!');
    return -1;
  }
  
  int? number = int.tryParse(input ?? '');
  if (number == null) {
    print('Entrada vazia!');
    return -1;
  }
  
  if (number <= 0) {
    print('Número negativo!');
    return -1;
  }

  return number;  
}

bool isPrime(int number) {
  if (number == 1) {
    return false;
  }
  
  double limit = sqrt(number);

  for (int i = 2; i <= limit; i++) {
    if (number % i == 0) {
      return false;
    }
  }

  return true;
}

