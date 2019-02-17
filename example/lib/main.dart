import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'store.dart';
import 'app.dart';

// -----

void main() {
  // Dva.ReducerWatcher().delegate = MyReducerDelegate();

  runApp(new MyApp(store));
}
