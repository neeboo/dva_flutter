import 'package:dva_dart/dva_dart.dart' as Dva;

class CounterState implements Dva.State<int> {
  final int counter;
  CounterState(this.counter);
}

class CounterString implements Dva.State<String> {
  final String counter;
  CounterString(this.counter);
}
