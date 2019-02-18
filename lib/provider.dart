import 'package:flutter/material.dart';
import 'package:dva_dart/dva_dart.dart';

abstract class DvaBase {
  void dispose();
}

// Modify bloc to Dva extends dva.DvaStore
class DvaProvider<T extends DvaStore> extends StatefulWidget {
  DvaProvider({
    Key key,
    @required this.child,
    @required this.store,
  }) : super(key: key);

  final T store;
  final Widget child;

  @override
  _DvaProviderState<T> createState() => _DvaProviderState<T>();

  static T of<T extends DvaStore>(BuildContext context) {
    final type = _typeOf<DvaProvider<T>>();
    DvaProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.store;
  }

  static Type _typeOf<T>() => T;
}

class _DvaProviderState<T> extends State<DvaProvider<DvaStore>> {
  @override
  void dispose() {
    widget.store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
