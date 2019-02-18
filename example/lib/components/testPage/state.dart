import 'package:dva_dart/dva_dart.dart';

class CounterState implements DvaState<int> {
  final int counter;
  CounterState(this.counter);
}

class CounterString implements DvaState<String> {
  final String counter;
  CounterString(this.counter);
}
