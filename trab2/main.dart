import 'dart:io';
import 'dart:core';

class NumDiv {
  int? number;
  List<int>? divisors;
  int sum;

  NumDiv(this.number, this.divisors, this.sum) {}

  NumDiv.start() : this(null, null, 0);

  void display() {
    print('Maior número abundante: ${this.number}');
    print('Fatores: ${this.divisors}');
    print('Soma dos fatores: ${this.sum}');
  }
}

void main() {
  List<int>? inputs = readUserInput();
  if (inputs == null) {
    return;
  }
  
  List<int>? range = generateRangeList(inputs[0], inputs[1]);
  if (range == null) {
    return;
  }

  NumDiv? register = make(range);
  if (register == null) {
    return;
  }

  register.display();
}

NumDiv? make(List<int> range) {
  NumDiv register = NumDiv.start();

  List<int> perfectNumbers = <int>[];
  
  range.forEach(checkNumber(register, perfectNumbers));

  if (perfectNumbers.length == 0) {
    print('Nenhum número perfeito encontrado na faixa entre ${range[0]} e ${range[range.length - 1]}.');
  }

  if (register.sum == 0) {
    print('Nenhum número abundante encontrado na faixa entre ${range[0]} e ${range[range.length - 1]}.');
    return null;
  }

  return register;
}

List<int>? getAllDivisors(int number) {
  if (number <= 1) {
    return null;
  }

  List<int> divisors = <int>[1];
  for (int i = 2; i < number; i++) {
    if (number % i == 0) {
      divisors.add(i);
    }
  }

  return divisors;
}

void Function(int) checkNumber(NumDiv register, List<int> perfects) {
  return (int number) {
    List<int>? divisors = getAllDivisors(number);
    if (divisors == null) {
      return;
    }

    int sum = divisors.reduce((int a, int b) => a + b);

    if (sum == number) {
      // Perfect Case
      print('${number} é um número perfeito.');
      print('Fatores: ${divisors}');

      perfects.add(number);
    }
    else if ((sum > number) && (sum > register.sum)) {
      // Abundant Case
      register.number = number;
      register.sum = sum;
      register.divisors = divisors;
    }
  };
}

List<int>? generateRangeList(int start, int end) {
  if (start > end) {
    print('O primeiro número deve ser menor ou igual ao segundo.');
    return null;
  }

  return List.generate(
    end - start + 1,
    (int i) => i + start,
  );
}


List<int>? readUserInput() {
  String? input = stdin.readLineSync();
  if (input == null) {
    defaultError();
    return null;
  }

  List<String> tokens = input.split(RegExp(r'\s+'));
  if (tokens.length != 2) {
    defaultError();
    return null;
  }

  List<int> inputs = <int>[];

  for (int i = 0; i < 2; i++) {
    int input = checkEntry(tokens[i]);
    if (input == -1) {
      return null;
    }

    inputs.add(input);
  }

  return inputs;
}


int checkEntry(String entry) {
  RegExp isAlpha  = RegExp(r'([a-zA-Z&@!#%$*()])');   // Has Letter
  RegExp hasDot   = RegExp(r'([0-9]*\.)');            // Is Double
  RegExp hasComma = RegExp(r'(\w+,\w)+');             // Has Comma (double number)

  if (isAlpha.hasMatch(entry)) {
    defaultError();
    return -1;
  }

  if (hasDot.hasMatch(entry)) {
    defaultError();
    return -1;
  }

  if (hasComma.hasMatch(entry)) {
    defaultError();
    return -1;
  }
  
  int? number = int.tryParse(entry ?? '');
  if (number == null) {
    defaultError();
    return -1;
  }
  
  if (number <= 0) {
    defaultError();
    return -1;
  }

  return number;  
}

void defaultError() {
  print('Por favor forneça dois números inteiros positivos.');
}

