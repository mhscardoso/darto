import 'dart:io';
import 'dart:core';

class NumDiv {
  int? number;
  List<int>? divisors;
  int sum;
  int perfectNumbersCount;

  NumDiv(
    this.number,
    this.divisors,
    this.sum,
    this.perfectNumbersCount,
  ) {}

  NumDiv.start() : this(null, null, 0, 0);

  void display() {
    print('Maior número abundante: ${this.number}');
    print('Fatores: ${this.divisors}');
    print('Soma dos fatores: ${this.sum}');
  }

  void updateAbundantInfo(int number, List<int> divisors, int sum) {
    this.number   = number;
    this.divisors = divisors;
    this.sum      = sum;
  }

  void updatePerfectInfo(int number, List<int> divisors) {
    this.perfectNumbersCount++;
    print('${number} é um número perfeito.');
    print('Fatores: ${divisors}');
  }

  void Function(int) checkNumber() {
    return (int number) {
      List<int>? divisors = getAllDivisors(number);
      if (divisors == null) {
        return;
      }

      int sum = divisors.reduce((int a, int b) => a + b);

      if (sum == number) {
        this.updatePerfectInfo(number, divisors);
      }
      else if ((sum > number) && (sum > this.sum)) {
        this.updateAbundantInfo(number, divisors, sum);
      }
    };
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
  range.forEach(register.checkNumber());

  if (register.perfectNumbersCount == 0) {
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
  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) {
      divisors.add(i);
    }
  }

  return divisors;
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

  for (final token in tokens) {
    int input = checkEntry(token);
    if (input == -1) {
      return null;
    }

    inputs.add(input);
  }

  return inputs;
}


int checkEntry(String entry) {
  RegExp isAlpha = RegExp(r'([a-zA-Z&@!#%$*(),\.])');
  
  if (isAlpha.hasMatch(entry)) {
    defaultError();
    return -1;
  }
  
  int? number = int.tryParse(entry ?? '');
  if ((number == null) || (number <= 0)) {
    defaultError();
    return -1;
  }

  return number;  
}

void defaultError() {
  print('Por favor forneça dois números inteiros positivos.');
}

